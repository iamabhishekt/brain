#!/usr/bin/env bash
# ==============================================================================
# check-vendored-skills.sh — drift report for git-vendored agent skills
#
# Vendored skills are pinned to an upstream commit and copied into the workspace.
# Upstream keeps moving. This script reports drift. It never applies an update.
#
# Usage:
#   bash brain/scripts/check-vendored-skills.sh          # report only
#   bash brain/scripts/check-vendored-skills.sh --quiet  # exit code only
#
# Exit codes:
#   0  no drift, local copy matches the pin
#   1  local files differ from the recorded hashes, or upstream has moved
#   2  bad environment (missing tool, missing manifest)
#
# Requires: git, jq, curl, GNU coreutils (sha256sum, find -printf).
# GNU coreutils is required, not optional: BSD/macOS ships shasum and a find
# without -printf, and the script would silently mis-hash there. Checked below.
# ==============================================================================

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRAIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

QUIET=false
[[ "${1:-}" == "--quiet" ]] && QUIET=true

say() { [[ "$QUIET" == true ]] || echo "$@"; }
die() { echo "ERROR: $*" >&2; exit 2; }

for tool in git jq curl sha256sum find sed; do
  command -v "$tool" >/dev/null 2>&1 || die "missing required tool: $tool"
done

# Discover every vendored skill by its manifest, not by a hardcoded list.
mapfile -t MANIFESTS < <(find "$BRAIN_DIR" -name vendor.json -not -path '*/node_modules/*' 2>/dev/null | sort)

[[ ${#MANIFESTS[@]} -gt 0 ]] || die "no vendor.json manifests found under $BRAIN_DIR"

DRIFT=false

for manifest in "${MANIFESTS[@]}"; do
  skill_dir="$(dirname "$manifest")"
  name="$(jq -r '.name' "$manifest")"
  repo="$(jq -r '.source.repo' "$manifest")"
  pinned_commit="$(jq -r '.pinned.commit' "$manifest")"
  pinned_date="$(jq -r '.pinned.commitDate' "$manifest")"
  installed_on="$(jq -r '.pinned.installedOn' "$manifest")"

  say ""
  say "=== $name ==="
  say "  path    : ${skill_dir#"$BRAIN_DIR"/}"
  say "  source  : https://github.com/$repo"
  say "  pinned  : ${pinned_commit:0:12} ($pinned_date)"
  say "  since   : installed $installed_on"

  # 1. Local integrity. Did anyone edit the vendored copy after install?
  local_bad=0
  while read -r rel recorded; do
    [[ -n "$rel" ]] || continue
    target="$skill_dir/$rel"
    if [[ ! -f "$target" ]]; then
      say "  MISSING : $rel"
      local_bad=1
      continue
    fi
    actual="$(sha256sum "$target" | cut -c1-16)"
    if [[ "$actual" != "$recorded" ]]; then
      say "  MODIFIED: $rel (recorded $recorded, found $actual)"
      local_bad=1
    fi
  done < <(jq -r '.files | to_entries[] | "\(.key) \(.value)"' "$manifest")

  if [[ $local_bad -eq 0 ]]; then
    say "  local   : OK, matches the recorded hashes"
  else
    DRIFT=true
  fi

  # Report local modifications that vendor.json does not know about.
  mapfile -t untracked < <(cd "$skill_dir" && find . -type f \
    -not -name vendor.json -not -name PROVENANCE.md | sed 's|^\./||' | sort | while read -r f; do
      jq -e --arg f "$f" '.files[$f]' "$manifest" >/dev/null 2>&1 || echo "$f"
    done)
  # An untracked file inside a vendored skill is tampering as much as a modified
  # one. Flag it as drift so a --quiet gate actually fails.
  [[ ${#untracked[@]} -gt 0 ]] && { say "  LOCAL   : extra files not in the manifest: ${untracked[*]}"; DRIFT=true; }

  # 2. Upstream drift. Report only. Never pull, never write.
  upstream_commit=""
  if upstream_commit="$(curl -fsSL --max-time 20 \
        "https://api.github.com/repos/$repo/commits?per_page=1" 2>/dev/null | jq -r '.[0].sha' 2>/dev/null)" \
     && [[ -n "$upstream_commit" && "$upstream_commit" != "null" ]]; then
    if [[ "$upstream_commit" == "$pinned_commit" ]]; then
      say "  upstream: no new commits"
    else
      say "  upstream: MOVED -> ${upstream_commit:0:12}  (review manually, do not auto-apply)"
      DRIFT=true
    fi
  else
    say "  upstream: unreachable (offline, rate limited, or repo renamed) — not checked"
  fi

  # 3. Known defects carried by this pin.
  defects="$(jq -r '.knownDefects[]? | "  KNOWN   : \(.file) \(.symbol) — \(.summary)"' "$manifest")"
  [[ -n "$defects" ]] && say "$defects"
done

say ""
if [[ "$DRIFT" == true ]]; then
  say "DRIFT DETECTED. Review each item by hand, then update pinned.commit and files.* in vendor.json."
  exit 1
fi

say "No drift."
exit 0

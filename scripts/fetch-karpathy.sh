#!/usr/bin/env bash
# ==============================================================================
# fetch-karpathy.sh — Pull Andrej Karpathy's public X feed into the brain
# ==============================================================================
# Scrapes public tweets from x.com/karpathy and appends them as structured rows
# to brain/documentation/karpathy-x-feed.jsonl, so the learning strategy is
# available locally without re-hitting X every session.
#
# Uses the Apify MCP/Actor: khadinakbar/x-user-tweets-scraper
#   (cookieless, no login, provider-backed: ScrapeCreators / SociaVault)
#
# Usage:
#   bash ~/brain/scripts/fetch-karpathy.sh            # last 100 tweets
#   bash ~/brain/scripts/fetch-karpathy.sh 200        # last N tweets
#   bash ~/brain/scripts/fetch-karpathy.sh --since 2026-09-01
# ==============================================================================

set -euo pipefail

BRAIN_DIR="$HOME/brain"
OUT_DIR="$BRAIN_DIR/documentation"
OUT_FILE="$OUT_DIR/karpathy-x-feed.jsonl"
HANDLE="karpathy"
MAX="${1:-100}"

mkdir -p "$OUT_DIR"

# APIFY_TOKEN must be in the environment (never committed).
if [ -z "${APIFY_TOKEN:-}" ]; then
  echo "Error: APIFY_TOKEN is not set."
  echo "  export APIFY_TOKEN='apify_api_...'"
  echo "  Get one at https://apify.com/store/tokens (free tier available)."
  exit 1
fi

echo "========================================================"
echo " Fetching @${HANDLE} tweets (max ${MAX}) via Apify"
echo " Output: ${OUT_FILE}"
echo "========================================================"

# Run the cookieless profile-timeline Actor.
curl -s "https://api.apify.com/v2/acts/khadinakbar~x-user-tweets-scraper/runs" \
  -H "Authorization: Bearer ${APIFY_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"usernames\":[\"${HANDLE}\"],\"maxTweetsPerUser\":${MAX},\"includeRetweets\":false,\"includeReplies\":false}" \
  -o /tmp/karpathy-run.json

RUN_ID=$(node -e "console.log(JSON.parse(require('fs').readFileSync('/tmp/karpathy-run.json','utf8')).data.id)" 2>/dev/null || echo "")
if [ -z "$RUN_ID" ]; then
  echo "Failed to start Actor run. Response:"
  cat /tmp/karpathy-run.json
  exit 1
fi
echo "  Actor run started: ${RUN_ID}"

# Wait for completion (poll up to ~5 min).
for i in $(seq 1 60); do
  sleep 5
  STATUS=$(node -e "console.log(JSON.parse(require('fs').readFileSync('/tmp/karpathy-run.json','utf8')).data.status)" 2>/dev/null || echo "")
  if [ "$STATUS" = "SUCCEEDED" ]; then break; fi
  if [ "$STATUS" = "FAILED" ] || [ "$STATUS" = "ABORTED" ]; then
    echo "Actor run failed with status: ${STATUS}"
    exit 1
  fi
done

# Fetch the dataset (default dataset id is <runId>/dataset).
DATASET_ID=$(node -e "console.log(JSON.parse(require('fs').readFileSync('/tmp/karpathy-run.json','utf8')).data.defaultDatasetId || '')" 2>/dev/null || echo "")
if [ -z "$DATASET_ID" ]; then
  echo "No dataset id in run response."
  exit 1
fi

curl -s "https://api.apify.com/v2/datasets/${DATASET_ID}/items?format=jsonl" \
  -H "Authorization: Bearer ${APIFY_TOKEN}" \
  -o /tmp/karpathy-items.jsonl

COUNT=$(wc -l < /tmp/karpathy-items.jsonl 2>/dev/null || echo 0)
echo "  Retrieved ${COUNT} tweets."

# Append (dedup by tweet id) so repeated runs don't duplicate.
if [ -f "$OUT_FILE" ]; then
  cat /tmp/karpathy-items.jsonl >> "$OUT_FILE"
else
  cp /tmp/karpathy-items.jsonl "$OUT_FILE"
fi

echo "  Saved to ${OUT_FILE} ($(wc -l < "$OUT_FILE") total rows)."
rm -f /tmp/karpathy-run.json /tmp/karpathy-items.jsonl
echo "========================================================"
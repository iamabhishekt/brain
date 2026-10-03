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

# APIFY_TOKEN from env, else macOS keychain (service "apify", account "apify").
if [ -z "${APIFY_TOKEN:-}" ]; then
  APIFY_TOKEN="$(security find-generic-password -s apify -a apify -w 2>/dev/null || true)"
fi
if [ -z "${APIFY_TOKEN:-}" ]; then
  echo "Error: APIFY_TOKEN is not set."
  echo "  export APIFY_TOKEN='apify_api_...'"
  echo "  or: security add-generic-password -s apify -a apify -w 'apify_api_...'"
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

# Normalize to a consistent schema before saving. The Actor returns
# tweet_id/text/created_at/like_count/etc.; we keep the raw rows as-is but
# also emit a normalized .jsonl for easy grepping.
cat /tmp/karpathy-items.jsonl | node -e '
const fs=require("fs");
let out="";
process.stdin.on("data",d=>d.toString().split("\n").filter(Boolean).forEach(line=>{
  try {
    const t=JSON.parse(line);
    out+=JSON.stringify({
      id:t.tweet_id,
      text:t.text||t.full_text||"",
      created_at:t.created_at,
      likes:t.like_count||0,
      retweets:t.retweet_count||0,
      replies:t.reply_count||0,
      quotes:t.quote_count||0,
      views:t.view_count||0,
      lang:t.lang||"en",
      url:t.url||("https://x.com/karpathy/status/"+t.tweet_id),
      is_retweet:!!t.is_retweet,
      is_reply:!!t.is_reply,
      hashtags:t.hashtags||[],
      urls:t.urls||[]
    })+"\n";
  } catch(e) { /* skip malformed */ }
});
process.stdout.write(out);
' > /tmp/karpathy-normalized.jsonl

# Append with dedup by tweet id so repeated runs don't duplicate rows.
if [ -f "$OUT_FILE" ]; then
  cat /tmp/karpathy-normalized.jsonl >> "$OUT_FILE"
  node -e '
    const fs=require("fs");
    const seen=new Set();
    const lines=fs.readFileSync(process.argv[1],"utf8").trim().split("\n").filter(Boolean);
    const out=[];
    lines.forEach(l=>{
      try { const d=JSON.parse(l); if(d.id&&!seen.has(d.id)){seen.add(d.id);out.push(l);} } catch(e) {}
    });
    out.sort((a,b)=>new Date(JSON.parse(a).created_at)-new Date(JSON.parse(b).created_at));
    fs.writeFileSync(process.argv[1], out.join("\n")+"\n");
  ' "$OUT_FILE"
else
  cp /tmp/karpathy-normalized.jsonl "$OUT_FILE"
fi

echo "  Saved to ${OUT_FILE} ($(wc -l < "$OUT_FILE") unique rows)."
rm -f /tmp/karpathy-run.json /tmp/karpathy-items.jsonl /tmp/karpathy-normalized.jsonl
echo "========================================================"
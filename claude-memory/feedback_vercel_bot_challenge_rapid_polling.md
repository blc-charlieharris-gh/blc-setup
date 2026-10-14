---
name: feedback_vercel_bot_challenge_rapid_polling
description: Polling a client site's vercel.app preview every ~15s trips Vercel's bot challenge (403, x-vercel-mitigated: challenge), which also breaks the Hub audit until it clears
metadata:
  type: feedback
---

2026-10-14: an `until curl ...; sleep 15` loop on arktek-installrhub.vercel.app got every page answering 403 with `x-vercel-mitigated: challenge` (retry-after 30). Browsers just see a check; automated fetches (the Hub's audit, the zip builder) fail until it lifts (a few minutes).

**Why:** a challenged preview makes the audit look broken and can block "Build the files now".
**How to apply:** never poll previews in a loop; wait with one background `sleep N` then a single check; for page-by-page checks space requests (~1s+) and keep the count low. Related: [[reference_client_site_vercel_deploy]].

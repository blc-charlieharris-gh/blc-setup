---
name: reference-ads-synced-at-full-sync-mark
description: "ads_ads status refreshes once a day (03:00 full meta-sync); Hub publishes stamp single rows, so \"last sync\" = sync_runs mode full, not max synced_at"
metadata:
  node_type: memory
  type: reference
  originSessionId: 1ddd785d-d3f8-41b1-93c7-57b74a9ea3c0
  modified: 2026-10-30T19:25:18.312Z
---

- meta-sync runs `mode: full` once a day around 03:00 UK (writes ads_ads status/synced_at); the hourly runs are `mode: today` and touch insights only. So an ad's paused/active status in the Hub can be up to a day old.
- meta-change (publish from the Hub) upserts the new ad row with `synced_at = now`. Any "newest synced_at per client" mark is moved by that single row and makes every other ad look stale.
- Since #2918 (30 Oct 2026) the mark is `sync_runs` (function_name meta-sync, status success, metadata->>mode = 'full'), read by `lib/metaSyncNow readLastFullSyncs` and passed to `lib/matcherFreshness`. New staleness checks should use it too.
- Test spend on Creative Testing runs to yesterday; a test launched in the evening shows a tiny first day (Gas Worx £1 on 29 Oct was 2½ hours). Not a bug.

Related: [[feedback-results-end-yesterday-orders-live]]

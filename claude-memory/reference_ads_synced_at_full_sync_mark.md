---
name: reference-ads-synced-at-full-sync-mark
description: "ads_ads status refreshes hourly since 11-02 (was 03:00 only); Hub publishes stamp single rows, so \"last sync\" = sync_runs mode full, not max synced_at"
metadata:
  node_type: memory
  type: reference
  originSessionId: 1ddd785d-d3f8-41b1-93c7-57b74a9ea3c0
  modified: 2026-10-30T19:25:18.312Z
---

- meta-sync runs `mode: full` once a day around 03:00 UK. Since 2 Nov 2026 (#2992) the hourly `mode: today` runs ALSO write campaigns, ad sets and ads (status, synced_at), so a status is at most an hour old (repo memory reference_meta_sync_hourly_structure). The full-run mark below still holds: every hourly row is newer than it.
- meta-change (publish from the Hub) upserts the new ad row with `synced_at = now`. Any "newest synced_at per client" mark is moved by that single row and makes every other ad look stale.
- Since #2918 (30 Oct 2026) the mark is `sync_runs` (function_name meta-sync, status success, metadata->>mode = 'full'), read by `lib/metaSyncNow readLastFullSyncs` and passed to `lib/matcherFreshness`. New staleness checks should use it too.
- Test spend on Creative Testing runs to yesterday; a test launched in the evening shows a tiny first day (Gas Worx £1 on 29 Oct was 2½ hours). Not a bug.

Related: [[feedback-results-end-yesterday-orders-live]]

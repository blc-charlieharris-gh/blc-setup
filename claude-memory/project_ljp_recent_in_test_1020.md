---
name: project_ljp_recent_in_test_1020
description: "LJP 19/10 ad set on \"living in or recently in\" as a 7-day test from 2026-10-20, review 2026-10-27"
metadata:
  node_type: memory
  type: project
  originSessionId: c0377467-13dd-467a-9122-64c4e00167c5
  modified: 2026-10-20T14:12:28.969Z
---

2026-10-20 ~15:30: LJP ad set 120254458291260079 (campaign 120254458290890079) moved from home-only to ["home","recent"]; only that field changed, 128 sectors + exclusions untouched. Hub note logged. Backup of prior targeting: run `ljp_recent_test.py` logic in reverse (set location_types ["home"]).

Baseline (home-only): audience ~371-437k, LJP leads 2-4/week since the 10-06 area cut, interests-only targeting with Advantage+ audience off.

**Why:** Charlotte felt living-in-only ([[feedback_living_in_only_api_only]]) was hurting reach; data said no, LJP chosen as it struggles most and the ad set was 1 day old.
**How to apply:** on/after 10-27 compare reach, leads and out-of-area postcode share vs the prior week, then ask her keep or revert. She said "you can make meta changes" (10-20): Meta API writes are approved, still log each in the Hub.

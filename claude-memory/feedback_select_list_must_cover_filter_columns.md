---
name: select-list-must-cover-filter-columns
description: A JS filter reading a column the SELECT left out sees undefined and can drop every row silently; Tag the live ad listed nothing 10-09..10-15
metadata:
  type: feedback
---

lib/liveAds loadClientCampaigns selected `id, name, status, is_tracked, lead_role` from ads_campaigns, then ran testableCampaigns(rows, clientsById), which looks up each row's client by `client_id`. With no client_id, every lookup gave null, isTestableCampaign(c, null) said "client not tracked", and every campaign was dropped. Tag the live ad showed "No live ads here yet. Meta syncs overnight" for every client for 6 days. Charlotte and I first blamed the overnight sync. Fixed in #1975 by adding client_id, with a test whose fake DB returns only the selected columns.

**Why:** PostgREST returns only what's selected; a missing field is `undefined`, not an error. A filter treating "unknown" as "no" fails closed and silently. It's the opposite trap to [[postgrest-column-select-gate]] (an unknown column 400s the fetch).
**How to apply:** when a helper filters rows by a field, check the caller's select list includes it. When an "empty" message blames sync, verify the rows exist in the DB (ads_ads, status, synced_at) before accepting sync as the cause. Tests that mock the DB should return only the requested columns.

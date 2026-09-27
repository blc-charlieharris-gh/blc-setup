---
name: feedback-dont-mix-rpc-naive-baselines
description: "Never add one RPC's correction delta onto a DIFFERENT RPC's \"naive\" number without first proving the two naive baselines actually agree"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6afa6b76-d4db-4f2b-8ece-8808aed93615
  modified: 2026-08-27T12:30:27.413Z
---

marketing-agent, 2026-08-27 (PR #708, after #704/#705 shipped and were reported still wrong).
`CampaignsTable.jsx` needed a true survey count per client. `ad_windowed_totals(p_client_id,...)`
already computes a `leads_booked` DELTA (true count minus its own internal naive count) when called
per-client. The fix took `campaign_windowed_totals`'s `booked_14d` (a DIFFERENT RPC's own naive
number, computed via a completely separate code path) and added `ad_windowed_totals`' delta onto
it, assuming both RPCs' "naive" figure for the same client/window meant the same thing.

They didn't. Verified directly against live data: for Arktek, over the identical 14-day window,
`campaign_windowed_totals.booked_14d` = 8 while `ad_windowed_totals`' own internal naive total = 10.
Adding the second RPC's delta (relative to ITS 10) onto the first RPC's 8 silently baked in a
2-survey error — reported as fixed, shipped, and was still wrong when checked against the DB.

**Why this is easy to miss:** both numbers are called "naive attribution for this client/window" in
comments and conversation, so treating them as interchangeable feels safe. They're computed by
independently-evolved SQL in two different functions and there is no guarantee — and in this case,
no actual fact — that they agree.

**How to apply:** before combining a delta/correction from RPC A with a baseline number from RPC B,
run both directly against the DB for the same real client + window and diff them. If they don't
match, don't try to reconcile the mismatch with more arithmetic — pull the ENTIRE final number from
ONE RPC's own internal accounting (e.g., sum every row a single scoped call returns) so it's
self-consistent end to end, never touching the other RPC's separate baseline at all. This applies
generally: any time two different backend computations claim to represent "the same" naive/base
figure, verify it, don't assume it, especially before combining a correction from one onto the
other.

Related: [[feedback_verify_dont_trust_search_snippets]] (same discipline: read the hard number from
source, don't assume two things that sound the same are the same).

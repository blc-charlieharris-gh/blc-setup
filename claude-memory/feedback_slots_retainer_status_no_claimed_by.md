---
name: slots-retainer-status-no-claimed-by
description: "slots.status='retainer' never populates claimed_by, tripped up two survey-attribution fixes in ad_windowed_totals before landing on the right rule"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d06e34c2-9e81-43d0-84da-76f7fcb1199a
  modified: 2026-08-17T13:31:39.775Z
---

`slots.claimed_by` is ONLY populated by the open-marketplace claim flow (`status='claimed'`). A
retainer-booked lead (`booking_type='retainer'`, `leads.retainer_client_name` set) gets `slots.status
= 'retainer'` instead, bypassing the claim system entirely — `claimed_by` stays NULL forever, even
though the survey genuinely was delivered to that client.

**Why: two real mistakes this cost.** Fixing Arktek's survey-count bug (2026-08-17), the first
attempt gated "was this actually delivered" on `claimed_by = company_id`. That correctly excluded a
genuinely-unclaimed lead (Mark Smith, `status='available'`), but ALSO wrongly excluded Arktek's own
real retainer bookings for a different week, since those never populate `claimed_by` either. The
correct rule is `status <> 'available'` (covers both `'retainer'` and `'claimed'`), not
`claimed_by = <company>`. Caught only because the user cross-checked a second week's numbers by hand.

**How to apply:** Before writing any "was this survey actually delivered" condition against `slots`,
check `status` first, not `claimed_by` — `claimed_by` only tells you who claimed it via the open
marketplace, not whether a retainer-assigned survey ever happened. See [[reference_lead_counting_model]]
and the `installrhub-data` skill's Gotcha #9 (`slots.claimed_by` ownership truth) — that gotcha is
about WHO holds a claimed slot, not whether a retainer-status slot is "real"; don't conflate the two.

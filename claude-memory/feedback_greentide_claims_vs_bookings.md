---
name: feedback_greentide_claims_vs_bookings
description: "booked vs claimed are different metrics with different lags; count claims by CLAIM date not lead-created date, and never read campaign-level 7d cells"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: aa2b40e6-5935-4d29-9645-f66f9d2bc770
---

Four traps hit in one session analysing Green Tide placement. All cost real time.

**1. `booked_at` and `claimed_at` are different things.** `leads.booked_at` = we booked the survey.
`slots.claimed_at` / `leads.claimed_at` = an installer claimed it. Do not mix them in one table.
Bookings are FAST (median same day, 91% within 7 days). Claims LAG ~10.5 days on average.

**2. Count claims by CLAIM date, not by lead-created date.** Grouping "leads created in the last 7 days
that were claimed" shows near-zero everywhere because of the 10.5-day lag, which reads as a collapse.
Charlotte correctly pushed back ("we've had plenty of claims"): 67 claims in 7d, 91 in 14d, 20
installers. **Why:** I presented a lag artefact as a business finding, twice.

**3. Campaign-level short windows are noise and under-report.** `leads` has NO `utm_content`, so
campaign attribution needs a phone join (`right(digits(contact->>'phone'),9)` ↔
`lead_intake_events.contact_phone`). Over 60d that covers ~97% of intake, but only **~74% of recent
`leads` rows match**, so short-window campaign CPLBs are inflated ~25%. Worse, per-campaign 7d bookings
are 1-8, so a "£700 CPLB" is literally one booking. Use 60d for campaign level; use the `leads` table
directly (no join) for short windows.

**4. Green Tide scope is `lead_source='greentide'`.** NOT `retainer_client_name is null`, which stopped
working in June (goes to 0 rows). Also exclude test leads: `contact_name !~* '\mtest'`.

**Also:** per-area SPEND does not exist in the DB (`ads_insights_breakdown_daily` is empty, Serafim
OPEN 4), so all location analysis is leads/claims only. And when excluding installers from a claim
analysis, state clearly WHICH tables it was applied to; Charlotte had to ask, and two areas I had
recommended (Walsall, Bristol solar) were entirely propped up by the excluded pair.
See [[project_greentide_oversupply]].

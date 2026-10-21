---
name: feedback-claim-status-separate-not-profit
description: "Survey outcome analysis: Claimed, Refunded, Cancelled, Unclaimed are four separate statuses, never sum claimed+refunded; when she asks for claim rates, give rates, not profit"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 2677aadc-6e33-48e0-9244-790fdd4919a7
  modified: 2026-10-20T18:44:07.157Z
---

Charlotte, 2026-10-20 (Green Tide Testing + Back Up campaign review):

1. **Statuses are separate.** I wrote "Claimed = kept + refunded" and she pushed back: "these are two different statuses". One status per booked survey: **Claimed** (claimed and not refunded, incl. a later re-claim that stuck), **Refunded**, **Cancelled** (homeowner cancelled before any claim), **Unclaimed** (survey date passed, no claim), plus **Ahead** (date not reached, left out of percentages).
2. **She asked about claim rates, I kept pushing profit.** She said twice she wasn't interested in money. Answer the metric asked; don't add a revenue verdict.
3. **New marketplace is excluded** from legacy Green Tide analyses: Links Energy (NM06), Plumb Guys (NM05), Southernsolar (NM08) and their survey_orders.

**Why:** three corrections in one session: a profit verdict she didn't want, a wrong £/credit and £/survey, and a merged status.
**How to apply:** method that worked: lead_intake_events.utm_content = Meta ad id -> ads_ads/adsets/campaigns; phone join (right 9 digits) to leads; net claim-refund credits from `transactions` per lead; slots.slot_date for Ahead. Group by booking month. See [[feedback_greentide_claims_vs_bookings]], [[reference_installer_payments_not_in_app]].

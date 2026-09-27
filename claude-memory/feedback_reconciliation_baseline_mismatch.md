---
name: feedback_reconciliation_baseline_mismatch
description: "A correction/adjustment computed against one filtered dataset but applied on top of a DIFFERENTLY-filtered display total is systematically wrong, and gets worse the more the caller splits the range (ad_windowed_totals naive_totals bug, 2026-09-08)"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: cd08782b-d7b0-464e-a222-58f01441d3f5
  modified: 2026-09-08T11:51:51.369Z
---

`ad_windowed_totals`'s survey-count reconciliation (the `true_totals - naive_totals` adjustment row added 2026-08-24, see [[feedback_survey_count_root_cause_2026_08_24]]) under-credited any client with real bookings from an untracked or borrowed campaign/adset. Root cause: `naive_totals` summed `leads_booked_fixed` with NO `is_tracked` filter, while `base` (what every caller actually sums/displays) filters to tracked clients/campaigns only. The correction was sized against the larger, untracked-inclusive baseline, then added on top of the already-smaller `base` total, double-excluding the untracked campaign's bookings instead of restoring them.

**The general lesson:** when you build "true total minus naive total = correction, then correction + displayed total = final", the naive total used to SIZE the correction must be computed over the EXACT SAME row-set as the displayed total it gets added to. If they're filtered differently, the correction is wrong by exactly the size of that filter gap, every time.

**Why it's easy to miss:** a single full-range call showed a small, plausible-looking gap (Arktek: 26 vs true 30, off by 4, easy to shrug off as "close enough" or a rounding thing). The SAME bug, called once per week (`useReportTrend.js`'s method, which the live client report actually uses), compounded independently in EVERY week-window and took the same client down to 19 vs true 30, more than half the true number missing. Always verify a reconciliation-style fix against the ACTUAL caller's decomposition (per-week, per-page, whatever), not just a single convenient range, the error can be far larger in production than in a quick spot-check.

**How to apply:** when any "corrected" or "reconciled" total looks off, check whether the correction's own baseline query has the SAME WHERE/filter clauses as the number it's being added to. A quick diagnostic: compute the naive number both WITH and WITHOUT each filter the display path applies, and see if the gap matches the discrepancy.

---
name: feedback_reconcile_counts_custom_pixel_as_leads
description: "The lead reconcile's landing \"Meta leads\" over-counted because ads_insights_daily.conversions sums ALL result_types, incl. custom offsite pixel events, not just leads. Fixed 2026-07-28 to count only result_type='lead'."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 726b17e5-24fc-4a96-96ab-28ba57a9c410
---

The Green Tide lead reconcile (`useLeadReconciliation.js`) landing row showed a scary "-7 lost leads" that was NOT real loss. Root cause: it summed `ads_insights_daily.conversions` across every `result_type`. A landing adset (OFFSITE_CONVERSIONS goal) optimising for a **custom pixel event** (`result_type = offsite_conversion.custom.<id>`) also writes a conversions row, and that is not a lead. GT 10d: landing Meta = 28 = **23 real leads + 5 custom**, vs DB 21, so the bar invented -7. Counting only `result_type='lead'` gives 23, so the gap drops to a normal -2.

**Why:** Meta's `conversions`/`results` fields are per optimization result, and landing/OFFSITE_CONVERSIONS adsets can optimise for non-lead pixel events. Instant (LEAD_GENERATION) adsets always report `result_type='lead'`, so they were never affected.

**How to apply:** when counting "Meta leads" from `ads_insights_daily`, filter `result_type='lead'` (or the specific lead action), never sum raw `conversions`. Same family as [[feedback_meta_lead_counting]] (summing lead-ish types inflates). Verified the real leads are present per-lead: 19 of 20 pasted GT landing leads were in `lead_intake_events` (the 1 miss was a re-enquiry duplicate). The DB count was accurate; only Meta's side was inflated. See [[project_greentide_lead_pipeline]], [[reference_reconcile_bar_semantics]].

**CAVEAT (known-issues line ~165):** the DASHBOARD deliberately sums `offsite_conversion.custom.*` as leads when no standard `lead` action is present (Charlie 2026-06-04, to match Ads Manager). So the reconcile (now lead-only) and the Dashboard CPL can differ by those custom rows. That's intended: the reconcile's job is to match actual DB lead RECORDS (which the lead-only count does: GT 23 Meta-lead vs 21 DB), not Ads Manager. Don't "fix" the reconcile to sum custom again.

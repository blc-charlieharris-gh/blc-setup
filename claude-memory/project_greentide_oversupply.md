---
name: project_greentide_oversupply
description: "2026-07-20: Green Tide's problem is heat pump OVERSUPPLY everywhere (88% unclaimed), not bad locations; full analysis in docs/greentide-spend-review-2026-07-20.md"
metadata: 
  node_type: memory
  type: project
  originSessionId: aa2b40e6-5935-4d29-9645-f66f9d2bc770
---

**The finding that reframes it, 2026-07-20.** Charlotte asked which locations to cut. The answer is
that location is a second-order lever: we over-buy **heat pump leads everywhere**. Leads created 90 to
21 days ago: ASHP 1,119 leads / 132 claimed (**88.2% unclaimed**), Solar 350 / 108 (69.1%),
**ASHP+Solar 54 / 30 (44.4%, our best segment by far)**.

**There is no good heat pump area.** Derby has the best claim rate and still wastes 92%. The best area
in the country (KT) wastes 74%. Every one of the top 28 burn cells is ASHP; no solar area appears.

**We generate ~16 heat pump leads/day and place ~2.** Charlotte's drafted 28% cut (£640→£500/day) still
leaves ~3.5x oversupply on heat pumps. Matching demand needs ~85%.

Overall booking rate fell 37.5% (25 May) → 19.0% (13 Jul). It is a MIX problem: solar books ~3x better
than ASHP (43% vs 15% over 30d, stable across windows) and we buy 4x more ASHP than solar.

Where the data disagreed with Charlotte's drafted plan: **Sheffield and Southampton heat pumps do not
hold up** (Sheffield 1 claim in 14d despite 6 installers; Southampton 83% unclaimed; Manchester zero),
the real belt is **East Midlands: Derby, Leicester, Nottingham, Peterborough, Crewe**. **Recent solar
claims are North West, not Midlands** (~17 of ~20 in 14d), so the adset weighting should probably flip,
but 20 claims is a small base and a paused Midlands installer would explain it, so check first.

**No ad changes were made.** Full detail, method notes and the corrections to my own earlier wrong calls
(Stoke and Stockport should NOT be excluded) are in `docs/greentide-spend-review-2026-07-20.md` on
branch `feat/arktek-policies-logos`. See [[feedback_greentide_claims_vs_bookings]],
[[reference_lead_counting_model]].

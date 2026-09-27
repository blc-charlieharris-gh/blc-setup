---
name: feedback_sitescore_score_what_the_customer_sees
description: "SiteScore must weight the scorecard to what a homeowner experiences, and always test pain>solution>outcome; developer metrics inflate the score and produce a 'great apart from 3 things' audit that sells nothing"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: fedab6bd-5e7e-4b2a-8415-2394f51ca230
---

Charlotte, 2026-07-16, on the Prime Energy audit ([[project_sitescore_primeenergy]]): *"i think we're saying with this audit: it's great apart from these 3 things. which doesnt sell us very well at all. i actually think their site doesnt look good, isnt homeowner focussed, isnt pain > solution > desirable outcome"*.

**The bias was structural, not tonal.** 2 of the 8 scorecard dimensions (speed 80, schema 70) were **developer metrics no homeowner ever sees**, so 25% of the score measured plumbing. That pulled the average up, produced a "great apart from 3 things" verdict, and invited the prospect to fix those 3 in-house. Score went 40 → 35 once rebalanced.

**Why:** the audit sells a rebuild. A scorecard weighted toward engineering rewards the exact thing that does not win customers, and hands the prospect a short DIY list. It also just *misses the point*: a site can be 66KB, fast, accessible and schema-perfect and still be commercially worthless.

**How to apply:**
- **Weight the scorecard to what a homeowner experiences.** Collapse speed/build/schema into ONE "Technical foundations" dimension (1 of 8, not 2 of 8). Keep the honest high mark, but frame it as *"the one you are winning, and invisible to every customer you have."* Do not slash it, that would just be the reverse bias, see [[feedback_sitescore_unbiased_scoring]].
- **Always test "is it written for a homeowner?" as its own dimension.** It is a real, repeatable, MEASURABLE finding, not an opinion. Method (automatable for CREW):
  - Count **pain words** (cold, damp, mould, draughty, bills, afford, winter, health, vulnerable) vs **mechanism words** (grant, scheme, eligibility, funding, government, ECO4/scheme names). Prime Energy = **4 vs 95**. "cold" appeared **0** times on a site selling warmth to fuel-poor households.
  - Count **the installer's own agenda** (carbon, net-zero, sustainability, eco-friendly). Prime = 6, i.e. more than cold+damp+mould combined. **A household on Universal Credit is not buying net-zero.**
  - Measure **section order as % down the page**. Prime = "About Us" at 7.9%, "could you qualify" at 52.7%. Inside-out = company-centric.
  - Check for **pain → solution → desirable outcome**. Most installer sites lead with the offer or the mechanism and never name the pain.
- **Nobody wakes up wanting an ECO4 grant.** They want to stop being cold, stop dreading the bill, stop the damp. The scheme is the mechanism. A site that sells the mechanism is speaking its own internal language to a customer who doesn't speak it.
- Related: [[feedback_sitescore_sell_dont_give_away]] (same session, same root: the audit must demonstrate value, not hand over a snag list).

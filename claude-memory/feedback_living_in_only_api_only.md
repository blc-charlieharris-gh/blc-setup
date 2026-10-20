---
name: feedback_living_in_only_api_only
description: "People living in" only is gone from Ads Manager but the API still sets it; Charlotte keeps it on every client incl Elect since 10-09 (edits via Claude)
metadata:
  type: feedback
---

2026-10-07: Ads Manager refused to publish an edit to Kcglinks' AS01 ad set: "location targeting option that has been removed ... (#1870194)". Cause: `location_types: ["home"]` ("people living in" only). Ads Manager no longer offers it, but the API still accepts it (validate_only and real writes both 200).

Charlotte's decision: keep "living in" only (option A) on our ad sets, and make all changes to them through Claude via the API. Exception: The Elect Group stays on Meta's default "living in or recently in" (option B) because the client may toggle/edit ads themselves in Ads Manager.

2026-10-09: Elect moved to home-only too, after a DL14 out-of-area lead arrived via "recently in" (Charlotte chose fewer stray leads over Elect editing its own ad set).

2026-10-20 check (Charlotte worried it hurts delivery): real switch dates were Gas Worx 09-23 (area also cut 10-05), SWH 10-03, Arktek 10-05, Elect 10-09. No lead or reach drop lined up with those dates; frequency stayed 1.5-2.2/week on ~1m audiences; the CPM rise from 10-13 hit unswitched National Eco equally. Out-of-area leads: Arktek 15% -> 0%, SWH 12% -> 7%, but Elect still got 6 of 26 out-of-area while on living-in. It reduces strays, does not stop them (Meta guesses home). Spend/lead pacing that day was normal: most leads land after 15:00.

**Why:** home-only stops out-of-area commuter leads ([[project_gasworx_ads_location_targeting]]); I wrongly told her Meta had removed it entirely and moved 3 ad sets to B before checking the API. Explain as A/B in plain words, she didn't follow "location types".
**How to apply:** when this error appears, don't switch to B; do the edit she wanted via the API instead. Build new ad sets home-only (clone_campaign.build_targeting does) unless the client manages their own ads. 7 home-only ad sets on 10-07: Gas Worx, Arktek, SWH, LJP, GT Testing Instant forms Copy, GT Back Up England, Jones and Baker, plus AS01.

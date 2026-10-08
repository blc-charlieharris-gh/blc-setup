---
name: feedback_living_in_only_api_only
description: "People living in" only is gone from Ads Manager but the API still sets it; Charlotte keeps it (edits via Claude), except clients who edit their own ads (Elect)
metadata:
  type: feedback
---

2026-10-07: Ads Manager refused to publish an edit to Kcglinks' AS01 ad set: "location targeting option that has been removed ... (#1870194)". Cause: `location_types: ["home"]` ("people living in" only). Ads Manager no longer offers it, but the API still accepts it (validate_only and real writes both 200).

Charlotte's decision: keep "living in" only (option A) on our ad sets, and make all changes to them through Claude via the API. Exception: The Elect Group stays on Meta's default "living in or recently in" (option B) because the client may toggle/edit ads themselves in Ads Manager.

**Why:** home-only stops out-of-area commuter leads ([[project_gasworx_ads_location_targeting]]); I wrongly told her Meta had removed it entirely and moved 3 ad sets to B before checking the API. Explain as A/B in plain words, she didn't follow "location types".
**How to apply:** when this error appears, don't switch to B; do the edit she wanted via the API instead. Build new ad sets home-only (clone_campaign.build_targeting does) unless the client manages their own ads. 7 home-only ad sets on 10-07: Gas Worx, Arktek, SWH, LJP, GT Testing Instant forms Copy, GT Back Up England, Jones and Baker, plus AS01.

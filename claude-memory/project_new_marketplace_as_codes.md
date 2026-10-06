---
name: project-new-marketplace-as-codes
description: "New marketplace Meta ad sets = one per tech+region on Green Tide, one AS code in the name; AS01 = GT Solar North West (Kcglinks), next is AS02"
metadata:
  type: project
---

Serafim's model (cross_agent_notes 03474fe0 + 15135356, 2026-10-05/06): New marketplace and pay-per-lead clients get no campaign of their own. Each Meta ad set on the Green Tide account covers one tech + region and carries ONE code "AS" + 2-4 digits in its name (space/pipe separated, never glued to letters). The code is never changed or reused on a live ad set. InstallrHub links installers to codes (direct_booking_adset_links) and splits spend by surveys. No per-client form and no UTMs. NM codes are retired.

The Hub doesn't issue codes yet, so we pick the next number. AS98/AS99 are Serafim's test rows. **AS01** = "GT | Solar | North West | Finance | AS01" (ad set 120251554204730201, built 2026-10-06 for Kcglinks, OFF). **Next free: AS02.**

2026-10-06 evening: the Hub session added a Hub step that links clients to AS codes in Serafim's direct_booking_adset_links (migration 20261007002000_hub_as_code_links.sql: adds or soft-removes rows only, his rules still decide). Charlotte sent it to Serafim to check; Kcglinks -> AS01 is the first link.

**Why:** Charlotte switched from one-campaign-per-client to this on 2026-10-06 so installers can share an area without ad edits.
**How to apply:** a region's areas = what its installers actually cover (Charlotte: "no point adding areas this one installer doesn't do"). Tell Charlotte which code serves which area so she tells Serafim. AS-coded ad sets must be excluded from Greentide CPL (Hub side). Related: [[reference-meta-clone-campaign-skill]], [[reference_greentide_meta_accounts]].

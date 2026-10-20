---
name: project-new-marketplace-as-codes
description: "New marketplace Meta ad sets = one per tech+region on Green Tide, one AS code in the name; AS01 = GT Solar North West (Kcglinks), next is AS02"
metadata:
  type: project
---

Serafim's model (cross_agent_notes 03474fe0 + 15135356, 2026-10-05/06): New marketplace and pay-per-lead clients get no campaign of their own. Each Meta ad set on the Green Tide account covers one tech + region and carries ONE code "AS" + 2-4 digits in its name (space/pipe separated, never glued to letters). The code is never changed or reused on a live ad set. InstallrHub links installers to codes (direct_booking_adset_links) and splits spend by surveys. No per-client form and no UTMs. NM codes are retired.

(Before 14 Oct we picked numbers by hand.) AS98/AS99 are Serafim's test rows (hidden in the Hub). **AS01** = "GT | Solar | North West | Finance | AS01" (ad set 120251554204730201, built 2026-10-06 for Kcglinks, OFF). AS02 = GT | ASHP | Sussex | Finance (Plumb Guys), AS03 = GT | Solar | South Coast | Finance (Southern Solar), both live 14 Oct 2026 at £60/day; AS01 paused 14 Oct (Kcglinks covered). AS04 = GT | ASHP | North Midlands | Finance (Cozy Home Yorkshire, 1,838 sectors), AS05 = GT | Solar | Yorkshire | Finance (Renewable Sales and Service Solutions, 1,144 sectors, also linked to paused AS01 by her choice); both built 20 Oct, ON in readiness at £60/day while Green Tide billing is stopped. **Next free: AS06.** All AS02-05 use Green Tide's 17 interests, ages 25-65 (standard since 20 Oct). Build path: meta-access clone_campaign.py workdirs gt-hp-northmidlands / gt-solar-yorkshire; ads = her Hub step 5 picks; texts = AS02 (heat pump) / AS03 (solar) copy.json. Hub has Brief for Ads Manager (manual builds by Erin) and audience size lines (300k / 4m). Since 14 Oct the Hub issues codes (Clients > Meta set-up > Ad set codes) with postcode areas, tech and finance, and recommends/pauses per installer forecast.

2026-10-06 evening: the Hub session added a Hub step that links clients to AS codes in Serafim's direct_booking_adset_links (migration 20261007002000_hub_as_code_links.sql: adds or soft-removes rows only, his rules still decide). Charlotte sent it to Serafim to check; Kcglinks -> AS01 is the first link.

**Why:** Charlotte switched from one-campaign-per-client to this on 2026-10-06 so installers can share an area without ad edits.
**How to apply:** a region's areas = what its installers actually cover (Charlotte: "no point adding areas this one installer doesn't do"). Tell Charlotte which code serves which area so she tells Serafim. AS-coded ad sets must be excluded from Greentide CPL (Hub side). Related: [[reference-meta-clone-campaign-skill]], [[reference_greentide_meta_accounts]].

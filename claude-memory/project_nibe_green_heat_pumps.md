---
name: project-nibe-green-heat-pumps
description: NIBE Green Heat Pumps Meta account, live "Heat Pump Leads" campaign with 4,228 postcode-sector coverage (09-21)
metadata:
  type: project
---
- Account "Green Heat Pumps" act_930515099667077, owned by business NIBE GB. Created 2026-09-17; was unsettled (status 3) on 09-21 morning, settled (status 1) by 09-21 evening.
- Campaign "Heat Pump Leads" (120250269430810238, OUTCOME_LEADS), ad set "Instant Form > Regional" (120250269430820238), ACTIVE as of 2026-09-21.
- Coverage = 56 postcode areas (southern England, London, East, South West, CV/NN/WR/HR/LN, CF/NP; no Devon/Cornwall, no Birmingham, nothing north). List: AL BA BH BN BR BS CB CM CO CR CT DA DT E EN GL GU HA HP IG IP KT LU ME MK N NR NW OX PE PO RG RH RM SE SG SL SM SN SO SP SS SW TA TN TW UB W WD CF CV HR LN NN NP WR.
- Targeting holds 4,228 Meta-valid sectors (verified 09-21 via targetingsentencelines + matching delivery estimate ~20.1-23.7M). Files in meta-access/outputs/nibe_green_sectors_* (valid list, 620 rejected, geo JSON, 5 paste chunks, snapshot of what's in the ad set).
- Ad set also has a redundant Northern Ireland exclusion (harmless), Advantage+ audience ON (age 25-65 + interests are suggestions only), home+recent location types.
- **Why:** coverage must be sector-level, not district, per Charlotte.
- **How to apply:** if coverage changes, rebuild with [[meta-zip-sector-validation]] and update the ad set via API (it's published now, so API edits work; warn that targeting edits reset learning per docs/meta-ops-sop.md).

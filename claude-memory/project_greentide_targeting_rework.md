---
name: project_greentide_targeting_rework
description: Green Tide heat pump geo: NW-only since 2026-09-25 (Brad's call, £30 main/£20 backup); July claim-rate rework superseded
metadata: 
  node_type: memory
  type: project
  originSessionId: 9bf7dbbe-2310-49f1-b143-d5e3b701c8b8
---

**CURRENT (2026-09-25):** Brad (WhatsApp 09-23) switched Green Tide ASHP to North West only. Both live heat pump ad sets (main `120241104767920201` £30/day, backup `120243550688750152` £20/day) target 6 pins: Manchester +15mi, Liverpool +12, Warrington +10, Chester +10, Northwich +8, Crewe +10. Exclusions: Scotland, NI, Wales, Devon, Cornwall, IoW only. No solar ad sets live. This overrides the July finding that NW is weak for ASHP, so watch claim rate. Details + rollback in meta-access `docs/CHANGELOG.md`.

**History below (July, superseded):**

2026-07-04/05: reworked Green Tide Meta geo targeting using **claim rate by postcode area** (claimed vs available marketplace slots, cancelled excluded, dual-tech split via `slots.technologies`) cross-checked against **active installers who actually claimed** (distinct `slots.claimed_by` in 30d, NOT declared `companies.postcode_areas` coverage). Windows: 30d = matured/decision base, 7d = immature (claims lag booking ~60% surveys still future), so low 7d that climbs = maturing not weak.

**Decisions (aligned with boss's note):**
- **Heat pump (ASHP): cut 20%** (£400→£320/day) as it has higher cancellation rates. Kill West Midlands (Birmingham 10%, Coventry 20%, Walsall 0%, Wolverhampton, Leicester). Target East Midlands (Derby, Nottingham), Stoke, South Yorkshire (Sheffield, Rotherham), South East (Redhill/Reigate, Kingston). Stay OUT of North West (weak ASHP).
- **Solar: budget unchanged** (£350) - Bright Path + GPS partnerships mop up excess. **Scale North West** (Manchester belt + Chester, ~100% claim). Keep East Mids + Coventry (solar 63% though ASHP dead). Keep Sheffield only from Yorkshire, pull back Leeds/Bradford/Huddersfield/Doncaster. Exclude Walsall, Leeds, Gloucester.
- Key nuance: **Birmingham + Coventry work for solar but are dead for heat pump** - remove from ASHP only. Leicester dead for both. Norwich = recruit gap (no installer), not a targeting cut.

**State at handoff:** Backup account (`act_1278923346535596`) rebuilt clean (pins, no West Mids) - only fixes left = HP High Peak pins creeping NW, solar Lichfield pin leaking into Walsall. **Main account (`act_419073311249744`) UNFINISHED**: pins added but old CITY entries never deleted - HP adsets still list Birmingham/Coventry/Leicester/Wolverhampton, solar Midlands still lists Leicester/Wolverhampton. Next: delete those cities, add Redhill+Kingston to main HP, fix Lichfield pin.

See [[reference_greentide_meta_accounts]]. Every location edit resets Meta learning phase, so batch edits.

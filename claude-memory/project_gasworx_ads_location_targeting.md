---
name: project_gasworx_ads_location_targeting
description: "Gas Worx targets exactly the client's drawn map (356 sectors, 10-05); LJP residents-only; never edit locations in Ads Manager"
metadata:
  node_type: memory
  type: project
  originSessionId: b1215502-c286-485d-bf5a-de6889359f80
  modified: 2026-09-23T12:53:55.303Z
---

Gas Worx ads (act_3672828152891130, ad set "Instant Form - Regional" 120247684965470464) were switched to `location_types: ["home"]` via API on 2026-09-23 to stop out-of-area leads (14/51 in 30d from CR/KT/TW/UB/WD/BN/DA/TN, commuters caught by "recently in").

**Why:** Ads Manager no longer offers residents-only, only the API can set it; a UI edit to locations likely reverts it to home+recent.

**How to apply:**
- Never edit that ad set's locations in Ads Manager; do targeting changes via API and re-check `location_types`.
- Open question (Charlotte asked the client 09-23, "keep as is for now"): stated coverage is GL, SN, SP, BA, BS, OX, RG, SO, BH, DT, GU, PO, but only BH/GU/PO/RG/SO sectors are targeted. The Dorset county exclusion stays (Charlotte's call), but it blocks all DT and the Dorset-side BH sectors. Don't add the missing areas until the client answers, and don't chase it: Charlotte will raise it if coverage needs changing.

**LJP (same fix, 09-23):** act_940137009135799 ad set 120253240476530079 also set to home-only, plus IP32/IP33 (Bury St Edmunds) added; LJP confirmed 2026-09-23 they want Bury. Same rule: no location edits in Ads Manager.

See [[project_gasworx_website]], [[reference_meta_zip_sector_validation]].

**Update 2026-10-05: coverage answered.** The client said we brought leads in from too far out and sent a hand-drawn map (Whiteley base): Bournemouth, Amesbury, north of Andover, north of Basingstoke, Guildford, Petworth, Bognor, Selsey, the Portsmouth coast. The Isle of Wight is outside it. Charlotte: "make it exactly what they want". Applied via API: 356 sectors (sector centroid inside their polygon), 199 removed (Reading/Newbury, Woking/Guildford/Camberley, Poole/Purbeck, IoW, west Bognor), 46 added (mostly Salisbury and Andover), Dorset exclusion DROPPED, home-only, Scotland/Wales/NI excluded. Audience about 1.0-1.2M (was 1.4-1.6M). Map, overlay and before/after targeting are in meta-access/outputs/gasworx-coverage-2026-10-05/ (gitignored, local only). This replaces the GL/SN/SP... list and the Dorset note above.

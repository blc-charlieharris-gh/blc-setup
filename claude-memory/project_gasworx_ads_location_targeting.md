---
name: project_gasworx_ads_location_targeting
description: Gas Worx + LJP Meta ad sets set to residents-only via API on 2026-09-23; coverage question to client pending
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

---
name: reference_meta_finance_special_category_rules
description: "Tested 10-22 on Madola: what Meta's Financial products special category allows (no postcodes, 10mi pins, age ok, 7 of 17 solar interests)"
metadata:
  node_type: memory
  type: reference
  originSessionId: bca769a8-87b5-4eb5-bf2e-6f75a9deee90
  modified: 2026-10-22T13:22:55.435Z
---

Tested with validate_only on act_1390517549737708 (Madola, 2026-10-22), API v21:
- Category enum is `FINANCIAL_PRODUCTS_SERVICES` + `special_ad_category_country: ["GB"]`; `CREDIT` is refused as retired.
- Postcode sectors (zips) refused (#2909053). Minimum 10 mile radius around a city or dropped pin (not 15). Regions (Wales) allowed.
- Age 25-65 and location_types ["home"] (living in) were accepted and saved.
- Of the SWH/Arktek 17 interests only 7 pass: Home repair, Home improvement, Renewable energy, Home (home and garden), Solar energy, Air conditioning, Solar power. Refused: Solar panel, Photovoltaic, Solar cell, Heat pump, HVAC, SunPower, Electricity generation, Efficient energy use, Sustainable energy, MRO.
- Postcode districts -> greedy 10mi pins on sector centroids (outputs/clones/madola-swh/pins10.json): 44 pins = 99% of homes, ~3k spill; reach same as the postcode version.

Arktek, SWH and Green Tide AS01-05 run finance wording WITHOUT the category. Related: [[feedback_finance_claims_on_picture_get_rejected]]

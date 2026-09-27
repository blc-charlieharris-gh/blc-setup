---
name: feedback_meta_breakdown_combos
description: "Meta insights breakdowns can't be combined across families; each needs its own API call"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 0c5c6db7-669d-4b60-b1b5-15e1ba635b38
---

Meta's `/insights` API rejects combining breakdown families in one call (error #100 "Current combination of data breakdown columns ... is incompatible"), because `actions` implicitly adds an `action_type` breakdown. Verified valid vs invalid on Green Tide (`act_419073311249744`):

- **Valid together:** `publisher_platform,platform_position,impression_device` (one call powers platform + placement + device); `age,gender`.
- **Must be their own call:** `body_asset` (primary text), `title_asset` (headline), `description_asset`. `body_asset,title_asset` together = ERROR.
- **`platform_position` needs `publisher_platform` alongside it** when pulling `actions`; alone it errors.
- **No 3-way ever:** placement + demographic (e.g. `publisher_platform,age`) is rejected. So "this ad, on IG Reels, for women 40+" is impossible, and you can't reconstruct it from marginals (independence assumption is wrong exactly where it matters). The only true 3-way is to isolate the segment in a dedicated ad set.

**Why:** so the Breakdowns feature runs 4 separate calls per client/window (placement / demographic / body / title). Asset breakdowns only return rows for dynamic/Advantage+ creative, and asset-level lead attribution is directional. Lead metric = `action_type 'lead'`. See [[project_greentide_lead_tracking]] and marketing-agent's `spec-meta-sync-breakdowns.md`.

---
name: feedback-ads-location
description: Ad creatives and generated images are stored in meta-access/outputs (plural); never store ads inside the website projects
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7c025f6b-6d22-4f5d-a4c3-4119ac2951d9
---

Generated images and ad creatives live in `meta-access/outputs/` (note: **outputs**, plural).

Ads are created with Higgsfield, not hand-coded HTML (see [[feedback-higgsfield-default]]). An earlier coded-HTML ad approach (an `ad-build/` folder) was abandoned and deleted.

Do NOT store ads inside the website projects (e.g. `site-greentide/`, `site-installrhub/`). Those are the live websites, not asset storage. It is fine to borrow brand assets (logos, colours) from them.

**Why:** Charlotte keeps ads separate from the website codebases. Mixing them caused confusion (a stray `output/` folder and ads buried in the website). Brand voice rules from [[project_greentide]] still apply to Green Tide ads (never "free survey"/"our surveyor").
**How to apply:** Save all generated stills/video and ad creatives to `meta-access/outputs/`. Related: [[feedback-higgsfield-default]], [[project-higgsfield]].

---
name: feedback_never_use_ad_names
description: Ad names, creative_id, thumbnail-asset-id and campaign are all UNRELIABLE for creative identity; only the operator's visual comparison is authoritative.
metadata:
  node_type: memory
  type: feedback
  originSessionId: 035a4476-eae5-4eb6-91a1-47de19bb6d45
---

Do NOT judge whether two Meta ads are "the same creative" (or flag a merge as bad) from metadata. Charlotte has corrected me repeatedly on this (2026-07-01, twice in one session). Every metadata signal is unreliable:
- **Ad names** are noise: operators copy ads and never rename, so duplicates get "- Copy" appended and same-named ads can be different creatives.
- **`creative_id` (`creative_external_id`)** is NOT reliable either: a video re-upload mints a BRAND-NEW creative_id for the exact same visual. Different creative_id does NOT mean different creative.
- **Thumbnail asset id (`visualKey`, the t15 CDN `NNN_NNN_NNN`)** collides for video (distinct creatives can share it) AND differs across re-uploads/poster-frames of the same video. Unreliable both directions.
- **Running in different campaigns is NORMAL** for one creative. The whole point of the By-creative blend is one creative summed ACROSS its ads and campaigns. Cross-campaign membership is not evidence of a bad merge.

**The ONLY authority for "same creative" is the VISUAL** (the operator looking at the thumbnails). That is exactly why merging is manual/operator-driven (`creative_merges` via the Matcher), and why the Matcher member view (shipped 2026-07-01) shows each member's thumbnail so the operator judges by eye.

**How to apply:** never tell Charlotte a merge is wrong, or two ads differ, based on name/creative_id/thumb-asset/campaign. If the thumbnails look the same to her, they ARE the same creative and the merge is correct. When a By-creative blended number does not match a Meta figure, suspect SCOPE (blended-creative vs a single Meta ad) or WINDOW mismatch BEFORE suspecting a bad merge. See [[project_creative_testing_identity_leadbasis]].

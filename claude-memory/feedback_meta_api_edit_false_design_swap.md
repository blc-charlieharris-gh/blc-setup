---
name: feedback_meta_api_edit_false_design_swap
description: An API form/copy edit makes a new Meta creative and re-uploads videos, so the Hub's design-swap trigger unlinks video ads falsely; use "Same design, keep its link"
metadata:
  type: feedback
---

On 14 Oct 2026 moving all 8 Gas Worx ads to a new lead form via the API made each a new Meta creative, and the videos came back with NEW video ids (asset_feed_spec). The Hub's design-swap trigger (hub_track_ad_design / hub_record_design_swap) keys a video by creative id, so at the 03:00 sync it closed 7 Library links and the ads showed in Ads not linked. Video ids can't tell a re-upload from a new design, so the fix is a person: Library > Ads not linked > "Same design, keep its link" (hub_undo_design_swap). Undo SQL must DELETE the swap's history row BEFORE reopening the earlier one (unique index ad_creative_history_one_open), or it stops.

**Why:** the first undo SQL failed on that index; video-id fingerprinting was tested and doesn't work.
**How to apply:** after any API edit to live video ads (form, copy, URL tags), expect them in Ads not linked next morning and use the button. Related: [[feedback_meta_api_create_payload_gotchas]].

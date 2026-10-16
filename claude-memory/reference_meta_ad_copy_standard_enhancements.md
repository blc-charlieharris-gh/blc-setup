---
name: reference_meta_ad_copy_standard_enhancements
description: "Ad /copies refused on older ads (standard enhancements, 3858504): create with existing creative_id. Error 1487083 \"ForceRunStatus\" = cv_transformation on a video design: rebuild with it OPT_OUT"
metadata:
  node_type: memory
  type: reference
  originSessionId: dc4dcead-ca9f-460d-b6ac-774cb66b263b
  modified: 2026-10-16T14:03:52.910Z
---

2026-10-16, when the LJP ad set was rested: `POST /{ad_id}/copies` with adset_id was refused for Ad1, Ad2 and Ad4 with error subcode 3858504, "Creative should not include standard enhancements". The same happened on SWH. Copying the ad set itself with `deep_copy=false` worked.

Working pattern: `POST act_X/ads` with `adset_id`, `name`, `status`, `creative={"creative_id": <existing creative id>}` (plus `tracking_specs` if the old ad has them). Validate it first with `execution_options=["validate_only"]`. This reuses the same design with no re-upload.

**"Update required" / "Couldn't edit your ads: Invalid usage of ForceRunStatus" (issue 1487083), 2026-10-16 SWH Test - Test - Ad3 video:** this is not a policy rejection. The ad passes review, then gets switched off minutes later. Reusing the same creative_id fails the same way. The cause was the design's `degrees_of_freedom_spec` having `cv_transformation` OPT_IN (an automatic video edit Erin's Ads Manager test copies switched on). The working copies had it OPT_OUT. Fix: make a new creative from the old spec (object_story_spec, asset_feed_spec, url_tags, contextual_multi_ads), drop `standard_enhancements`, set `cv_transformation` OPT_OUT, then create the ad with it. Wording changes (e.g. 0% -> Flexible) don't help.

Also: copy ad sets through the API, not Ads Manager, so living-in only survives ([[feedback_living_in_only_api_only]]). Churn from Erin's "Test -" copies plus on/off toggling was the main cause of LJP's October stall.

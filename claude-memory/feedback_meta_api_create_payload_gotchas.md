---
name: meta-api-create-payload-gotchas
description: "Meta create-API traps hit building the IH webinar campaign 09-29: custom conversion promoted_object, validate_only ignored on audiences, one description per rule"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 55ebdf36-4e07-46a7-8304-dac645f92cfe
  modified: 2026-09-29T14:18:33.113Z
---

Three Meta Marketing API traps, all hit on 2026-09-29 building the InstallrHub webinar campaign (`meta-access/build_webinar_campaign.py`):

1. **Optimising on a custom conversion:** `promoted_object = {"custom_conversion_id": X}` on its own. Adding `pixel_id` (with or without `custom_event_type`) returns "Promoted Object Invalid".
2. **validate_only is NOT honoured on `/customaudiences`:** a "dry run" POST created the audience for real. Guard audience creation with a name lookup first.
3. **Only one description per `asset_customization_rules` rule.** Bodies and titles can rotate several texts under one shared label, descriptions cannot ("Multiple descriptions assets cannot be applied to rule").

Also: validating an ad set against an existing CBO campaign fails with "same optimisation for ad delivery selection is required" when that campaign's ad sets optimise differently. That's harmless for a shape check.

**Why:** each one cost a failed run, and #2 silently wrote to the account.
**How to apply:** reuse `build_webinar_campaign.py` as the template for website-conversion campaigns. Related: [[meta-targeting-write-rate-limit]], [[installrhub-standard-url-tags]].

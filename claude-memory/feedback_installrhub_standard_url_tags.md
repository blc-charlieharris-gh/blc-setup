---
name: installrhub-standard-url-tags
description: "InstallrHub Meta ads use utm_medium={{placement}}&utm_campaign={{adset.id}}&utm_content={{ad.id}}, no utm_source"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 55ebdf36-4e07-46a7-8304-dac645f92cfe
  modified: 2026-09-29T14:18:36.907Z
---

Charlotte's standard URL parameters for InstallrHub Meta ads: `utm_medium={{placement}}&utm_campaign={{adset.id}}&utm_content={{ad.id}}`. There's no utm_source and no readable campaign names.

**Why:** I invented a readable set (utm_campaign=webinar-oct6 etc.) on the 2026-09-29 webinar build. She corrected it, and fixing it meant re-creating 3 creatives and swapping them in, because url_tags on a creative can't be edited.
**How to apply:** use this string on every new InstallrHub creative unless told otherwise. Related: [[meta-api-create-payload-gotchas]], [[emailish-source-forces-email-channel]].

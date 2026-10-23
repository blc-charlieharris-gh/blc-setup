---
name: project_hub_publish_to_meta_button
description: "Long-term (Charlotte 10-23): a Hub button that publishes ads to Meta for us, so living-in-only ad sets stop blocking Ads Manager"
metadata:
  node_type: memory
  type: project
  originSessionId: b9af5e93-5474-41c1-9cea-c58f8d14b3c6
  modified: 2026-10-23T11:55:04.555Z
---

Ads Manager refuses to publish anything in an ad set on `location_types: ["home"]` (#1870194); only the API can keep living-in only. On 2026-10-23 Erin couldn't publish Arktek ads, so Charlotte chose: drop living-in only where it blocks the team (Arktek `120248304801620083` -> home+recent on 10-23, before copy in meta-access outputs/arktek-location-1023), and **long term build a Hub button that publishes ads to Meta for us** ("needs a bit of thought"). A paused "Staging" ad set + copy-command route was offered and REJECTED, don't re-offer it.

**Why:** the team must be able to publish without Claude in the loop, and living-in only cut out-of-area leads (Arktek 15% -> 0%, SWH 12% -> 7%).

**Agreed shape (Charlotte 10-23):** a Publish to Meta button in the existing Launch pop-up (`LaunchModal.jsx`, today says "by hand in Ads Manager", ad id pasted back), pick the client's ad set, publishes PAUSED then a separate Switch on button; copy = standard texts (`creative_standard_texts`) as a starting point, editable, or free text; marketing team can press it only after launch approval. Never edits audiences; v1 skips editing existing ads (false design swap), budgets, new ad sets/campaigns.

**How to apply:** when this comes up, plan it in marketing-agent (meta-sync only reads Meta today, no ad-creation code in the Hub as of 10-23). The meta-access `clone_campaign.py` step_ads is the proven creative/ad build to port. Once it exists, living-in only can come back. Related: [[project_ghl_removal_hub]]

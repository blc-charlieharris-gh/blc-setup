---
name: feedback-hub-managed-lives-in-hub-code
description: Anything the Hub manages (edge fns it runs, e.g. meta-lead-webhook, portal fns) must have its source in the Hub repo, not Serafim's GT Dashboard
metadata:
  type: feedback
---

Charlotte, 14 Oct 2026: "anything that the hub manages should be in the hubs code." Said when a meta-lead-webhook fix went live by paste while its source sat in Serafim's Green Tide Dashboard repo (a redeploy there would undo it).

**Why:** a live fix whose source is in another repo gets silently overwritten; and the Hub team can't own what it can't see.
**How to apply:** before fixing a Hub-run function whose source isn't in marketing-agent, move it in first (copy live, add to supabase/functions, paste-deploy) and leave Serafim a cross_agent_notes ask to add it to his deploy refuse-list. Done so far: 7 portal fns (13 Oct); meta-lead-webhook, lead-ingest, client-link, meta-pages-admin, meta-assets-discover (14 Oct). Ten dead hub-*/marketplace-campaign fns to delete after Serafim OKs (note hub-functions-to-hub-2026-10-14). Related: [[feedback_hub_items_batched_at_end]], [[reference_hub_test_lead_keys_and_phone]].

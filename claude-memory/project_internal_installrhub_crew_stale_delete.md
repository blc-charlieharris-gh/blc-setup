---
name: project_internal_installrhub_crew_stale_delete
description: "On internal-installrhub repo branch feat/crew, a staged (uncommitted) deletion of the stale Trustpilot-branded CustomSites/retrofit-group/ duplicate is waiting; it rides the next commit/push of feat/crew, which is intended"
metadata: 
  node_type: memory
  type: project
  originSessionId: e306d040-3199-4d38-bd90-f2686f851312
---

Handoff from a parallel session (2026-07-30). In the **internal-installrhub** repo, branch **feat/crew**:
the stale duplicate `CustomSites/retrofit-group/` (the OLD Trustpilot-branded copy of the Retrofit site) was
**deleted, staged but NOT committed**. It is the only uncommitted change on that branch. Committing/pushing
feat/crew carries the deletion with it, which is **intended, let it go**.

The real Retrofit site now lives ONLY at `marketing-agent/client-sites/retrofit-group/site/`. Ties to
[[project_retrofit_site_trustpilot_cd]] (the 2026-07-30 Trustpilot cease-and-desist strip): that C&D note
flagged the internal-installrhub copy was NOT cleaned; deleting this stale duplicate is that cleanup.

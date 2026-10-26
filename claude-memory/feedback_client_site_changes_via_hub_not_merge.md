---
name: feedback_client_site_changes_via_hub_not_merge
description: "Client website changes go through the Hub job's Save the build files, never a merge; old repo-built sites switch over on their first save"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0037a293-21b8-4906-bed8-68d6ef693b1a
  modified: 2026-10-26T15:31:42.697Z
---

Client website updates are done by saving a zip of the whole site folder on the Hub job (Save the build files), then Run audit. Never tell Charlotte (or Erin) to merge a PR for a client site: Erin can't merge, and the process has no git step.

Sites built before the kit process (e.g. Jones and Baker, built 10-19 to 10-22 in marketing-agent `website-factory/clients/<slug>`) have no `client-site-files/<slug>/source.zip` yet. Check that bucket first. Take the repo folder as the starting point, make the change, zip it, and have her save it on the job. From then on the Hub copy is the source and the repo folder is a stale leftover to retire.

**Why:** 10-26: I said "do both, merge and save", then reversed when she pointed out merging isn't the process. That left her confused.
**How to apply:** for any client site change, give one action: save the zip on the job. Related: [[feedback_always_give_merge_link]] (that rule covers Hub code, not client site builds).

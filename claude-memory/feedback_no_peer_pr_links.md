---
name: feedback_no_peer_pr_links
description: "Never relay another session's PR links to Charlotte; peers send them to the repo-owning session, not to her"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 80a695d8-d187-47ec-bf37-138c0dcdbe74
  modified: 2026-10-06T07:16:03.052Z
---

Don't pass on PR links (or branch names) that another Claude session sent. Charlotte (2026-10-06): "dont give me other session pr links and tell the other sessions too it gets confusing".

**Why:** with several sessions running, links from other sessions muddle which session owns what and what she has to do.

**How to apply:** when a peer reports a PR, check it yourself if useful, but don't relay the link. Tell her in plain words only if she has to act ("the slide notes change is ready to merge"). In the step 2b intro to other sessions, include the rule: PR links go to the session that owns the repo, never to Charlotte through another session. Related: [[feedback_coordinate_other_sessions_automatically]], [[feedback_peer_session_coordination_not_handoff]].

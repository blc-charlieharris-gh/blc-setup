---
name: feedback-peer-session-coordination-not-handoff
description: "When another session asks for \"a proper handoff before we overlap\", reply with state; don't write/commit a handoff unless Charlotte asks"
metadata:
  node_type: memory
  type: feedback
  originSessionId: bbe32563-1bcd-45b9-9c89-9d764f3bb3eb
  modified: 2026-10-01T07:35:39.859Z
---

When a peer Claude session asks for repo/branch/changes and "confirm once your handoff is written", Charlotte only wants the two sessions to talk so their END-of-session handoffs line up. She does not want a mid-session handoff doc + PR (1 Oct: I wrote and pushed one, she merged it but said it wasn't needed).

**Why:** a mid-session handoff is busywork and an extra PR for her to merge.
**How to apply:** answer the peer's questions by SendMessage (repo, branch, uncommitted/unpushed, overlap points), keep the tree clean, and write the handoff only at session end or when Charlotte asks. See [[feedback-session-management]].

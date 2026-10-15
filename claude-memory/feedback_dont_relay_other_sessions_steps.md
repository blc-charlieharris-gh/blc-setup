---
name: feedback-dont-relay-other-sessions-steps
description: "Never repeat another session's deploy/merge/SQL steps to Charlotte; just say that session has instructions for her"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 558f9bb1-834d-4dbb-99c7-5aafcbc25d38
  modified: 2026-10-15T18:45:45.425Z
---

When another Claude session has steps for Charlotte (run SQL, merge, press a button, deploy), don't relay them. Say only "<session> has instructions for you" and leave it to that session. Only list steps for my own work.

**Why:** Charlotte 2026-10-15: "dont tell me instructions for another session just say it has instructions or i get confused, tell other sessions this too". Two sets of steps for the same job confused her.

**How to apply:** In replies, peer updates are one line (what it finished + "it has instructions for you"). Tell each peer session the same rule at intro. Related: [[feedback_no_peer_pr_links]], [[feedback_messages_self_contained_chat_resets]].

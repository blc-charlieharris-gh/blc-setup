---
name: feedback-no-test-ask-when-reusing-proven-system
description: "Don't ask Charlotte to hand-test a new path that just plugs into an already-proven system (e.g. unsubscribe rule); verify it myself"
metadata:
  node_type: memory
  type: feedback
  originSessionId: d43ee852-48e3-4b2a-87c4-dde5aad18c7b
  modified: 2026-10-22T16:22:21.576Z
---

When a change only routes into a system that already works (10-22: Sales kit email unsubscribe reused api/broadcast-unsubscribe + applyEmailListEvent), don't end with "send yourself one and test it". She said: "the system works, doesn't need testing if you're using it."

**Why:** the shared rule is already proven live; asking her to test the reuse wastes her time and reads as unsure.

**How to apply:** verify the new joining piece myself (live fn version, a dummy-token call, deploy Ready), report it as done. Still ask for a live test when the path itself is new to users, see [[feedback-test-brand-new-signin-before-saying-accounts-work]].

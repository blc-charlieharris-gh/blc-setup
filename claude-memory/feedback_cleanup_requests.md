---
name: feedback-cleanup-requests
description: "When Charlotte flags an architectural issue or asks for cleanup, do it immediately, not later."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c3cf77bb-4eeb-457c-93e2-77442dee65f2
---

When Charlotte says something like "clean this up" or flags an architectural oddity, act on it in the same session. Do not note it, defer it, or assume it will be handled separately.

**Why:** She flagged that `users.json` for internal.installrhub is stored in `site-installrhub` (wrong repo) and asked for it to be cleaned up. It was not actioned, and the code was handed to the developer Serafim before it was fixed. The issue is now shipped and harder to fix.

**How to apply:** If Charlotte says "clean this up", "sort this", or points out something wrong, treat it as an immediate task. If the fix is risky or large, say so and agree a plan in the same session rather than leaving it open.

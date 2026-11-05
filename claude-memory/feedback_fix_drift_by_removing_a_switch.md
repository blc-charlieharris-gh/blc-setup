---
name: feedback-fix-drift-by-removing-a-switch
description: "When two states drift apart, remove one of the switches; don't add states, tracking or overrides to manage the gap (11-05)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 82406ba0-0b45-45ab-a8a5-d82ef35f5c8c
  modified: 2026-11-05T13:16:24.102Z
---

When a process drifts (Crew jobs 11-05: Publish put work on the portal, only the email moved the job, so they drifted), the fix is to remove the second switch so only one thing can change the state, not to add new stages, "told" tracking or reason-overrides to police the gap. Round 2 of the Crew mock-up did that and Charlotte said "feel like we're not simplifying this, we're complicating it?"; round 3 (Publish = With the client) was approved.

**Why:** extra states multiply the places that can disagree; she wants fewer moving parts and things removed.
**How to apply:** for any "these two screens disagree" problem, first ask which switch can go and make everything read the one that's left; mock up the simplest version first, list what gets removed. Related: [[feedback-no-parallel-copies-of-one-job]].

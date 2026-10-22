---
name: feedback-check-feedback-before-status-sql
description: "Before any SQL changing a client's status or what they see, check feedback/notes on the row and ask Charlotte first"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6358dbe8-cace-482d-9c45-33e49d51ebdf
  modified: 2026-10-22T12:35:19.690Z
---

Before giving Charlotte SQL that changes a client's status or anything client-facing (hub_clients.status, crew_deliverables.status, publish/approval state), read the row's signoff_notes / feedback / history and ask her whether it's mid-work. Never infer "leftover old state" from a handoff line alone.

**Why:** 10-22 I gave SQL moving J&B's website from deployed (her build board, his phone-number feedback in signoff_notes) to ready_to_preview (awaiting client approval), reading a handoff note "sites published before 10-22 show Publish for approval" as a stale state. She hadn't applied his feedback yet; had to undo it.

**How to apply:** query the notes/feedback columns first, state what they say, and confirm with her before handing over the SQL. Related: [[feedback_client_facing_means_portal_full_sweep]].

---
name: feedback-tell-serafim-when-his-ask-fixed
description: "When we fix or ship something Serafim's side asked for or that touches the app, send a cross_agent_notes row the same day (SQL for Charlotte to run)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6a33dffe-7abe-450c-b4b9-bfc677a26314
  modified: 2026-10-08T18:47:01.272Z
---

Charlotte 2026-10-08, after site PR #202 (webinar sign-ups no longer overwrite installer contacts' phone/name, Serafim's ask d87e9521) merged: "make sure serafim claude is aware next time". I had told her but not his side.

**Why:** Serafim's Claude only learns what we did from cross_agent_notes; without a note his side may build a duplicate fix or keep chasing.
**How to apply:** as soon as a fix for one of his notes (or anything touching shared data / GHL / the app) is merged and live, write an `INSERT INTO cross_agent_notes (author 'marketing', audience 'installrhub', ref_id = his note id, ...)` plus `read_at` stamp on his note, put it in `~/Code/BLC/_deploy/`, pbcopy it, and ask Charlotte to run it. Don't wait for handoff. Format per marketing-agent `.claude/docs/cross-agent-notes.md`. Related: [[feedback_serafim_signoff_and_handoffs]], [[reference_blc_supabase_cli_wrapper]].

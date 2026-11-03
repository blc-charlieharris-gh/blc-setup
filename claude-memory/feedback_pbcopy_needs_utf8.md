---
name: feedback_pbcopy_needs_utf8
description: "Always LANG=en_US.UTF-8 pbcopy; this shell has no LANG, so plain pbcopy mangles £ — · emoji into ¬£ ‚Äî üé• in anything Charlotte pastes (SQL, edge fns)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: b5437a73-bedd-46e2-b804-8bbdbff4b93e
  modified: 2026-11-03T10:55:00.012Z
---

3 Nov 2026: the booked-call nurture emails went into the Hub with "üé•", "‚Äî", "¬£" because the SQL I put on her
clipboard was copied with plain `pbcopy` (LANG empty in Claude's shell, so pbcopy reads bytes as MacRoman). Live
nurture-resend-webhook showed "¬£N" in a comment too: every paste-deploy from my clipboard is affected.

**Why:** Charlotte pastes SQL and edge functions from my clipboard; mangled characters reach real emails and logic
(register-installer's hours regex has – and —).
**How to apply:** always `LANG=en_US.UTF-8 pbcopy < file`; check with `LANG=en_US.UTF-8 pbpaste | grep <emoji>`.
Prefer ASCII in SQL I hand over. Related: [[feedback_open_sql_editor_in_browser_pane]],
[[feedback_rebuild_deploy_files_before_paste]].

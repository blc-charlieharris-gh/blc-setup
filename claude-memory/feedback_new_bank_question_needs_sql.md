---
name: feedback_new_bank_question_needs_sql
description: A new standard client question added to PARAM_DEFAULTS never shows once Parameters > Client questions has been saved; ship it with an append SQL
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9b517cff-3cc4-4bdb-9b34-a250456a2d0e
  modified: 2026-10-15T15:51:23.025Z
---

questionBank() (src/lib/clientQuestions.js) uses the saved marketing_parameters.params.clientQuestions.bank whole, and only falls back to PARAM_DEFAULTS when nothing is saved. So a question added in code (trustpilot_widgets, 10-15) is invisible once Charlotte has saved her list. She saved at 15:36 on 10-15 and the Trustpilot question vanished until she ran an append SQL.

**Why:** her saved list is the source of truth and may drop defaults on purpose, so merging defaults back in would undo her deletions.
**How to apply:** any new bank question goes out with an idempotent append SQL (jsonb `||`, `where not bank @> '[{"key":...}]'`, version + 1) on her clipboard in the same turn. 10-15 also made one legal question: the Parameters "Accreditations & Legal" (key accreditations) list, with the audit's gaps folded in via withAuditItems (#1997).

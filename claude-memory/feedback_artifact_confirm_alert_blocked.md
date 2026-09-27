---
name: feedback_artifact_confirm_alert_blocked
description: confirm()/alert() are silently blocked inside published Artifact pages; use inline two-click confirm and toasts
metadata:
  type: feedback
---

In published Artifact pages, `confirm()` returns false immediately and `alert()` never shows (sandboxed frame). A remove button gated on `if (confirm(...))` silently does nothing. Found 2026-09-22 when Charlotte's checklist × buttons on Erin's page ([[project_erin_onboarding_plan]]) did nothing.

**Why:** she hit it as "doesn't seem to be removing things".
**How to apply:** never use confirm/alert/prompt in artifact pages. Use an inline two-click "Remove?" arm pattern and an on-page toast for errors.

---
name: feedback-supabase-dashboard-deploy-silent-noop
description: "Editing an edge function's code in the Supabase dashboard editor does not deploy it until Deploy is explicitly clicked; verify via the function's version/updated_at, not by trusting the edit happened"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 44cde540-6616-4a88-a3b2-aa3dcd206c88
  modified: 2026-09-03T12:47:54.073Z
---

Pasting corrected code into the Supabase dashboard's Edge Function code editor (for a function like `register-installer` that isn't in any local repo, so the dashboard is the only edit path) does not deploy it on its own. There is a separate explicit Deploy action, and skipping it leaves the live function completely unchanged with no visible error, the editor just shows the pasted text as if it saved.

**Why:** discovered 2026-09-03 in marketing-agent. Walked Charlotte through pasting a fix into `_shared/onboarding-satellites.ts` via the dashboard; she reported "done", but `list_edge_functions` showed the function's `version` and `updated_at` completely unchanged from before the session started. The fix silently never shipped. Only after explicit retry instructions ("find the actual Deploy button, saving text alone is not enough") did the version bump.

**How to apply:** after ANY dashboard-based edge function edit, verify via `mcp__supabase__list_edge_functions` (check `version` bumped and `updated_at` is recent) or `get_edge_function` (pull the live source and grep for the actual change) before telling the user or anyone else the fix is live. Don't take "I pasted it" or "done" as confirmation, verify from the DB/API side every time. Related: [[project_edge_fn_repo_drift_A0]] — a dashboard hotfix like this also makes the function's owning repo (if any) stale, same drift risk as that issue describes.

---
name: project_homeowner_leads_stay_on_ghl_1104
description: "Client + Green Tide homeowner leads keep GHL contact ids; own \"ih\" ids are InstallrHub sales only; call tasks round-trip GHL"
metadata:
  node_type: memory
  type: project
  originSessionId: 1d6a6b9c-fae5-4d9f-82aa-17a3e530f2c8
  modified: 2026-11-04T16:52:07.212Z
---

Charlotte 11-04 chose "keep as is": client and Green Tide homeowner leads stay on GHL ids (her 11-02 decision, #3051). Our own `ih` ids (_shared/personId.js) are for InstallrHub sales people only (installer forms, webinar, mailing list).

Homeowner call tasks: Hub/app write `scheduled_tasks` (ghl_contact_id NOT NULL) -> app `task-scheduler` posts a GHL task -> `sync-team-tasks` mirrors into `team_tasks` -> telesales tick them in the app's Call Centre bubble. The bubble opens the lead via `leads.additional_info.ghlContactId` (app chunk taskRouting), and shows non-callback tasks at once whatever due_at says.

**Why:** "GHL is NO MORE" meant the sales side; homeowner side still needs GHL ids. David Facer (new retainer client 11-04, 70 leads uploaded with no id) is a one-off, leave it.

**How to apply:** if homeowner leads ever move to own ids, call tasks need Serafim's app change first (task-scheduler writes team_tasks inhouse, bubble links by lead_id, ghl_contact_id nullable). Findings: side-session note ghl-call-centre-tasks-1104.md. Related: [[feedback_ghl_never_a_fallback]], [[project_ghl_removal_hub]].

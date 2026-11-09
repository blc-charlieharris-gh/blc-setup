---
name: project_homeowner_leads_stay_on_ghl_1104
description: "Homeowner leads (Green Tide, client, marketplace) ARE moving to the CRM, off GHL entirely (Charlotte 11-09, replaces her 11-04 'keep as is'); needs a plan covering everything dependent on GHL"
metadata:
  node_type: memory
  type: project
  originSessionId: 1d6a6b9c-fae5-4d9f-82aa-17a3e530f2c8
  modified: 2026-11-09T12:17:49.662Z
---

Charlotte 2026-11-09: "we're moving to the crm and off ghl entirely", including Green Tide, client and marketplace leads, "and anything else at all which is dependent on ghl". This replaces her 11-04 "keep as is" (homeowner leads stay on GHL ids).

Serafim leads it; the Hub only asks him where to read things (note `ghl-homeowners-who-does-what-1109`).

Until the plan is agreed these are still true: homeowner leads carry GHL ids; our `ih` ids (_shared/personId.js) are InstallrHub sales only.

Homeowner call tasks today: Hub/app write `scheduled_tasks` (ghl_contact_id NOT NULL, checked 11-09) -> app `task-scheduler` posts a GHL task -> `sync-team-tasks` mirrors into `team_tasks` -> telesales tick them in the app's Call Centre bubble. The bubble opens the lead via `leads.additional_info.ghlContactId` (app chunk taskRouting).

**Why:** the telesales CRM link (#3170) goes live 15-16 Nov; `crm_tele_leads_mode` = on skips GHL for the `leads` and `greentide` accounts and writes the lead keyed `crm:<hash>` with no GHL contact.

**How to apply:** treat GHL for homeowners as going, never a fallback ([[feedback_ghl_never_a_fallback]]), but each switch-off still follows the replace-every-job rule ([[feedback_replace_every_job_not_every_piece]]) and needs her go-ahead ([[feedback_crm_crossover_additive_only]]). Call tasks need Serafim's app change or the CRM doing that job first. David Facer (70 leads uploaded with no id, 11-04) is a one-off, leave it. Related: [[project_ghl_removal_hub]].

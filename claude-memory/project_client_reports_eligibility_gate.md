---
name: project-client-reports-eligibility-gate
description: "clients.reports_enabled opt-in toggle + live/onboarding-status/7-day-spend gate now controls the Clients > Reports picker, live 2026-09-14 (PRs #769, #770)"
metadata: 
  node_type: memory
  type: project
  originSessionId: c8ed8129-d200-41a1-b91c-cfea43b2604b
  modified: 2026-09-14T12:52:36.342Z
---

Charlotte flagged (2026-09-14, ahead of a new starter joining the marketing team Thursday
2026-09-18) that which clients get a weekly report only lived in her head. Fixed end to end:

**Schema:** `clients.reports_enabled boolean not null default true` (migration
`20260914120000_clients_reports_enabled.sql`), column-scoped `grant update` (this table is
column-allowlisted, shared with InstallrHub). Applied live by Charlotte via the Supabase SQL
editor (Serafim's Tier-2 review role, self-covered).

**UI:** `ClientCard.jsx` Setup section has a "Weekly reports" toggle, gated on a new
`reportsReady` readiness flag from `useTrackingSettings.js` (same degrade-gracefully pattern as
`cplbReady`/`linkReady` — a column that doesn't exist yet 400s the WHOLE clients query otherwise).

**Picker gate** (`ClientReports.jsx`): a client is only offered once ALL of:
1. `reports_enabled !== false` (default true = opt-out, not opt-in by default)
2. `isLive(c)` (`is_active && is_tracked`, from `clientScope.js`)
3. `clientState(c, onbStatus) === 'live'` — NOT `is_active`/`is_tracked` alone. Follow-up fix
   (PR #770): Helix Power and Outlook Energy both had `is_tracked=true` but were still mid-
   onboarding (`client_onboarding.status = 'onboarding'`), so they passed the original `isLive`
   check and appeared in the picker anyway. Reuses `clientWorkspace.js`'s `clientState`, the exact
   function behind the Live/Onboarding badge on Clients > Manage, so the two pages can't drift
   apart on what "live" means again.
4. ≥7 full days since first recorded spend (`campaignPhase(firstSpend).daysRunning >= 7`, via a
   new bulk hook `useClientsFirstSpend` in `useClientReport.js`)

**Why:** see [[feedback_confirm_which_page_before_implementing]] pattern of care taken here —
the "live" check specifically needed two rounds because `is_tracked` alone isn't the same concept
as the onboarding-board's Live badge, a distinction that bit this exact fix once already.

**How to apply:** any future "who counts as live" check in this app should default to
`clientState()`, not `isLive()` alone, unless the onboarding dimension is genuinely irrelevant to
that surface. See [[feedback_design_performance_data_durability]] for a related but distinct
"is_tracked gates visibility" gotcha in Creative Testing.

---
name: project-client-portal-ours
description: "Client portal (10-12): we own it now, not the app; magic-link sign-in on crew.installrhub.com, Serafim's installer-leads-* functions are the engine, his /leads pages retire"
metadata:
  type: project
---

Charlotte 2026-10-12: "we own this now not the app, it's on us to ensure it works, is smart, looks good, and helps clients
and client retention." The client portal (surveys pipeline, availability, locations, bookings, team, campaign, reports,
plus CREW work for brand clients) lives in the Hub on crew.installrhub.com, branded InstallrHub.

- Plan: `.claude/docs/current-plan.md` (portal section); map of the app's engine: `.claude/docs/portal-map.md`.
- Sign-in: magic link by email, stay signed in per device; only `company_members` emails; everything behind sign-in
  (homeowner details). Users area: main contact adds/removes, InstallrHub admins too; Hub permission "Client portal".
- Engine: Serafim's installer-leads-* edge fns, called through a Hub `client-portal` function that checks team membership
  and uses the company's link + code server-side. Then retire his /leads pages, then swap link+code for sign-in inside the
  engine (his sign-off). Serafim agreed (10-12).
- Scope: retainers, brand clients, new marketplace (direct booking). Old pay-per-survey marketplace stays on the app for
  now, decided at the end. Staff see it in the Hub AND "View as client".
- Design: the approved dashboard (installrhub.com style) + installer-mot premium touches; tabs grouped (InstallrHub /
  CREW / Account).

**Why:** retention: clients get one premium place; one engine so rules never drift.
**How to apply:** treat portal bugs/UX as ours to own end to end; test writes only on test companies (WhatsApp Test
Installer, placementtestingignore): every engine call fires real homeowner messages and charges. Related:
[[project_client_area_plan]], [[feedback_no_duplicate_solutions]].

---
name: project_crew_dashboard_tab
description: "CREW workspace got a Dashboard tab (roster across all clients) 2026-08-18, PR crew-dashboard-tab awaiting merge"
metadata:
  type: project
  originSessionId: c3b34899-d0f2-4b1c-b54f-61452cead0eb
  modified: 2026-08-18T12:07:49.353Z
---

`src/pages/hub/Crew.jsx` got a new "Dashboard" tab (2026-08-18), first in the tab row, default landing
view. Shows every `crew_clients` row in one table: type (own/client/prospect via `recordKind`), website
build stage + delivery method (joined from `hub_clients` via `hub_client_id`), and an inline-editable
`notes` cell. `crew_clients.notes` already existed in the DB but had NO UI anywhere before this, worth
remembering if a future "where do I note X about a client" question comes up.

Click a client's name in the dashboard to jump straight into their existing per-client Overview tab
(`setActiveId` + `setTab('overview')`).

Motivated by [[project_gasworx_website]]: Charlotte wanted one place to see who's in build/live/
transferred/hosted, plus somewhere to note integration details (e.g. Gas Worx's Soro AI RSS sync).
That note itself needs adding by hand in the new UI once merged, the Supabase MCP connection this
session had was read-only.

Shipped as branch `crew-dashboard-tab`, PR opened, not yet merged as of session end. Build/lint verified
clean in isolation and via full `npm run build` (zero errors attributable to this file).

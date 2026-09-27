---
name: crew-status-alignment
description: 2026-09-21 Crew deliverable statuses drive Manage Clients board columns (#847-#852), access gates, merged access card; how the pieces fit
metadata:
  type: project
---

Shipped + live 2026-09-21 (PRs #847-#852, migration 20260921120000 applied):
- `crew_deliverables.status` (logo/google/social) drives the board card's column; labels shared via `deliverableStatusLabel(d, gate)`. Untouched `requested` rows defer to the old checklist logic on purpose (unsynced Google/social work would otherwise jump back).
- Gates are derived, not stored: Awaiting form (`form_submitted`), Awaiting access (Google `google_access`, social `fb_access`). Access gate only holds while the row is untouched, so a manual status moves it past.
- Every card in Awaiting access folds into one `access` card with Google/Facebook pills; clicking a pill ticks that access.
- Manual moves are not sticky by design (Charlotte): a later automatic event may overwrite them.
- Approved logos now stay visible in Ready until marked Transferred (changed from 09-19 fold-on-approval).

Known open: ads `awaiting` card dropped from board (no `awaiting` column), see known-issues.md. Harvard's package lost social 09-17 to 09-21, restored by hand.

**Why:** Charlotte wanted one status vocabulary, mostly auto-driven, always manually movable.
**How to apply:** new branding track logic goes through `boardCards()`/`deliverableGate`, not a parallel status. Related: [[project_crew_workspace]], [[project_crew_logo_studio]], [[instagram-scope]], [[hub-only-migrations-no-serafim-review]].

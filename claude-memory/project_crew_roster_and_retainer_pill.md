---
name: crew-roster-and-retainer-pill
description: "2026-09-19 CREW roster live/onboarding only + bought pills (#824) and retainer pill (#823) merged; dropdown filter + legacy website sync pending on feat/crew-dropdown-in-play"
metadata: 
  node_type: memory
  type: project
  originSessionId: 07487d2b-9861-4f5f-9076-12ff5df64fed
  modified: 2026-09-19T10:56:09.728Z
---

Merged 2026-09-19 as #823/#824. Follow-up `feat/crew-dropdown-in-play` (pending): dropdown uses same in-play rule; PackageCard sync treats legacy packages.crew as website (Jones and Baker had crew:true but sync ignored it, so no build existed).

- `fix/retainer-pill-consistency`: blue vs grey "Retainer" was two different pills (legacy leads/calling flag vs new offer-model badge). isRetainer now includes offer==='retainer'; grey badge shows only length ("3 months").
- `feat/crew-roster-live-bought`: CREW Dashboard tab logic in src/lib/crewRoster.js. In-play rule = onboarding, or is_tracked, or client_onboarding.status 'active' (website-only clients like LW Heating have no ads row), own brands always. Paused/not-live hidden behind a toggle (HQ Group, Synergi, ZZ tests).

**Why:** Charlotte wanted the roster limited to clients in play and easier to see what each bought and its progress.
**How to apply:** if asked why a client is missing from CREW Dashboard, check rosterState; tone colours: grey not started, amber in progress, blue with client, green done. Related: [[project_crew_workspace]]

---
name: feedback-manage-clients-subcard-styling
description: Manage Clients Kanban board sub-cards (branding legs) must be yellow and small/condensed
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 696dfa91-015b-4c1c-8308-6a8e631cf4a2
  modified: 2026-09-17T21:36:02.759Z
---

On the Manage Clients Kanban board (`OnboardingBoard.jsx`), every branding-track card (website,
logo, google, social, content) is a "sub-card" of the client's one retainer/ads "main card" and
must render yellow and condensed, mini-sized, always, not just when that client also has a
retainer/ads card present.

**Why:** Charlotte's explicit instruction (2026-09-17): "the sub cards on manage clients should
be yellow and all sub cards should be a small condensed little mini card." The board splits a
client into one card per job they bought (see `boardCards()` in `onboardingChecklist.js`); the
retainer/ads card is the one main card, every branding leg is visually a smaller, yellow satellite
of it.

**How to apply:** In `Card()` (OnboardingBoard.jsx), `isChild` is true whenever
`BRANDING_TRACKS.has(entry.track)` — no longer gated on the client also having an ads card
elsewhere on the board. Sub-card styling: `bg-yellow-50 border-yellow-300`, tight padding
(`px-2 py-1`), `rounded-md` (not `-lg`), 11px name / 9px meta text, no package-badges row (that's
whole-client info, redundant once already split). Keep this in mind for any future board redesign
in this area — see [[project_manage_clients_board_redesign]] if that memory exists, or the plan
file `partitioned-coalescing-cook.md` for the original board-split architecture.

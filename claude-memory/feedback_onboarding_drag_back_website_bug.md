---
name: feedback_onboarding_drag_back_website_bug
description: "Dragging a completed website card back onto \"Website build\" on the Onboarding board silently no-ops instead of splitting the card, bug in useClientOnboarding.js:109"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 9c6e7f66-dfcd-4521-867d-936b0a4d3bfd
  modified: 2026-08-19T12:38:58.994Z
---

Found, not fixed (2026-08-19): on the Onboarding kanban board, dragging an already-live client's
card back onto the "Website build" column does nothing visible. `COLUMN_PATCH.website_build` in
`src/hooks/useClientOnboarding.js:109` only clears `checklist.awaiting_website`, it never
un-ticks `checklist.website`. For a client whose `checklist.website` is already `true` (e.g. Gas
Worx), the drag collapses the card straight back into "Live" instead of splitting it out into a
website card.

**Why:** the patch was written assuming `awaiting_website` is the only gate; it doesn't account
for the case where `website` itself is already ticked from a prior state.

**How to apply:** if the Onboarding board needs a website item re-opened for an already-live
client, un-tick the "Website build" checklist item by hand instead of dragging the card. Worth a
real fix (also un-tick `checklist.website` in the same patch) if anyone is touching
`OnboardingBoard.jsx` / `useClientOnboarding.js` this session. See
[[project_client_onboarding_engine]].

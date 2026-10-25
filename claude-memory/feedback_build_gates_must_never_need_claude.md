---
name: feedback-build-gates-must-never-need-claude
description: "Crew website build gates must be passable by Erin in the Hub alone; research checks ask \"covered\", never \"client has it\"; sweep all gates at once"
metadata:
  node_type: memory
  type: feedback
  originSessionId: d0af24c7-14bc-46f8-b15e-2e29a213653b
  modified: 2026-10-24T12:48:15.980Z
---

Every check on a Crew website step must be something the builder can satisfy in the Hub without coming back to Claude. Research checks ask whether the research *covered* a topic ("looked, none found" passes), never whether the client *has* it (reviews, accreditations, quotes). Steps before the build never wait on the site check.

When one gate turns out wrong, sweep every gate in the flow in one go and fix them together. Don't patch the one she hit.

Badges come only from confirmed accreditations: website form ticks, or a register number found by the research. Unverified ones are never shown and get asked with the preview.

**Why:** Charlotte 10-24, walking Helix through as Erin: "this won't work if every new research for a new client brings up a new step i need to run through you to fix". Separately, unverified MCS, TrustMark and RECC were auto-added to Helix's brand kit.

**How to apply:** before shipping any new website rule or check, ask "can a brand-new client with nothing (no reviews, no accreditations, no photos) pass this, and can Erin do it alone?" See [[feedback-audit-scope-checklist]].

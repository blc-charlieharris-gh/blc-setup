---
name: crew-audit-build-gotchas
metadata:
  node_type: memory
  type: feedback
  originSessionId: f7c88668-5509-43cd-abb7-cb9f7ab2f007
  modified: 2026-10-05T16:35:02.215Z
---

When running a CREW site audit (crew-audit skill, e.g. Elect 2026-10-05, #1480):
- Since 10-05 the template is `marketing-agent/scripts/sitescore/` (build.mjs + clients/<slug>/content.json + assets, in git). Elect is the example. No prices on the page (Charlotte).
- The deliverable is the password-gated page in `marketing-agent/public/sitescore/<slug>/` + a `CREW_SITESCORE` line, via PR. Briefs copied from Crew before 2026-10-05 still say "return a scores JSON"; ignore that (fixed in `crewAuditBrief.js`).
- Text found in raw HTML is not proof it shows on screen: Squarespace left 10 "New List Item / Click Here" blocks in Elect's HTML that never render. Confirm with a full-page Puppeteer shot before making it a finding.
- Map every route a homeowner can take, including homepage service cards on the second site, before writing "the only route is X". Elect's first draft said heat pumps were only in a Services dropdown; the energy homepage also has a heat pump card. Search the rendered text before saying a phrase "never appears".
- Don't default to praising design. Charlotte rated Elect's design one of the worst parts; the draft called it the best (74). Give an honest, polite read and check with her if unsure.
- Squarespace accordion content (e.g. grant FAQs) needs a click before the shot.

**Why:** each cost a retry or nearly became a false finding in the Elect audit.
**How to apply:** check these before building the next audit. Related: [[feedback_audit_findings_simple_with_options]]

---
name: crew-audit-build-gotchas
description: "CREW SiteScore audit build gotchas: deliverable is the hosted page not JSON, which build-report.mjs to copy, check findings actually render"
metadata:
  node_type: memory
  type: feedback
  originSessionId: f7c88668-5509-43cd-abb7-cb9f7ab2f007
  modified: 2026-10-05T16:35:02.215Z
---

When running a CREW site audit (crew-audit skill, e.g. Elect 2026-10-05, #1480):
- The deliverable is the password-gated page in `marketing-agent/public/sitescore/<slug>/` + a `CREW_SITESCORE` line, via PR. Briefs copied from Crew before 2026-10-05 still say "return a scores JSON"; ignore that (fixed in `crewAuditBrief.js`).
- Copy `build-report.mjs` from `meta-access/outputs/sitescore-helix-power-ltd/` when the client logo is a raster crop; the glowgreen one hard-codes `gg-logo.svg` and crashes.
- Text found in raw HTML is not proof it shows on screen: Squarespace left 10 "New List Item / Click Here" blocks in Elect's HTML that never render. Confirm with a full-page Puppeteer shot before making it a finding.
- Squarespace accordion content (e.g. grant FAQs) needs a click before the shot.

**Why:** each cost a retry or nearly became a false finding in the Elect audit.
**How to apply:** check these before building the next audit. Related: [[feedback_audit_findings_simple_with_options]]

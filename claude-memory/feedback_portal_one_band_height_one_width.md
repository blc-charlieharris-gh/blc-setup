---
name: feedback_portal_one_band_height_one_width
description: "Portal rule (10-19): the dark band (header) is one fixed height on every screen and the page is one width; nothing jumps when moving between tabs or steps"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1f20e8bd-ec43-45b2-b156-87610b78e038
  modified: 2026-10-19T13:43:14.264Z
---

Every client portal screen keeps the same band (header) height and the same page width, so nothing jumps around when moving between tabs, onboarding steps, welcome or "all set" screens. Charlotte, 10-19, approving the onboarding journey design: "ensure as a site wide rule that the header height stays same dont jump around and page width says consistent".

**Why:** a band that grows or shrinks per screen makes the sheet start in a different place each time, which reads as cheap; she asked for premium spec.

**How to apply:** use the one band height (PortalBand BAND_H) and the one centred column (PublicShell COLUMN, 1440px) for every portal screen, including Home and the onboarding journey; never give a screen its own taller band or its own max-width. Designs for the portal follow it too. Related: [[feedback_audit_findings_simple_with_options]].

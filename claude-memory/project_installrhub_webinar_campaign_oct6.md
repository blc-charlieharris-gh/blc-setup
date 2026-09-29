---
name: installrhub-webinar-campaign-oct6
description: "IH webinar 6 Oct Meta campaign runs 30 Sep 08:00 to 6 Oct 17:00, optimises Webinar Registration; pixel has CAPI Lead from an unknown source"
metadata:
  node_type: memory
  type: project
  originSessionId: 55ebdf36-4e07-46a7-8304-dac645f92cfe
  modified: 2026-09-29T14:18:43.067Z
---

**IH - Webinar 6 Oct - Registrations** (`120250485863060731`, act_7095438517245067): CBO £60/day, runs 2026-09-30 08:00 to 2026-10-06 17:00. It optimises for custom conversion Webinar Registration `2258431381610266` (Lead on /webinar/thank-you). Plain Lead also fires on other pages, so it was rejected. Targeting copies MOF - Direct to offer (3SEC-ALLVIDEOS-TOF) and excludes `Website-WebinarRegistrants (thank-you, 30d)` `120250485468180731`.

The pixel 6022454534459147 receives server (CAPI) Lead + PageView events (7d to 09-29: Lead 29 browser / 37 server). No site code sends them, so the source is unknown. Check Events Manager > pixel > Settings.

**Why:** Charlotte assumed "we have CAPI". It's true, but the feed isn't ours to see in code.
**How to apply:** around 2026-10-01, compare Meta registrations with GHL. If Meta is well under, chase the server feed. MOF DTO is £80/day since 09-29 (her change). Related: [[installrhub-meta-tracking]], [[installrhub-standard-url-tags]].

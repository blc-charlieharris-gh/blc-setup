---
name: installrhub-webinar-meta-tracking
description: Webinar registrants feed MOF retargeting via PageView rule; Webinar Registration custom conversion waits on IH_TRACK_LEAD site change
metadata:
  type: project
---
2026-09-21, InstallrHub act_7095438517245067:
- `Website-LeadConverters (InstallrHub+Forecast+Webinar)` (120250039917760731) gained a PageView rule on `/webinar/thank-you`. Live MOF campaign is "MOF-Retargeting Campaign - Copy" (120250219254990731); the original is PAUSED.
- Custom conversion "Webinar Registration" (2258431381610266) = Lead event on `/webinar/thank-you`. Records nothing until site-installrhub adds `window.IH_TRACK_LEAD = true` to webinar/thank-you/index.html (handed to that session 09-21, not yet confirmed live).
- TOF-Engagement and MOF - Direct to offer both set to £60/day.

**Why:** Charlotte may run webinar conversion ads.
**How to apply:** before building a webinar campaign, confirm the site change shipped (check the pixel fires ev=Lead on the thank-you page). Related: [[project_installrhub_webinar_oct6]]

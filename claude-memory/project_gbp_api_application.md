---
name: project-gbp-api-application
description: "Google Business Profile API: applied 10-21 from Cloud project installrhub-hub-client-media (488435496724); no GBP access until approved"
metadata:
  node_type: memory
  type: project
  originSessionId: e51549ae-39ac-42d5-91f2-ab90a730fe4b
  modified: 2026-10-21T12:22:15.615Z
---

2026-10-21: we had NO Google Business Profile API access (Hub's only Google OAuth is Drive scope, `_shared/googleDrive.ts` DRIVE_SCOPES). Charlotte applied for "Application for Basic API Access" via https://support.google.com/business/contact/api_default using Cloud project **InstallrHub Hub - Client media** (`installrhub-hub-client-media`, project number **488435496724**), the same project as the Hub's Drive sign-in. "installrhub.com 636176098576" in Manage resources is the organisation, not a project.

First application (10-21, J&B's profile picked) was rejected instantly by the form ("doesn't meet our criteria"). Likely causes: website on the form not matching the chosen profile's (use jonesandbaker.co.uk), a non-@installrhub.com email, or the applying account not being a manager on that profile. Plan B: a local SEO tool's API (BrightLocal/Localo).

Approval check: APIs & Services > My Business APIs > Quotas: 0 QPM = waiting, 300 QPM = approved.

**Why:** public screenshots can't see secondary categories, attributes, pending edits or (without a click) services, so Google audits leave 4-5 as-found items for staff (Jones & Baker 10-21).
**How to apply:** once approved, add the business.manage scope to the Hub's Google sign-in and have the Google job read all 16 items itself. Until then never claim we have GBP API access. Related: [[project_crew_google_profile_checklist]].

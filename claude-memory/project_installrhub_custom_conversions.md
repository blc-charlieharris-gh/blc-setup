---
name: project-installrhub-custom-conversions
description: "InstallrHub Meta custom conversions (10-03): Installer MOT Lead created, PageView conversions still used by paused WEB ad sets, meta-sync custom fallback risk"
metadata:
  node_type: memory
  type: project
  originSessionId: dc118fd2-09f9-4fc6-8710-f54e69b93607
  modified: 2026-10-03T14:36:38.290Z
---

InstallrHub (act_7095438517245067, pixel 6022454534459147) custom conversions, checked 2026-10-03:
- **Installer MOT Lead** 1459921549283706 (LEAD, Lead + URL i_contains /installer-mot), created 10-03 with Charlotte's OK. Goal for MOT ads. MOT sign-ups count as sign-ups not sales leads on the Hub KPI page (#1385).
- **InstallrHub Lead** 2029603298436601 (PageView /book-a-demo) and **BLC Schedule** 701599905991249 (PageView any "thank-you" URL) are the goal of 14 PAUSED old "HP/Solar | Look a Like | WEB" ad sets. Kept, not archived. Never restart those ad sets as-is: switch goal first.
- **InstallrHub Booking** 807560985310340 never used; Charlotte to archive in Events Manager (not via API, unsure DELETE archives vs deletes).

**Why:** meta-sync (index.ts ~479) sums ALL offsite_conversion.custom.* when an ad has no standard Lead and isn't OUTCOME_LEADS, so a PageView conversion goal would count visits as leads. Not happening as of 10-03 (90d: all IH rows result_type 'lead').
**How to apply:** "no active ad uses it" is not "unused"; always check paused ad sets' promoted_object before recommending archive. See [[feedback_meta_lead_counting]].

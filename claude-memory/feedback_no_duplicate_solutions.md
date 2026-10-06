---
name: feedback-no-duplicate-solutions
description: Charlotte's build rules from 30 Sep: one way to do each thing, keep it simple, nothing a client tells us may be lost
metadata:
  type: feedback
---

Charlotte 2026-09-30: (1) "I don't like duplicate solutions": one way to see or do each thing (e.g. removed the shared-account tick because toggling a campaign off already did the job; one board view, no By job/By client switch). (2) "Stop over-engineering it": when she describes a simple flow (Sales add-ons = tick Brad/Kornelius, send email, done), build exactly that. (3) Nothing a client tells us in onboarding may be lost; every question asked must be stored somewhere used (onboarding answer map test enforces it).

**Why:** earlier builds added parallel paths and extra tracking she then had to reason about.
**How to apply:** before adding a control/view/setting, check an existing one doesn't already do it; propose the simplest version first; ask only when genuinely unclear. Related: [[feedback-audit-changes-must-not-break]].

**10-06, rules too (Charlotte: "cannot have rules drifting and two things doing the same thing differently or diverging, it creates mess"):** every question the Hub answers (has a campaign, is live, owes access, job column, client type, what counts as a lead, who owns a job) comes from ONE function. Kcglinks: the board used runsCampaign, the task-maker an older runsAds copy, so marketplace campaigns never got build tasks. Before adding logic, grep for an existing answer to the same question and reuse it; a second copy is a bug even if it agrees today. Audit README now has "one rule per question" + journeys + always-true checks.

---
name: project-creative-workflow-preview
description: "Charlotte + Erin creative workflow (Bank, Taskboard, Library, launch checklist, Why it works) on a practice-mode preview branch, not merged, migration not applied (2026-09-27)"
metadata:
  node_type: memory
  type: project
  originSessionId: a691ea9b-d85c-4f1f-bcbc-ce168304405b
  modified: 2026-09-27T11:49:15.639Z
---

Branch `feat/creative-workflow-preview` in worktree ~/code/BLC/marketing-hub/wt-creative-workflow (marketing-agent). Preview alias: marketing-agent-git-feat-creative-workflo-dead39-blc-promotions.vercel.app. Practice mode (src/lib/practiceDb.js) saves to the browser away from installrhub.com, so nothing hits the DB; migration 20260927120000_creative_workflow.sql is NOT applied and there is no PR yet.

Scope: Bank (Ideas+Inspo), /taskboard (all task types, checklists, Done collapsed), Library (3 sizes: 1200x1200, 1080x1920, 1200x628, blurred-copy fill; old Backlog as "Older uploads" with run/not-tried coverage), launch checklist with client Elements, Why it works (AI ingredients via OpenRouter gemini-3.8-flash, videos transcribed, per-account consistency). Clients > Manage: assign set-up checklist items + per-job builders (hub_track_owners), task made when a card moves into its build column. Ended tests / Design performance / Backlog hidden from the tab bar, data kept.

Later the same day: Taskboard repeating jobs (daily check = campaign_checkins, weekly reports = useReportsDue), SOPs > Checklists (client per job / task, one marked for launch), Parameters > Who does what, test launches start real tests (src/lib/launchTest.js), AI tagging with shared list src/lib/ingredientTaxonomy.js + AI check page, leads+surveys verdict vs targets.js. Split agreed 09-27: blc-30 keeps real checklists + backfill; the main audit session builds Actions events, client-card checklist merge, server-side runs, migration + PR.

State at end of 27 Sep: branch frozen at 742e1089 (contains main e674d99f), handed to the main audit session (blc-f8) to apply the migration and open the PR. Charlotte's agreed checklists live in artifact https://claude.ai/artifact/DB6KJrPg8r19di2S1EA4BM (collection checklists) and in STARTER_CHECKLISTS; 'Reviewed and approved' is hers, 'Set live' last. Backfill is ON HOLD until the branch is merged: plan is bulk upload into the Library (resize, AI tag, match to Meta ads by image similarity incl. 64px thumbs, Charlotte confirms). Offered a 'shopping list' of every creative that spent in the last 90 days; Charlotte said hold off (switching devices, the other session will update).

**Why:** Charlotte (UK) and Erin (Japan, ~2h overlap) need an async create/upload/launch/analyse rhythm; 10 new creatives a week (5 heat pump, 5 solar).

**How to apply:** Charlotte approves ideas. Launch is manual in Ads Manager for now. Planned after sign-off: a backfill project where Charlotte uploads existing creatives, they get bulk resized and tagged to ads that ran in the last 60-90 days. The audit session (blc-f8) reviews before merge; tell it before touching nav, paramDefaults, Parameters or Clients > Manage files. Related: [[feedback-serafim-signoff-and-handoffs]].

---
name: todo-queue-1016
description: "Charlotte's open queue at 16 Oct (usage 94%): small fixes, portal/Hub phase 2, audit, rollout; check off as done"
metadata:
  node_type: memory
  type: project
  originSessionId: 558f9bb1-834d-4dbb-99c7-5aafcbc25d38
  modified: 2026-10-16T07:11:06.342Z
---

Queue from Charlotte 2026-10-16 morning (marketing-agent unless noted). DONE 10-16: 1 (fns deleted, verified), 2-6 on branch fix/hub-small-batch-1016 (merge pending). Rest next session.

1. Delete 10 retired Hub fns in Supabase (Serafim OK'd verbally): hub-intake-public, hub-intake-send, hub-signoff-public, hub-signoff-send, hub-generate-copy, hub-generate-design, hub-deploy-site, hub-crawl-site, hub-crawl-reviews, marketplace-campaign (note ref hub-functions-to-hub-2026-10-14). Remove repo copies too.
2. Dashboard "this week so far" hover: no explainer; just week's spend to date, CPL, CPS, leads/surveys vs expected, at a glance.
3. Actions: one "Ads to tag" card instead of one per live ad.
4. Actions "Propose a change" / card-launched tasks (creative task, turn ad off): assignee picker (e.g. Erin).
5. Drafts: designs Erin approved still come back to Charlotte to approve: find why.
6. Team-action "Also changes the InstallrHub app" lines on ClientCard (APP_EFFECTS_TO_WIRE team_add/remove/role).
NEXT SESSION:
6b. hub-action-alerts 2am back-up still makes one 'Tag the live ad' card per test (emails may still be per test): rename to the one 'Ads to tag' card, Hub-only paste-deploy.
6c. 6 designs already waiting on Charlotte (Save £9,000: 2, Solar inspo: 4) need approving once; the drafts bug (finals not auto-approved after drafts approved) is fixed in useTasks.js.
7. Warning/alert emails (hub-action-alerts etc.): polish to Email client quality; they don't go via Email builder or portal (maybe fine).
8. Jones and Baker site final tweaks (website-factory; ask her for the list).
9. Portal phase 2: Surveys to the D3 Surveys design (needs her OK), then other inner screens.
10. Hub phase 2 via the audit (row 17 Funnels onward), page insides onto ui/hub.jsx.
11. Rule book rollout (Elect, Gas Worx, Harvard, Core, L W Heating, SWH + drafts).
12. KPIs: she names wrong numbers. End of audit: Serafim batch (/leads codes, user_id), Client MOT in portal. Late Oct: PORTAL_INTRO_ON off. ~11-15: Photos/launch usage recheck.
13. Repo handoff not yet updated for portal D3 (#2023) + Hub D3 (c5160866) merges.

Related: [[project-portal-redesign-d3]]

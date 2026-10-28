---
name: project-meta-in-hub-test-list
description: "Meta-in-the-Hub buttons still to test live (Charlotte asked 10-24 to remember); tick off as each is tried, then check Meta + hub_meta_changes + History"
metadata:
  node_type: memory
  type: project
  originSessionId: 50c8121e-3273-41f0-a582-48d735931a72
  modified: 2026-10-28T10:00:05.739Z
---

Charlotte 2026-10-24: "remember the test list we need to do". Tested 10-24: ad off/on from the Performance ad pop-up (Ad4 AS03), and an approved "Turn ads back on" decision task (switched on + finished itself).

Still to test, when a real case comes up (each: read the object back from Meta, the `hub_meta_changes` row, the campaign History line):
1. Budget change from an approved "Change the budget" decision task (set_budget; check raw->>'daily_budget' and daily_budget_cents both updated).
2. Go Live on a marketplace client whose area ad set is off: "Switch ASxx on in Meta" (ad set + campaign).
3. Connect their area ad set step 6: "Switch the ad set and campaign on in Meta".
4. Used-up marketplace client: "Pause their ad set in Meta" on the client card (must NOT offer a shared code like AS01).
5. 2b spend-limit card: live 10-24, figures read hourly (verified 10-25 07:15). Gas Worx amber expected ~26/10 (£1,800 limit, ~£372 left); Elect ~15 days left.
6. 2c (merged 10-25): a pacing task's "Pause ASxx / Switch ASxx back on in Meta now" (finishes the task); retainer-takeover note's pause button.
7. 2d (merged 10-25): "Change in Meta" on a retainer campaign (Performance > Campaigns or client card): switch an ad set, change a budget; Live / Paused / Churned offers to switch a client's campaigns.
8. Safeguards (10-25): a change that doesn't stick shows Not done / Not confirmed + red Actions card; a change reversed in Meta = amber card.
FIXED 10-25 (merged): the meta_change cards' Open now goes to the ad / the campaign on the client card. Ad4 AS03 was switched off by Charlotte in Ads Manager 24/10 21:31 (after the Hub test); the amber card was right.
8b. Background second look (meta-change v4, deployed 10-25): a switch-on should say Done in ~3s, then "Looked again: it stayed on" ~20s later; one Meta bounces back off = Not done in the window + red card + History line. Before v4, Ad1 took 20s (11:09, stayed on, Meta "in process" = review).
9. Each new stage as it ships: Stage 3 Publish to Meta + Meta creative test + pick up tests made in Meta, Stage 4 locations, Stage 5 set-ups.

**The list now lives in the repo (10-25):** marketing-agent `.claude/docs/test-list.md` (its Meta in the Hub section; was meta-in-hub-test-list.md until 10-28); keep that one up to date in every Meta PR and show Charlotte the open items in each report.

**How to apply:** when Charlotte says she tried one, verify it in Meta and the Hub, tick it here; remind her of the open ones at the end of each Meta stage. Plan: marketing-agent `.claude/docs/plan-meta-in-hub.md`. Related: [[project_hub_publish_to_meta_button]].

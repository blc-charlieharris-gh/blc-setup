---
name: hub-batch-2026-09-24
description: "blc-79 session 09-24 shipped Ideas/Inspo, action emails, status crawl, Goals (#960-#977); next = sitemap over-count fix, Goals stage 2, hourly card scan"
metadata:
  node_type: memory
  type: project
  originSessionId: 074717eb-e574-4f49-9c99-c126f7aaa2b7
  modified: 2026-09-24T16:30:23.183Z
---

All merged and live on 2026-09-24 (marketing-agent #960 to #977), handoff on branch docs/handoff-2026-09-24-hub-batch (needs merging):
- Creative > Ideas (admin approval + feedback) and Inspo tabs.
- Re-chaser + onboarding email history on each Manage Clients card; onboarding cron crash (21-24 Sep) fixed, see [[api-imports-need-js-extension]].
- Status > Websites crawl of greentideenergy.com + installrhub.com (marketing-status-check v37, no own email).
- Actions > Email me: one alert system (hub-action-alerts edge fn, 5-min cron) to charlieharris@installrhub.com, incl. every red/amber board card recorded while the Hub is open.
- InstallrHub KPIs > Goals: stages with one target plus sub-stages (nurture/broadcast/ads campaign/organic/outbound/typed in), nurture-sequence stage, goal picker on broadcasts and nurture (#993). Targets have a unit (Number, %, £ typed-in only); a stage % is of the stage above OR a conversion rate of people who joined a sequence / were sent a broadcast (stage.of); stage target optional. All merged 09-24.

**Why:** Charlotte's task list for the day; she wants alerts in one system, Erin working ideas through her approval.

**How to apply:** sitemap fix, Goals stage 2 and the server card scan are all DONE. Parked by Charlotte: overnight gap for the 3 heavy ads cards, Mark-as-read auto-clear. Webinar goal stage 1 should be 'Joined nurture: Webinar-Oct2026' from 22 Sep (form log only started 23 Sep 15:54). Edge fns are pasted in the dashboard by Charlotte, see [[dashboard-edge-fn-paste-deploy]].

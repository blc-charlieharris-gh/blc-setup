---
name: project-installrhub-cost-per-appointment
description: "InstallrHub B2B \"booked\" = triage-calendar appointments credited to Meta ads (branch feat/installrhub-cost-per-appointment, 2026-09-18); sales_stage_events under-records bookings"
metadata: 
  node_type: memory
  type: project
  originSessionId: 11f3dd0f-faf4-4335-be72-e4305464e479
  modified: 2026-09-18T08:17:55.838Z
---

Built 2026-09-18, merged to main as PR #799, with follow-up #800 (Dashboard CampaignsTable via useCampaignTable, plus a synthetic "Paused / untracked campaigns" row in Performance because ad_windowed_totals leaves out untracked campaigns, so "View paused" can't show them). `src/lib/b2bAppointments.js` is the one definition, feeding the Performance rows, BlendedCards, and the DashboardKpis strip.

**Definition (Charlotte agreed):** an appointment is a `sales_appointments` row on the triage calendar, matched by ID (`yEw664fX6up5dLb7TL75`, "InstallrHub Discovery", confirmed as triage by Charlotte 2026-09-18). Cancelled bookings and no-shows are both COUNTED on the ad surfaces (Charlotte 2026-09-18: "the ad still caused a booking"). It is dated by `created_at` (the time it was booked), counted once per contact, and credited to the Meta ad found in `sales_lead_intake_events.raw."UTM Content"` (a title-case key holding the numeric ad ID). Outbound and organic bookings are not counted against spend. A separate demo calendar, `dcUoRKkUzUQV3rpy8IQw`, also exists. The triage calendar was renamed from Demo to Discovery on 2026-08-19, which is why the match is by ID and not by name.

**Gotchas:** `installer_prospects.channel` reads "outbound" for Meta leads once telesales books them, so it can't be used for attribution. `sales_stage_events` "booked" held only 21 of the 37 real calendar bookings from ads over the last 30 days, so it under-records. Figures at build time: £1,833 spend over 30 days, 37 appointments from ads, **£49.55 cost per appointment**. `clients.lead_only` stays true (leads still use Meta's count). See [[feedback_lead_only_blanks_cpbl]], [[project_installrhub_cpl_meta_sync_aggregation]].

**KPIs page (PR #804, 2026-09-18):** INSTALLRHUB > KPIs (`/ih-kpis`, `src/pages/InstallrHubKpis.jsx`, `summariseB2bFunnel` in the lib). It covers every source: ads (an ad ID or paid-social), organic (filled a form but no paid click), and outbound (never filled a form). Figures are leads, triage and demos, each booked and shown, costed against ad spend only. Shown counts only rep-logged `sales_meeting_outcomes` 'showed', and only about 1 in 5 past triage calls was logged at build time. Charlotte's split: Dashboard, Performance and Creative Testing judge the ads only, and the KPIs page holds totals across sources. Cost per close was deliberately left off ("not sure on that").

**State at handoff (2026-09-18):** PRs #799, #800 and #802-#806 are merged and confirmed in the live bundle. All session worktrees and branches are deleted, including the remote ones. The KPIs sources are now Ads, Organic, Outbound (links from the builder's Direct link card such as `linkedin-dm`, `utm_medium=outbound`, or a prospect with channel linkedin), Old leads list (`installer_prospects.source='unclosed leads'`), and No source. Duplicate GHL contacts are merged on a shared email or phone. Charlotte has not yet checked the numbers on screen.

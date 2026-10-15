---
name: project_ih_kpis_test_questions
description: "The 9 questions Charlotte will use (from 10-15) to judge whether the InstallrHub KPIs \"pick your view\" page serves its purpose, with setups and pass signs"
metadata:
  node_type: memory
  type: project
  originSessionId: 862a8d37-73ba-4964-9ede-bf32cd0b4fc6
  modified: 2026-10-15T16:35:57.378Z
---

On 2026-10-15 Charlotte asked for questions to test the new InstallrHub KPIs page (/ih-kpis, merged #1996) and wants to check them in a new session. When she comes back, ask which she has tried. For any surprising number, cross-check it against SQL (sales_appointments + first intake per contact + ads_campaigns lead_role) and explain the difference. See [[project_ih_kpis_journey_page]].

1. **"Are the Direct to Offer ads bringing in leads that book?"** Rows: Campaign or channel; Count: People who came in; 30d. Pass if she can say "X% book at £Y each" without maths.
2. **"Is cost per lead better or worse?"** Campaign or channel, By week. Pass if the weekly cost per lead shows a clear trend.
3. **"Was the webinar worth it?"** Rows: Sales lead or sign-up; People who came in; dates from about 22 Sept. Pass if Sign-ups vs Sales leads reaching demo and close is clear.
4. **"Are social posts and organic search bringing anyone in?"** Rows: Source; 90d. Pass if they're comparable with Ads.
5. **"How are the nurture emails doing?"** Source, the "Our email / SMS" row. KNOWN GAP: first touch only. 51 of 72 bookings for 8-14 Oct have no record of what prompted them. The next build would record the email or broadcast a lead last clicked before booking.
6. **"What did the team do last week?"** Count: What happened in the dates; 7d; Rows: Sales lead or sign-up. Pass if counts are at a glance and the names are right.
7. **"Where do we lose people?"** People who came in, 30 or 90d, the six-step strip. Pass if the biggest drop jumps out.
8. **"Are no-shows a problem?"** Triage show rate, then click to see who. Pass if she'd know who to chase.
9. **"Could my CEO read this unaided?"** Share link on question 1 or 7. If not, that defines the frozen CEO report (not built yet).

**Why:** Charlotte needs to trust the IH funnel numbers before sharing them with the CEO.

**How to apply:** start the check-in by asking which questions she has run and what felt wrong. Fix the page from her answers, then build the frozen CEO report.

Still open at the end of 10-15 (pick up next session):
- **The Feeds chips don't show for Charlotte** on the InstallrHub client card (Ads set-up > Campaigns in their Meta account), even after `notify pgrst, 'reload schema'` and a refresh. Everything else checks out:
  - Postgres logs show 200s on selects including feeds_campaign_ids since 15:43.
  - Main has the full wiring: useTrackingSettings setCampaignFeeds > ClientCardDrawer > ClientCard > AdsSetup > CampaignSettings onSetFeeds.
  - A test render of CampaignSettings with IH's real rows shows 2x "Feeds:".
  - IH rows: DTO 7883d5f3 main ACTIVE; TOF cdfb02d7 supporting ACTIVE; Retargeting Copy 870d903a supporting ACTIVE; all feeds null.
- **Next step:** get her screenshot of the TOF row (tracked? Awareness? what's under it?). Then add a "Fed by:" picker on the Leads campaign row (DTO), which is how she thinks about it. Same column, edited from the other side.
- **CEO** = Brad Clark (bradclark@blc-promotions.com). He's an ultra_admin with installrhub ticked, so the /kpis share link works for him. A frozen no-login report isn't needed for him.

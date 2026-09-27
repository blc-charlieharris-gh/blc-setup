---
name: feedback-design-performance-data-durability
description: "Design Performance's numbers vanish for untracked clients/campaigns (ad_windowed_totals is_tracked-filtered); Ended Tests survives via campaign_creative_cpl instead. Eco4 campaigns are deliberately excluded from campaignTech."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c8ed8129-d200-41a1-b91c-cfea43b2604b
  modified: 2026-09-14T12:52:23.752Z
---

Two non-obvious facts about `marketing-agent`'s Creative Testing area, found 2026-09-14 while
answering "do we lose the merged creative data when things get toggled off" and "should we show
Eco4 as its own filter" (see [[project_creative_testing_identity_leadbasis]],
[[feedback_creative_testing_model]]).

**Design Performance is not a durable record.** `useDesignPerfCreatives.js` reads
`ad_windowed_totals`, whose live definition filters `where v.client_id in (select id from clients
where is_tracked) and v.campaign_id in (select id from ads_campaigns where is_tracked)` (confirmed
by reading the deployed SQL function, not inferred). Untrack a client or campaign and its spend
disappears from EVERY Design Performance window at once, including "Lifetime" — not archived, not
dimmed, just gone from what the page can show. The `creative_merges` relationships themselves
aren't touched, only the aggregated numbers Design Performance can display for that merged group.

**Ended Tests uses a different RPC that doesn't have this filter.** `useCreativeTestData.js`'s
per-test/per-window figures (and the "thin read" + lifetime-CPL line added to `TestRow.jsx`
2026-09-14) read `campaign_creative_cpl`, which filters only on `client_id` + date range, no
`is_tracked` check. So Ended Tests keeps showing correct numbers for a test even after its
campaign/client is later untracked — it's the more durable of the two surfaces.

**Why:** the two RPCs look interchangeable (both return spend/leads/CPL per ad) but have
different scope guarantees. Known-issues.md logs the Design Performance gap as open, unfixed.

**How to apply:** never tell someone "check Design Performance" for a churned/untracked client's
historical creative performance — point them at Ended Tests instead, or query
`ads_insights_daily`/`campaign_creative_cpl` directly. If asked to "fix" Design Performance's
lifetime gap, the fix is removing/relaxing the `is_tracked` filter in `ad_windowed_totals` (a
Tier-2 migration, shared DB, needs review) — not a frontend change.

**Eco4 is deliberately NOT in `campaignTech`/`CREATIVE_TECHS`.** ECO4-scheme campaigns (real
names like "National Eco | Off_Gas_Eco4...") never match the `/solar|pv|battery/` or
`/heat ?pump|ashp/` keyword rules, so they classify `tech: null` and showed as "Tech —" on Design
Performance. Fixed via a NEW, Design-Performance-scoped function `designPerfBucket`
(`lib/creativeTesting.js`), which checks campaign names for `/eco ?4/i` first. Deliberately did
NOT add Eco4 to `campaignTech` itself, because that function also decides which campaigns a
creative is ELIGIBLE to test on (`eligibleCampaignsForTech`) elsewhere in the app — and no
creative can be uploaded with `tech: 'Eco4'` (not in `CREATIVE_TECHS`), so reclassifying those
campaigns there would strand them with nothing able to test on them. If Eco4 ever needs to become
a real upload-time tag (not just a Design Performance filter), that also means updating
`BacklogTab.jsx`'s hardcoded 6-quadrant grid (currently Solar/ASHP/InstallrHub × untested/tested).

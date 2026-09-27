---
name: project_adset_client_attribution_override
description: "Running a client's ads inside Green Tide's account: ads_client_attribution_links with transfers=surveys|all, resolved in ad_windowed_totals (LIVE 2026-08-10)"
metadata: 
  node_type: memory
  type: project
  originSessionId: f0dddaa7-d145-49d2-a755-e210eb20d4f8
  modified: 2026-08-10T15:30:04.612Z
---

We run ads for retainer clients inside our OWN Green Tide ad account. Two arrangements, and they need different attribution:

- **top-up** (`transfers='surveys'`, the typical case, e.g. Arktek): the client has their own campaign and their own spend; we spend Green Tide budget to make up a SURVEY shortfall. The spend and the leads are OURS. Only the surveys move, because a survey-only retainer buys surveys, not leads.
- **funded** (`transfers='all'`, e.g. Mark Harvard Renewables): no campaign of their own. Green Tide pays but the whole thing is theirs, so spend, leads and surveys all move and their cost per lead is a real one.

**THE SPLIT IS INTERNAL.** The client's report shows one merged survey count with no hint that some came from another campaign. Charlotte, 2026-08-10: "arktek shouldnt be aware, to them, it's all their surveys from their campaign... their lead to survey rate will look good for them, and thas right. thas the point."

**LIVE in prod 2026-08-10** (migrations `20260810160000_client_attribution_links_split.sql` + `20260810180000_attribution_given_counters.sql`, PRs #553/#554), verified: Arktek week to 08-09 = £926.20, 26 leads, £35.62 CPL, 5 surveys (2 delivered). Green Tide = £1,365.72, 70 leads, 31 surveys (2 given away).

- `ads_client_attribution_links` (campaign_id OR adset_id -> client_id + transfers). Adset link beats campaign link. UI: **Clients > Ad attribution** panel on /clients.
- Each ad-day row carries THREE attributions (spend / lead / survey client); every metric is FILTERed by the one that governs it, in `ad_windowed_totals`. `leads_delivered`/`bookings_delivered` = counted for me, paid by someone else; `leads_given`/`bookings_given` = the mirror, shown in the panel as "N surveys moved (28d)" so a moved survey doesn't silently vanish from Green Tide.
- A moved survey LEAVES the owner (no double count), so all-client totals reconcile. Green Tide's booking rate takes the hit for work it did; that was a deliberate call.

**Gotchas:**
- `ad_windowed_totals` maps SELECT to RETURNS TABLE **by POSITION**, now 26 columns. Reordering a column silently mislabels metrics. Verify programmatically after any edit.
- NEVER resolve this in meta-sync: it walks account -> campaign -> adset -> ad re-reading each level filtered by the ACCOUNT OWNER's client_id, so re-stamping ads_ads drops those ads out of the owner's sync and FREEZES their spend.
- A `clients` join that resolves through `i.client_id` must sit BELOW the ads_insights_daily join (42P01 otherwise).
- The owner-visibility OR in the row filter is load-bearing: without it a 'funded' link moved all three attributions and the row vanished from the owner's query entirely, making our own funded campaign invisible to us.
- In funded mode the spend leaves Green Tide's reported totals, so GT's spend understates what actually left the Meta account. The attribution panel is where that reconciles.
- NOT moved: `useTargetingData`/`useTargetingIntelligence` read `ads_adsets` directly, so targeting still shows under the owning account.

**Applied WITHOUT Serafim's review**, on Charlotte's explicit call. Tier-2 was raised and overridden, not skipped. Flag it to him. See [[feedback_serafim_signoff_and_handoffs]], [[project_client_weekly_reports]], [[feedback_report_prose_no_adspend]].

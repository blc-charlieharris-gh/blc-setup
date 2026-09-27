---
name: reference_greentide_utm_attribution
description: "How to attribute Green Tide leads to Meta campaigns/adsets via UTMs in Supabase when Meta's custom conversion is broken"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 0970f2d8-cad7-47eb-bcd6-f5e88485184b
---

When Meta's custom conversion stops firing (e.g. thank-you page changed), attribute Green Tide leads via UTMs stored in Supabase `lead_intake_events`.

Key gotchas:
- Leads come from GHL; the `leads` table itself stores NO utm fields. Attribution lives in `lead_intake_events`.
- **`utmCampaign` IS OVERLOADED — two different id types in one field (verified 2026-07-13):**
  - **Landing-page leads** (Fillout on greentideenergy.com): it holds the Meta **ADSET id** → joins `ads_adsets.external_id`.
  - **Instant-form leads** (Meta native lead forms, incl. the Backup-account PPL campaigns): it holds the Meta **CAMPAIGN id** → joins `ads_campaigns.external_id`.
  - A few instant-form rows hold a plain **text label** instead ("Solar Fillout Form", "Solar Instant Form"), which joins nothing.
  - So ANY attribution query must try BOTH joins (`left join ads_adsets` AND `left join ads_campaigns`). Joining adsets only silently drops every instant-form lead: **376 of 865 GT leads (43%) in the 30d to 2026-07-13**.
- To attribute to a campaign: join `raw->>'utmCampaign'` to `ads_adsets.external_id`, then `ads_adsets.campaign_id` to `ads_campaigns.id` (match `ads_campaigns.name`) — and fall back to a direct `ads_campaigns.external_id` match when the adset join misses.
- **Solar is NOT missing UTMs** (the long-held suspicion is wrong): 473/473 solar leads in 30d carried a tracking param, 94.5% with fbclid. Solar merely *looks* untracked because it leans hardest on instant forms (206/473 = 44%), which are exactly the ones the adset-only join drops. **Heat pump is the one with a real gap**: 67/392 (17%) carry no utm at all, though 48 of those are recoverable by matching `meta_lead_events` on phone/email (it stores ad_id/adset_id/campaign_id). Only ~19 in 30d are truly unattributable.
- `ads_adsets.id`/`ads_campaigns.id` are internal **uuids**; the Meta id is `external_id`. Never join a utm to `.id`.
- `raw->>'utmContent'` holds the Meta ad id.
- contact_source: "Greentide Fillout" = landing-page website form; "Greentide Instant Form" / "Greentide Solar Instant Form" = Meta native lead forms (not landing page).
- Filter `lead_source='greentide'`, use `occurred_at` for dates, `count(DISTINCT ghl_contact_id)` for unique people.
- intake events != leads: only a fraction of intake form fills become rows in the `leads` table (qualification drop-off). Report both inbound (intake) and converted (leads) and match `leads.additional_info->>'ghlContactId'` = `lead_intake_events.ghl_contact_id`.

Confirmed via Fillout export (form "Fillout Green Tide V3 (9k grant)", form id cVaNxEPM6uus): the form's own `utm_campaign` column = Meta ADSET id, `utm_content` = ad id, `utm_medium` = placement. Landing-page adsets seen: 120247763115220201 (Interest targeting) and 120248220708170201 (Broad + Long Primary Copy), both under campaign "2026 Heat Pumps – Landing page" (id 120239520456480201). The campaign id itself is NEVER in the UTM.

Cost-per-booked-lead (CPBL) per creative (2026-07-06): `lead_intake_events.utm_content` is a TOP-LEVEL column holding the Meta **ad id** (not just `raw->>'utmContent'`); 97% of GT intake rows (924/948 in 30d) match `ads_ads.external_id`, so ad/creative-level attribution is reliable. Spend per ad = `ads_insights_daily.spend_cents/100` filtered by `client_id` (GT main = `08e7d2b5-cece-45af-b23a-1bc95e462079`). Booked = a `leads` row with `booking_type is not null and booked_at is not null`; join intake->leads by `leads.additional_info->>'ghlContactId' = lead_intake_events.ghl_contact_id` (cleaner than phone). CPBL = spend / booked. Caveat: bookings lag lead creation by days, so the newest ~5 days under-count booked. Key finding: ASHP books better than Solar (20% vs 16%, £120 vs £133 CPBL); best creatives were the £9k-grant ASHP video and the oil/LPG ASHP static (33% book, £63 CPBL).

Funnel leak (18-21 Jun 2026): 29 finished Fillout submissions (real landing-page leads) -> only 27 reached lead_intake_events -> only 9 became rows in the leads table. Meta showed 0 (custom conversion broke when thank-you page changed). ~3/day reach the leads table regardless of daily volume, suggesting heavy drop-off between intake and marketplace (cause TBD: qualification filter vs genuine loss). 2 never reached Supabase at all (webhook drop). See [[project_greentide]] [[feedback_meta_lead_counting]].

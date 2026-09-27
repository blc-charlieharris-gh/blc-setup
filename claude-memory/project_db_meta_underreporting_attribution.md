---
name: project_db_meta_underreporting_attribution
description: "The \"DB under Meta\" under-reporting is an attribution artifact, not lost leads; total DB intake exceeds Meta conversions"
metadata: 
  node_type: memory
  type: project
  originSessionId: 974ae2cb-f0c9-4dc6-88e0-ce74375e8195
---

Investigated 2026-06-25 (Charlotte asked "where are the missing leads"). Conclusion: **no leads are lost**. Over 30d (2026-05-25..06-23) tracked clients: total `lead_intake_events` = 980 vs Meta conversions = 962. The DB holds MORE than Meta counted; the N8N/Zapier pipeline is fine.

The reconcile "DB under Meta" is an ATTRIBUTION gap. `ad_performance_with_leads.leads_by_ad_day` attributes a lead only when `utm_content ~ '^[0-9]{15,20}$'` (the Meta ad id). 960/980 leads have a valid ad id and map cleanly to a synced ad (zero junk, zero orphans). The 20 that don't:
- 16 Greentide Fillout web-form leads with NO ad tracking at all (raw->>'utmCampaign' empty, utm_content null) — organic/direct visits or a dropped UTM on the site→Fillout hop.
- 4 "Solar Instant Form" leads (Meta lead form) that carried the form NAME in raw->>'utmCampaign' instead of an ad/adset id (lead-form leads bypass the website UTM forwarding).
All 20 have a ghl_contact_id (fully captured). Note: the [[reference_greentide_utm_attribution]] adset-id path does NOT recover these (their utmCampaign is empty / a label, not a synced adset external_id).

KEY IMPLICATION — the two checks measure different things:
- **Status lead-pipeline card** (`Status.jsx`): total `count(lead_intake_events)` vs Meta conversions. CORRECT detector for real pipeline loss. Trust this one.
- **Performance ReconcileBar** (`reconcile_leads` RPC → `bridge_leads = sum(leads_generated)`): ATTRIBUTED leads vs Meta. Structurally ~2% low because unattributed-but-present leads don't count, so it shows a permanent small "DB under Meta" even when nothing is lost. Can cry wolf. See [[feedback_reconcile_direction_asymmetric]].

So: a genuine "leads lost" alarm = total DB intake < Meta beyond tolerance. Per-ad attribution gap = separate lower-priority "attribution quality" signal. Greentide Backup showed the largest per-client gap (20/148, 13.5%) purely from this attribution effect, not loss.

---
name: reference_greentide_lead_to_installer_chain
description: "How a Green Tide-account marketplace lead reaches an installer (10-06): Meta form -> GT GHL -> lead_intake_events.utm_content ad id -> lead_source_adset -> AS code -> direct_booking_adset_links; Sync of bookings every 30 min"
metadata:
  type: reference
---

Checked live 2026-10-06 for Kcglinks/AS01:
- Meta form in Green Tide's account -> Green Tide's GHL (how GHL collects the form is not visible from the DB; a NEW form must be connected there, prove with a Lead Ads Testing Tool lead) -> lead_intake_events (lead_source 'greentide', utm_content = Meta ad id on ~93%).
- App: `lead_source_adset(lead)` finds the ad via utm_content -> ads_ads -> ad set name -> `adset_codes()` -> `direct_booking_adset_links` -> installer. Needs meta-sync to have the ads in ads_ads.
- Hub reporting: a marketplace client has no `clients` row, so area ad set spend counts as Green Tide's unless excluded (only pay-per-lead excluded today). `direct_booking_adset_report()` (app) splits spend per installer by placed surveys.
- B2B bookings: `sync-sales-appointments` copies GHL calendars to sales_appointments every 30 min (:00/:30); Lead Intake > InstallrHub > Bookings reads it. Site bookings: `blc-vercel logs ... --query "/api/book"` (flaky; returns empty sometimes).
Related: [[reference_marketplace_lead_routing_chain]], [[project_adset_client_attribution_override]].

---
name: reference-ih-cost-per-discovery-demo
description: "How to work out InstallrHub cost per discovery / demo by campaign in SQL (calendars, CRM, ad credit, spend), and the webinar report's people rule"
metadata:
  node_type: memory
  type: reference
  originSessionId: 08bfaab8-58be-44ab-acfb-c729b2d342ed
  modified: 2026-11-06T17:08:12.952Z
---

InstallrHub cost per call (6 Nov 2026), read only via f958 `execute_sql` (project ozmyjrzleejbqxqphbut):
- **Bookings:** GHL `sales_appointments` calendar `yEw664fX6up5dLb7TL75` = Discovery, `dcUoRKkUzUQV3rpy8IQw` = Demo, dated by `created_at`; plus `hub_crm_bookings` (kind discovery/demo, `booked_at`) from 2 Nov. All bookings since 4 Nov are CRM only. One per person per window, cancelled included (Hub rule).
- **Credit:** the person's latest `sales_lead_intake_events` row at or before the booking, ad = `hub_ih_signup_ad(raw, contact_email, occurred_at)`, campaign from `ad_performance_with_leads` (ad_external_id -> campaign_name). CRM rows often have no email or contact: those can't be credited, say so.
- **Spend:** `ad_performance_with_leads.spend` by campaign_name, client 6252dfdc-ba42-4f3a-b84d-558d4affc670, period ending yesterday.
- TOF and MOF Retargeting never get direct credit; bookings land on DTO ads.

Webinar results: Events > Report (`src/lib/eventReport.js`) counts calls from the event's `starts_at` by people who signed up (form `installrhub-webinar-oct6` from the previous webinar's end), carry the `webinar-nov26-*` attendance tags, or (from #3298) filled the booking page with utm_source=event + the slug. Compare with that, not whole-day counts. Every CRM booking is `booked_by='staff'`, so "how booked" shows all Telesales.

Related: [[feedback_installrhub_signup_vs_lead_rule]], [[reference_lead_counting_model]]

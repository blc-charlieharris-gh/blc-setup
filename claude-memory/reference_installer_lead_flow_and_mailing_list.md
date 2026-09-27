---
name: installer-lead-flow-and-mailing-list
description: "How installer (B2B) leads reach GHL and the Hub DB, where the mailing list really lives, and the gaps found 09-22 while scoping a broadcast/newsletter tool"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 9cacf443-1b51-4771-bf69-9f65af684541
  modified: 2026-09-22T07:48:36.031Z
---

Mapped 2026-09-22 while scoping a Hub "blast-out" (broadcast email + SMS) area.

- Site forms (installrhub.com) POST to api/contact.js or api/lead.js, which forward to **n8n** (route from landing_form_routes). n8n creates the GHL contact. The site repo has no GHL key, sets no tags. Demo bookings go straight into a GHL booking iframe.
- GHL **installr** sub-account (location hnkWBrlwiI4ZPlquJYDl, env GHL_INSTALLR_API_KEY) is the real installer mailing list. GHL workflow webhooks it to ghl-installr-lead-webhook, which writes sales_lead_intake_events (only ~139 rows) and auto-creates installer_prospects (367).
- Clients = companies (148). ghl_contact_id_installr is set on 120. products[] holds ASHP/Solar.
- "Installs Per Month" and "Main Service" exist only as GHL custom fields (buckets 0-4 / 5-9 / 10+). Values are messy, and clients mostly don't have them.
- GHL edge fns (ghl-config.ts, ghl-sms.ts, nurture-run) are deployed from the GT/InstallrHub repo, not marketing-agent. There are no GHL keys in any local .env.
- Existing reusable parts: nurture engine (claim-before-send, 08:00-20:00 window, drip cap), email_suppressions, api/nurture-unsubscribe.js, nurture-resend-webhook (matches nurture_sends only). Nothing calls GHL POST /contacts/search yet.
- Gaps: api/lead.js labels website-offer leads as forecast (won't fix: the website-offer page is no longer used, Charlotte 09-22). No marketing opt-in is captured on any form. Unsubscribe does not sync back to GHL DND. The Meta instant-form to GHL path isn't in either local repo (likely n8n).

Related: [[project_nurture_engine]] [[feedback_ghl_send_credential_pattern]]

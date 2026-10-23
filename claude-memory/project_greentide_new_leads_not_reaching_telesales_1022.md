---
name: project-greentide-new-leads-not-reaching-telesales-1022
description: "GT leads to telesales: 10-20 to 10-22 no row (n8n copy gone); 10-22 #2354 wrote rows with GT's GHL id, dialer 403'd; 10-23 lead-ingest v41 makes the call-centre copy itself"
metadata:
  node_type: memory
  type: project
  originSessionId: e2e131f3-b9b3-4dc8-b2a1-45a7fd7fc5ed
  modified: 2026-10-23T11:33:51.589Z
---

Telesales = `dialer_contacts`, fed by trigger `lead_intake_feeds_dialer_trg` on every `lead_intake_events` insert. The app's dialer opens every contact with the **call-centre GHL key**, so the row's ghl_contact_id must be a call-centre contact.

History:
- Before 10-20: GT GHL workflow > webhook to n8n > n8n copied the contact into the call-centre account > its ghl-new-lead-webhook wrote the row (call-centre id).
- 10-20 to 10-22: n8n paused, so no new GT lead got a row (not in telesales).
- 10-22 #2354 (lead-ingest v40): GT intake 'always', but the row carried **Green Tide's own GHL id** > app showed "GHL GET /contacts/<id> returned 403" on every new GT lead (16 stuck 22 Oct 17:00 to 23 Oct 12:00 UK).
- 10-23 lead-ingest v41 (branch fix/greentide-dialer-copy-1023): `GHL_ACCOUNTS.greentide.callCentreCopy` = lead-ingest upserts GT's account AND a call-centre copy (tag, n8n-style note); the row takes the copy's id. Cleanup: Re-send each stuck Meta lead, then `_deploy/greentide_stuck_leads_cleanup_1023.sql`. Website leads have no Re-send.

**How to apply:** any change to which GHL account a lead lands in must keep the intake row's id readable by the dialer's key. Test with a Send test lead on a GT form and check the app opens it, not just that a row exists. GHL removal next week should drop this copy once the dialer keys on our own id. See [[project_greentide_lead_pipeline]], [[project_ghl_removal_hub]].

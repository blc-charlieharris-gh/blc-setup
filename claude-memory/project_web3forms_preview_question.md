---
name: project-web3forms-preview-question
description: "Unified Web3Forms handover: clients register their own account and paste the key into a standard preview-page question that blocks sign-off (branch feat/web3forms-preview-question, 2026-09-21)"
metadata:
  type: project
---

Charlotte's unified process (2026-09-21): every client site ships on BLC's Web3Forms key; the CLIENT registers their own Web3Forms account (Web3Forms emails the key to the address they register) and sends us the key before they can approve. Replaces ad-hoc handling (Arktek was switched by staff; the Transfer page only told clients their login).

Built as a standard info_requests entry with `kind: 'web3forms_key'` (`src/lib/web3formsRequest.js`), so the existing "approval blocked until every question is answered" gate applies. Frontend only, no migration/edge-fn change (site-feedback's reply spreads the entry, so `kind` survives). Auto-added in `runSiteAudit` (push-to-preview) unless `webform_transferred` or already present; "Add standard question" button in InfoRequestsPanel for sites already in preview. Preview page: short to-do + "Show me how" pop-up + email + key fields (key validated as UUID). Reply stored as "Web3Forms email: X\nAccess key: Y"; staff panel shows key with copy button.

**Why:** one process for every client instead of per-client improvisation, and the client owns the account.
**How to apply:** after the key arrives, staff still swap it into the site, send a test enquiry, set notification_email to the registered address, and tick the Web3Forms handover box. Status: MERGED as #859 (2026-09-21). Existing preview clients (e.g. Gas Worx, [[project_gasworx_website]]) still need the "Add standard question" button pressed.

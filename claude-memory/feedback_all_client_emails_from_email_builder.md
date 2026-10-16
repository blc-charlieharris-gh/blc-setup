---
name: feedback_all_client_emails_from_email_builder
description: "Every email to a client goes through the Hub's Email client builder; no separate one-off client emails"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 69a9ec87-cc18-4cd6-af26-1ee194941677
  modified: 2026-10-16T13:41:08.432Z
---

All client emails come from the Email client builder (Charlotte 2026-10-16). A warning or notice to a client (payment issue, previews, deliveries, etc.) is a section/option inside Email client, opened pre-ticked from wherever it is triggered, not its own template and pop-up.

**Why:** the separate payment-issue email looked and worked differently (own layout, no edit, no recipient choice, signed "Brad"); one builder means one look, edit, preview, recipients and History log.

**How to apply:** before building or fixing any client email, route it through Email client (src/lib/clientEmailBuilder.js + ClientEmailBuilder.jsx). Old standalone kinds in api/transactional-email.js are migration candidates; list them in the audit plan. Related: [[feedback_audit_scope_checklist]]

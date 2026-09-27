---
name: project_lw_heating_manual_onboarding
description: "LW Heating (website-only client) onboarded live via a manual SQL patch, not the app.installrhub close flow; template for doing this again"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9c6e7f66-dfcd-4521-867d-936b0a4d3bfd
  modified: 2026-08-19T12:38:49.163Z
---

LW Heating, a website-only client, is live in the hub as of 2026-08-19 via a one-off manual DB
patch rather than the normal app.installrhub close flow. For `company_id`
`a28b9d90-3a8c-48c4-b1e7-555fbb5bf46c`: a `client_onboarding` row was created directly by SQL,
`companies.status` flipped to `active`, the checklist has `form_submitted` and `call_completed`
both ticked, phone-call notes are on the client card, and `onboarding_emails` has pre-seeded
"sent" rows for welcome/complete so the automatic mailer never emails them.

**Why:** the client onboarded verbally/by phone; there is no admin-fill path for the real
onboarding wizard and no per-client suppress flag on the automatic emails, so filling in the real
form or nudging it through the app would have emailed the client. See
[[feedback_onboarding_wizard_no_admin_fill]] for the underlying gap and other ways this trap can
be triggered; this row is the concrete precedent for the DB-direct workaround it describes.

**How to apply:** `client_onboarding.company_id` is UNIQUE. If/when someone processes LW
Heating's real close in app.installrhub, an insert attempt for a second `client_onboarding` row
against this same `company_id` will fail. Check for an existing row before running a real close
for this client. This SQL pattern (row + status flip + checklist ticks + pre-seeded
`onboarding_emails` "sent" rows) is the template for onboarding any other client this way until
an admin-fill path or suppress flag exists. See [[project_client_onboarding_engine]].

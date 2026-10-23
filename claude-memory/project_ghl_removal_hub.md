---
name: project_ghl_removal_hub
description: Hub is removing GHL completely (10-21), phases InstallrHub then Green Tide then clients; plan in marketing-agent hub-audit README "GHL removal"
metadata:
  type: project
---

10-21 Charlotte: "we are tasked with removing GHL for the hub completely. Starting with InstallrHub, then Green Tide
and clients." (Earlier the same day she'd said "just preparing"; this replaced it.) Plan by phase:
marketing-agent `.claude/docs/hub-audit/README.md` section "GHL removal"; touchpoint map
`.claude/docs/ghl-touchpoints-2026-10-21.md`; shareable page https://claude.ai/artifact/WGXDv6bNK1sAubUmLKb6rJ
(already passed to Serafim). Marketing texts Twilio-only (#2267). WhatsApp is Serafim's, not the Hub's.

**Why:** she corrected me twice that day: don't block live features early (Sales kit must keep working, its GHL notes
are deliberate until phase 1 moves them), and WhatsApp isn't Hub scope.
**How to apply:** work phase by phase; within a phase, keep features working until their replacement exists; app-side
pieces (person id, contacts home, calendar engine, homeowner texts switch, dialer) are Serafim's. Related:
[[project_leaving_ghl_calendar_emails]].

**Added 23 Oct (from the Green Tide lead break, see [[project_greentide_new_leads_not_reaching_telesales_1022]]):**
1. lead-ingest writes our lead record BEFORE the GHL upsert, so a GHL outage can't stop telesales.
2. The dialer keys on our lead id, not ghl_contact_id (dialer_feed_from_intake skips rows with no GHL id): Serafim.
3. InstallrHub installer forms go through lead-ingest straight to sales_lead_intake_events (today via InstallrHub GHL's webhook).
4. Delete the GT GHL workflow's webhook step to n8n.
5. After each phase, re-run the strict Send test lead on every live form (it fails anything that arrives via GHL/n8n).

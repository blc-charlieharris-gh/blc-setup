---
name: project-greentide-new-leads-not-reaching-telesales-1022
description: "22 Oct 2026: no real NEW Green Tide Meta lead has reached telesales since the 10-20 lead-ingest switch; only test leads did; cause is GHL side, unconfirmed"
metadata:
  node_type: memory
  type: project
  originSessionId: e2e131f3-b9b3-4dc8-b2a1-45a7fd7fc5ed
  modified: 2026-10-22T21:35:15.790Z
---

Found 22 Oct 2026 (Charlotte asked why AS04 showed Meta 2 / Leads 0 on the Dashboard Today panel).

- Telesales = `dialer_contacts`, fed by trigger `lead_intake_feeds_dialer_trg` on every `lead_intake_events` insert. No intake row = not in telesales.
- Green Tide route (ghl_account greentide): lead-ingest upserts into Green Tide's GHL and, for a NEW contact, leaves the intake row to GHL (copy into the call-centre account, whose `ghl-new-lead-webhook` writes it). For a repeat contact lead-ingest writes the row itself.
- Since the 10-20 switch every webhook-written GT row was a "Test Lead (In-app)" (drama-range 07700900xxx phones). GT ads were off 19-21 Oct (credit line). On 22 Oct every real new GT instant lead (Andy Wiltshire 16:58, Robert Mainstone 17:52, Ann Griffin 20:30, Lee Mottershead 21:07, Stephen Cooksey 21:47 UK) got no webhook and no intake row. Rows that did land were lead-ingest writes (repeat contact, or the website form). Our code didn't change for GT between the tests and then.
- Workaround: Lead intake > Re-send writes the row (contact now exists, so lead-ingest writes it) and the person reaches telesales, with the ad attached.
- intake-catchup notices within minutes but only logs to error_log (wording still blames n8n). Lead intake "Stuck" only flags failed/pending forwards, and Status > Lead flow only counts complete days. Alert build started 22 Oct (branch feat/not-in-telesales-alert-1022).

**Root cause confirmed 22 Oct:** Green Tide's GHL workflow action is a Webhook to n8n (`n8n-blc-u52678.vm.elestio.app/webhook/9bff6bf4-4d76-499a-a742-24aaf4e97862`). That n8n flow did the copy into the call-centre account, and it was paused with the other n8n flows on 10-20. So the "GHL copies" rule in reference_lead_routing_ghl_accounts (repo) is really n8n. Never delete that flow until lead-ingest upserts new GT contacts into the call-centre account itself (asked Charlotte for the flow export).

**How to apply:** a test lead proves nothing here, because drama-range phones are always new. Test the GT chain with a real new phone. Check GHL (GT workflow + call-centre webhook workflow) for the root cause. See [[project_greentide_lead_pipeline]], [[project_n8n_replacement_session_1020]].

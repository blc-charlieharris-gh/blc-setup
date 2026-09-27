---
name: project_telesales_caller_id_switch
description: Telesales caller ID switched 2026-09-21 to +447307212762 (bought in-app by Brad, default); GHL 07446919125 unused, to be released
metadata: 
  node_type: memory
  type: project
  originSessionId: 2b18702f-b81d-4b79-b71e-381d1fe2d116
  modified: 2026-09-21T13:39:53.558Z
---

On 2026-09-21 the telesales number was changed to 07446919125 (+447446919125), but only in GHL. The app.installrhub.com dialer uses our own Twilio account, so the GHL change did not carry over.

How the dialer picks its caller ID (agent-call-start): the agent's own agent_numbers row, then the system's is_default row, then the AGENT_CALLER_NUMBER secret (leads only). No leads default was set, so the secret was in use: +447447180243 (846 calls in the 7 days to 09-21). +447576597601 ("Telesales — new outbound caller ID") exists but was never made default.

Serafim was unsure how to add it. Agreed proper plan (09-21): port 07446919125 from GHL into our Twilio (check the app's Settings dialer-numbers list first, it reads Twilio live), then Fix wiring + Set as default in the app. Rejected as not proper: verified caller ID + editing the AGENT_CALLER_NUMBER secret (callbacks would land in GHL). Warn: porting removes it from GHL, so GHL texts from it stop. DONE 09-21 ~14:00 UTC: Brad bought +447307212762 in-app (leads, is_default=true, no label yet); outbound calls confirmed on it from 13:59. +447576597601 stays unused spare. Earlier plan: 07446919125 was never used, so release it in GHL and buy a new telesales number in the app instead (Settings dialer numbers: buy with system=leads, then Set as default). No porting. When it's live: it needs an agent_numbers row (provision-agent-number repoint, so inbound calls and SMS are wired to agent-call-inbound / twilio-sms-inbound), then set_default for system 'leads'. To check: `select from_number, count(*) from agent_calls where created_at > now() - interval '1 day' group by 1`.

**Why:** Charlotte assumed the GHL change would apply to the app dialer. It doesn't.
**How to apply:** if anyone asks whether the new number is live, check agent_numbers and recent agent_calls.from_number, don't take it on trust. See [[reference_telesales_dialer_diagnostics]].

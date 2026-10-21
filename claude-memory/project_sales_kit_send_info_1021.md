---
name: project-sales-kit-send-info-1021
description: Sales kit rebuilt 10-21 as "send info" (replaces the Packs builder): Set ups, Send info, sales-kit-send edge fn, from Brad, Twilio texts, GHL note
metadata:
  type: project
---
Charlotte 2026-10-21: Sales kit is now just "send info" ("we were overcomplicating it with the builder"). Telesales (event_invites tick) search a GHL contact, pick Heat pump / Solar / Both, Make their page, Send email / Send text. Only the contact changes for telesales; sales (installrhub tick) can add a line and re-steer the GPT explainer. Admins set the three options in Set ups (GPT "what we do" words from Crew guide + Sales Model packages, no prices; work per trade; email + text wording).

- Every email from "Brad at InstallrHub" <brad@mail.installrhub.com>, reply-to brad@installrhub.com, signed "Brad and the InstallrHub team". Texts from our Twilio number only (_shared/marketingSms.js), never GHL.
- Edge fn sales-kit-send (Hub, verify_jwt off): check / send / opened. GHL note on send + open and field contact.sales_kit_page, agreed with the GHL session; moving them = GHL removal phase 1. Own log: sales_pack_sends, sales_pack_opens.
- Page rules: lib/salesKit curatePack (one campaign result per client, only the trade, up to 3; whole rows). Hub links use ?preview=1 so they don't count as opens.
- State at 10-21 handoff: live; Set ups not yet saved; first real send to her test contact Sam Taylor not done yet.

**Why:** telesales need something to send after a call to get discovery calls booked. **How to apply:** don't bring back a per-piece builder; one send path with the event sender is an end-of-audit follow-up. Related: [[project-installrhub-section-audit-1021]], [[project_sales_kit]].

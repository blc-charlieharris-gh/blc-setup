---
name: project-not-paid-flag-heatrite-heatwise
description: "Heatrite + Heat Wise marked Not paid yet by SQL on 2026-10-01; flag will NOT clear itself on payment, clear by SQL when Charlotte says they paid"
metadata:
  node_type: memory
  type: project
  originSessionId: bbe32563-1bcd-45b9-9c89-9d764f3bb3eb
  modified: 2026-10-01T07:39:47.065Z
---

On 2026-10-01 Charlotte said Heatrite ltd and Heat Wise were still awaiting payment, but both had been marked Close won in the app early (Heat Wise 23 Sep, Heatrite 30 Sep), so the Hub treated them as paid. SQL `~/Code/BLC/_deploy/client_status_1oct.sql` (run by Charlotte) set `companies.pre_close_prospect_id` so the Hub shows "Not paid yet" and blocks going live. My Energy Care's new record (company 8bc4a39d...) already had the flag the normal way (its prospect is not Close won), so it clears itself at Close won.

**Why:** the app clears `pre_close_prospect_id` only at the Close won moment, which already happened for these two. Charlotte expects she'll forget and wonder why they didn't move on payment.

**How to apply:** when Charlotte says Heatrite or Heat Wise has paid (or asks why they're still "Not paid yet"), explain the above and give her the clear SQL:
- Heatrite: `update companies set pre_close_prospect_id = null where id = '1b3551da-0471-449c-9918-2ad24e73b002';`
- Heat Wise: `update companies set pre_close_prospect_id = null where id = 'f97c78b1-ca2f-40e0-98b5-02fccd41369f';`
Clearing fires the app's company_pre_close_release_members_trg (only resets GHL sync on held members; safe). Then she can take them Live from the card. Allan Macdonald was churned the same day (backed out).

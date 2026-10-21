---
name: reference-installer-payments-not-in-app
description: "Legacy marketplace revenue can't be read from the InstallrHub DB: claims are on account, no payments recorded, balances deeply negative; cost_per_credit is a list price"
metadata:
  node_type: memory
  type: reference
  originSessionId: 2677aadc-6e33-48e0-9244-790fdd4919a7
  modified: 2026-10-20T18:44:08.346Z
---

Checked 2026-10-20. In the shared Supabase:
- `transactions` claim rows (Apr-Oct 2026, ~1,250) carry no amount_paid or stripe_invoice_id. Credit purchases in the app since April total 45 credits (manual_topup, stripe_topup, deposit).
- `company_balances` (a view: topups + refunds - claims) is negative for 105 of 113 companies, 819 credits in total. Legacy installers claim on account; payment, if any, happens outside the app.
- `companies.cost_per_credit` is £200 for almost all (a list price, not proof of payment). billing_mode: legacy 124, payg 12, subscription 3; only 1 legacy installer has payment_received_at.
- `survey_orders` = the new marketplace (paid orders £180-200 per survey; one is a "Test" order, several have a null amount).

So "credits × £200" is the most that could have been charged, not revenue. Never present it as profit. Related: [[feedback_claim_status_separate_not_profit]].

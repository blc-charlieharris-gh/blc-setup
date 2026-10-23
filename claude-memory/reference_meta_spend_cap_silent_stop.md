---
name: reference_meta_spend_cap_silent_stop
description: "A client-set Meta account spending limit stops delivery while everything shows Active; we can't reset it on client-owned accounts"
metadata:
  node_type: memory
  type: reference
  originSessionId: 99321904-60e0-405c-b836-6fa76a5bbf5c
  modified: 2026-10-23T20:49:29.872Z
---

Elect (act_1458286432823255, 2026-10-23) stopped spending because amount_spent reached spend_cap (£1,000, set by David Blinston on Elect's side on 2026-10-01). Account, campaign, ad set and ad all still showed Active, and spend dropped to pennies an hour.

- Check: `GET act_<id>?fields=amount_spent,spend_cap` (both in pence). amount_spent counts from the last reset, so equal values = stopped.
- Who set it: activity log event_type `ad_account_update_spend_limit` (`/activities` with `since`, all pages).
- Our agency access on client-owned accounts is DRAFT/ANALYZE/ADVERTISE (`user_tasks`, `/agencies`). The limit needs MANAGE, so neither our token nor Charlotte can reset it. The client resets it at business.facebook.com/billing_hub/payment_settings/?asset_id=<id>.
- The limit never resets by itself. The Hub doesn't read spend_cap (known issue, warning card suggested 2026-10-23, not agreed).

Related: [[reference_meta_silent_stop_credit_line]]

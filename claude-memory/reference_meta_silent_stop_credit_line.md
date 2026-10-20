---
name: reference_meta_silent_stop_credit_line
description: "Our own Meta accounts (Green Tide, GT Back Up, BLC Promotions) can stop delivering with everything showing Active; likely monthly-invoicing credit line; our API token can't read billing"
metadata:
  node_type: memory
  type: reference
  originSessionId: 59c668e8-d295-49a2-b80e-6f4a456ff737
  modified: 2026-10-20T13:55:41.956Z
---

On 2026-10-19 ~11am UK, Green Tide Energy, BLC Promotions (same monthly-invoicing funding source) and Green Tide Back Up (business "BLC Promotions New") all stopped spending. Account status 1, no spend cap, ads/ad sets ACTIVE with budget unspent, Pages published, no activity-log changes. Client accounts (own billing) carried on. Combined owed balance ~£20,043, so a full credit line is the prime suspect (Charlotte agreed).

- Our Meta system-user token gets "Application does not have permission" on `/{business}/extendedcredits`, so billing must be checked by Charlotte in Business settings.
- Find the stop hour with insights `breakdowns=hourly_stats_aggregated_by_advertiser_time_zone`.
- `delivery_estimate` shows 0 for healthy ad sets too: useless as a delivery test.
- Status now flags this red ("stopped spending", marketing-status-check v68+). See [[feedback_results_end_yesterday_orders_live]].

---
name: feedback_results_end_yesterday_orders_live
description: Every Hub performance figure ends at yesterday (latestCompleteDay) to match overnight spend; survey order counts stay live; only the Dashboard Today panel shows today
metadata:
  node_type: memory
  type: feedback
  originSessionId: 59c668e8-d295-49a2-b80e-6f4a456ff737
  modified: 2026-10-20T08:59:59.192Z
---

Every performance result in the Hub (spend, leads, bookings, CPL, cost per survey, Analytics, Creative Testing, Ad decisions, marketplace table) ends at the latest complete UK day (`latestCompleteDay` in DateRangePicker), never today. Order fulfilment ("Surveys used of ordered", direct_booking_progress) stays live: confirmed surveys incl today's bookings, cancellations off. The Dashboard's Today scorecard is the one live exception.

**Why:** Charlotte 10-20, "keep all aligned": bookings count live but spend only lands overnight, so today flatters CPL/CPS. But for marketplace orders "we need to know exactly how many confirmed surveys each client has" so we don't overspend.

**How to apply:** any new report or date picker uses latestCompleteDay / clampToComplete, UK day not UTC; saved ranges that ran to yesterday roll forward (useMarketingFilters rollSavedRange). See [[feedback_awareness_spend_in_cpl]].

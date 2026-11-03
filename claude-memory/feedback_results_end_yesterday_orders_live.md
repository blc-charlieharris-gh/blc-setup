---
name: feedback_results_end_yesterday_orders_live
description: Period figures end at yesterday (latestCompleteDay); running totals since the start include today (11-02); survey order counts live; Dashboard Today panel live
metadata:
  node_type: memory
  type: feedback
  originSessionId: 59c668e8-d295-49a2-b80e-6f4a456ff737
  modified: 2026-10-20T08:59:59.192Z
---

Every performance result in the Hub (spend, leads, bookings, CPL, cost per survey, Analytics, Creative Testing, Ad decisions, marketplace table) ends at the latest complete UK day (`latestCompleteDay` in DateRangePicker), never today. Order fulfilment ("Surveys used of ordered", direct_booking_progress) stays live: confirmed surveys incl today's bookings, cancellations off. The Dashboard's Today scorecard is live. **Changed 11-02:** running totals since the start (marketplace "Since their ads started" / "Since it started", Dashboard Lifetime line, Performance All time) include today, labelled "to now": Meta spend syncs hourly at :15 (meta-sync today-only run), so the old "spend lands overnight" reason no longer holds for running totals. 7-day and picked ranges still end yesterday (part days compare unfairly, Meta's today keeps shifting).

**Why:** Charlotte 10-20, "keep all aligned": bookings count live but spend only lands overnight, so today flatters CPL/CPS. But for marketplace orders "we need to know exactly how many confirmed surveys each client has" so we don't overspend.

**How to apply:** any new period report or date picker uses latestCompleteDay / clampToComplete, UK day not UTC; a new since-the-start total includes today (lib/leadStats loadLifetime adds the days after the rollup); saved ranges that ran to yesterday roll forward (useMarketingFilters rollSavedRange). See [[feedback_awareness_spend_in_cpl]].

---
name: project_retrofit_booked_attribution
description: "Why retainer (Retrofit) Performance table shows \"0 booked\" despite real bookings; booked-attribution scatters on fast-cycling ad accounts"
metadata: 
  node_type: memory
  type: project
  originSessionId: 974ae2cb-f0c9-4dc6-88e0-ce74375e8195
---

Retrofit Group ([[project_retrofit_group]]) Performance table showed "0 booked" though the account has genuinely booked surveys (verified 2026-06-24: 27 leads, 6 booked lifetime; 2 in last 7d). The DB total is correct; the per-ad Booked COLUMN is the problem.

Mechanism: a booking is credited to (originating ad × the day it booked) via the phone bridge `leads.contact->>'phone'` = `lead_intake_events.contact_phone`, with `utm_content ~ '^[0-9]{15,20}$'`. Two failure modes stack on a fast-cycling account:
1. **Bookings land on dead ads.** Retrofit duplicates ad sets constantly (resets learning, see [[project_retrofit_group]]), so by booking time the originating ad is paused at £0. The booking shows as Booked=1 on a £0/£3 ad that sorts to the bottom, while every actively-spending ad reads 0.
2. **Booked is window-scoped**, unlike Open/Loss%/Duration which are lifetime via `ad_lifetime_totals`. If the selected range misses the booking dates, it reads 0.

Quick fix (frontend only, no migration): `usePerformanceData.js` already fetches `ad_lifetime_totals` (includes `booked_total`) but only uses it for the Open column. Expose a lifetime Booked column + a client-level total-booked KPI so the headline number is right.

Note: `destination_funnel` and `creative_windowed_totals` RPCs are HARDCODED to Greentide/pps tier (no client param) and return 0/wrong for any retainer client. Retrofit's booked leads create almost no InstallrHub `slots` (6 booked → 1 slot), so any slot/funnel-based booking metric reads ~0 for retainers.

**Why:** retainer accounts behave differently from Greentide (their own booking flow, not InstallrHub slots; high ad churn). Metrics tuned for Greentide silently mislead on retainers.
**How to apply:** for retainer reporting, prefer lifetime + client-total figures over windowed per-ad booked; never reuse the GT/pps-hardcoded RPCs for a retainer.

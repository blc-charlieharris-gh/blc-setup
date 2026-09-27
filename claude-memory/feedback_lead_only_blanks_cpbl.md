---
name: feedback_lead_only_blanks_cpbl
description: "clients.lead_only=true blanks Booked/CPBL/booking-rate/lost-rate in the perf UI and switches leads to Meta-only; check it first when a client shows \"no/thin performance data\""
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e306d040-3199-4d38-bd90-f2686f851312
---

In the marketing-agent dashboard, `clients.lead_only=true` is what makes a client's booked metrics read "N/A": `DashboardKpis.jsx` na's Cost/booked + Booking rate + Lost rate, `BlendedCards.jsx` blanks Booked + Cost per booked, and leads count as Meta-only (not CRM). `tech_windowed_totals` also skips untagged CRM leads for lead_only clients (`cl.lead_only IS NOT TRUE`).

**Why:** InstallrHub (our own brand, act_7095438517245067) was onboarded 07-29 mis-flagged `lead_only=true`, so it looked like "no performance data / no CPBL" when the data was actually flowing (view `ad_performance_with_leads` had rows). The flag, not a broken pipe, was the whole problem.

**How to apply:** when a client shows thin/absent performance or a missing CPBL, check `clients.lead_only` BEFORE hunting for sync/backfill issues. Own-brand clients that book appointments should be `lead_only=false`. There is no edit-client UI for this (add-but-not-EDIT), so it needs a Serafim SQL update. See [[project_new_client_onboarding_reality]], [[project_installrhub_meta_tracking]].

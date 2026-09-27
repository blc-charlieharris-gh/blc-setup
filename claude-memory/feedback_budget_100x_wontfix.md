---
name: feedback_budget_100x_wontfix
description: "meta-sync stores ad budget_cents 100x too high, but it's WON'T FIX (dashboard reads raw/100); stop re-flagging"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 5986718f-e8a1-40f1-a2cb-54c085a5bf66
---

The meta-sync edge fn stores `ads_campaigns/ads_adsets.daily_budget_cents` (and lifetime) 100x too high
(Meta already returns budgets in pence, e.g. "15000" = £150, and toCents multiplies by 100 again). This
kept getting logged as a "bug for Serafim" and re-surfaced session after session.

**Charlotte's ruling 2026-07-01: WON'T FIX.** `useAdBudgets` already reads the TRUE value from
`raw->>'daily_budget'/100`, so nothing on screen is wrong and no other consumer trusts the column. Not
worth Serafim's time.

**Why:** it looks like a bug on the list but isn't visibly broken, so it never earns priority.
**How to apply:** do NOT put this in a Serafim batch or re-raise it. Only reopen if a NEW feature reads
`daily_budget_cents` directly instead of `raw->>'daily_budget'`. Closed in [[project_marketing_bigbuild_prs]]'s
`serafim-pending.md`.

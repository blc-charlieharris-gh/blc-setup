---
name: feedback-shared-concurrency-limiter
description: "Per-hook concurrency caps don't compose — two hooks mounted on the same page can still stack their caps and starve the DB"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6afa6b76-d4db-4f2b-8ece-8808aed93615
  modified: 2026-08-27T12:30:13.888Z
---

marketing-agent, 2026-08-27. Fixed `useDashboardKpis` to cap its own per-client RPC fan-out at 4
concurrent calls (PR #703, after it was found to starve the Dashboard's Lifetime KPI card under
unthrottled fan-out — see [[feedback_never_starve_shared_prod_db]]). Reported fixed, merged. The
exact same symptom came right back (PR #706): `useCampaignTable` mounts on the SAME Dashboard page
and had its OWN independent cap of 4. Two independently-safe local caps stack to 8+ concurrent
calls to the same expensive RPC family on one page load — still enough to starve the DB.

**Why it's easy to miss:** each hook looks correct in isolation (its own cap is real, its own
tests/verification pass). The bug only exists at the PAGE level, where multiple hooks' fan-outs
overlap in time and neither hook has any way to know the other is also drawing on the same DB.

**How to apply:** when more than one hook on the same page independently fans out concurrent calls
to the same expensive resource (a heavy RPC, a rate-limited API), a per-hook `Promise.all`/worker-
pool cap is not sufficient insurance. Use a MODULE-SINGLETON limiter (e.g. a semaphore instance
exported from a shared lib file) that every caller imports, so the budget is genuinely shared
across hooks/components regardless of which one is calling. See `src/lib/concurrency.js`'s
`reportingLimiter` in marketing-agent — a `Semaphore` class instance, capped at 3, imported by both
`useDashboardKpis` and `useCampaignTable`. Also sequence: route the MOST IMPORTANT calls first
(await them before starting a larger secondary fan-out) so they get first claim on the shared slots
rather than competing with everything else queued behind them.

Related: [[feedback_never_starve_shared_prod_db]] (why this DB is sensitive to begin with).

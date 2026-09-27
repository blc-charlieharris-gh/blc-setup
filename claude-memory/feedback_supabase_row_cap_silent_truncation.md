---
name: feedback_supabase_row_cap_silent_truncation
description: "A Supabase/PostgREST query with no ORDER BY that returns more than ~1000 candidate rows can be silently truncated before client-side filtering runs, hiding real data non-deterministically"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 24ad4395-e293-445b-b359-401bf085cfbb
  modified: 2026-09-01T11:30:10.576Z
---

Found 2026-08-31 in marketing-agent's Creatives Matcher: `useMatcherCreatives.js` fetched every
`ads_ads` row for every tracked client (1424 rows, no status filter, no ORDER BY) then filtered to
ACTIVE client-side. Only ~10 of the 31 genuinely-live creatives ever rendered; smaller/later
clients (LJP) could be cut out entirely. Verified via SQL that all 31 existed correctly in the DB
and RLS was wide open (`qual: true` for `authenticated`), ruling out both a data bug and a
permissions bug.

Root cause: fetching >~1000 candidate rows with no explicit ordering risks hitting Supabase's
per-request row cap before any client-side filter gets a chance to run. Since Postgres MVCC means
physical row order drifts away from logical/insertion order as rows get UPDATEd (every sync run
here), which rows survive the cap is effectively non-deterministic — not a clean proportional cut,
some clients' live rows can vanish entirely while others barely notice.

**Fix:** push the real filter (`status='ACTIVE'` here) INTO the query itself, not after fetching.
This shrank the candidate set from 1424 to ~500 rows, safely under the cap, and is strictly better
practice anyway (less data over the wire).

**How to apply:** before writing a Supabase `.select()` that could plausibly return >1000 rows,
either add the narrowest filter that's actually needed as a `.eq()`/`.in()` in the query, or add an
explicit `.order()` + pagination. Never fetch-then-filter-client-side on a table that grows past a
few hundred rows per query. If a "the data looks smaller than it should be" bug can't be explained
by RLS or actual DB state, count the pre-filter candidate rows next — a silent cap is a real
possibility, not a paranoid edge case.

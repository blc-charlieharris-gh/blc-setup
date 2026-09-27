---
name: rpccached-returns-data-error
description: marketing-agent rpcCached/rpcTimeout resolve { data, error } and never throw; treating the result as rows crashed Cost of supply ("(h || []) is not iterable", 2026-09-26)
metadata:
  type: feedback
---

In marketing-agent, `rpcCached(fn, params)` and `rpcTimeout` (src/lib/rpcTimeout.js) resolve the supabase shape `{ data, error }` and never throw (a timeout comes back as `error.timeout`). #1036 did `const rows = await rpcCached(...)` inside try/catch and iterated it: the Cost of supply tab crashed in prod with "(h || []) is not iterable". Fixed in #1037.

**Why:** tests only covered the pure lib (costOfSupply.js), not the hook, and the build can't catch it.
**How to apply:** always `const { data, error } = await rpcCached(...)`, check `error`, then use `data`. Grep new hook code for `await rpcCached(` without `{ data` before pushing. Related: [[reference-marketing-rpc-guards]].

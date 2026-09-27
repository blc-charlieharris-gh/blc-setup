---
name: reference_marketing_rpc_guards
description: "Heavy reporting RPCs in marketing-agent now go through rpcTimeout/rpcCached, not raw supabase.rpc"
metadata: 
  node_type: memory
  type: reference
  originSessionId: abb305e4-98ac-4641-82a4-26eb4e794ede
---

In marketing-agent, the heavy reporting RPCs (`campaign_creative_cpl`, `ad_windowed_totals`,
`campaign_windowed_totals`, `campaign_lead_coverage`, `ad_lifetime_totals`, `reconcile_leads`) that share
the DB with app.installrhub go through **`src/lib/rpcTimeout.js`**, added 2026-07-23 after a saturation
incident:
- `rpcTimeout(fn, params, ms=12000)` — client-side AbortController timeout, returns `{data:null,error}`
  so a stalled call degrades to empty instead of hanging the page.
- `rpcCached(fn, params, {ttl=60000})` — 60s TTL cache keyed on fn+params + in-flight dedupe, so
  navigating Dashboard/Performance/Creative Testing doesn't re-run the same query. Only caches successes.

**Use `rpcCached` for any new heavy windowed read; don't reintroduce raw `supabase.rpc` for these.**

Incident root cause (2026-07-23): `campaign_creative_cpl` was running UNBOUNDED (reads
`ad_performance_with_leads` per migration `20260716000000`; the 20 July batch re-bounded the other RPCs
but not this one), timing out ~8s and, via a client refire loop on realtime echo (fixed #319 with a
value-stable `windowSig` dep), retried in bursts every 10s and pinned the instance. Root cure is
Serafim's one-migration re-bound to `ad_performance_windowed`. See [[feedback_never_starve_shared_prod_db]].

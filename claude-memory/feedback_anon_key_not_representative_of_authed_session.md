---
name: feedback-anon-key-not-representative-of-authed-session
description: "Testing a Supabase RPC via curl with the anon/publishable key does NOT reproduce what a logged-in staff session sees — RLS makes anon results wildly different, sometimes empty, and that's not the bug"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6afa6b76-d4db-4f2b-8ece-8808aed93615
  modified: 2026-08-27T12:30:40.097Z
---

marketing-agent, 2026-08-27. While chasing "Lifetime KPI shows 0", tried to replicate the exact
browser RPC call via curl using the project's anon/publishable key (no session token) to bypass not
having real staff login credentials. Called `ad_windowed_totals(null, '2020-01-01', <yesterday>, null)`
this way, same params the Dashboard sends: got an empty array back in ~0.2s. Read that as evidence
the RPC itself was returning nothing (seemed to confirm the DB-starvation theory). It wasn't real
evidence at all — the SAME call for a specific client also came back with a completely different
(and wrong-signed) delta than a service-role query returned for identical params. The anon/public
role has essentially no RLS-granted read access to these internal reporting tables; authenticated
staff sessions do. An anon-key curl test of an internal tool's RPC tells you what a logged-out
visitor sees, which is deliberately "nothing" — it tells you NOTHING about what a real logged-in
user sees, and chasing it as if it did wastes time down a false lead.

**How to apply:** to test what a real user's browser actually does, you need either (a) real
session credentials (don't try to fabricate/log in without being asked to), or (b) a privileged
read path that mirrors what an authenticated session would see — e.g. Supabase MCP's `execute_sql`
runs as service role, bypassing RLS same as (or more permissively than) `authenticated` normally
would. Prefer (b) for read-only verification. Never use an anon-key curl call as a stand-in for "is
this broken for logged-in users" — if you need to rule out an RLS/auth-only cause, say so
explicitly and ask, don't silently substitute an unauthenticated test and treat its result as
representative.

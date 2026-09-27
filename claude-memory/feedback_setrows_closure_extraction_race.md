---
name: feedback-setrows-closure-extraction-race
description: "Extracting a computed value out of a setState(prev => {...}) updater via a closure `let`, then checking it right after, is not reliably synchronous and can silently skip the rest of the function"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 61afe38f-a213-4f49-98e7-f49da96d2c7e
  modified: 2026-08-27T13:47:28.863Z
---

Never write `let x = null; setX(prev => { x = computeFromPrev(prev); return newState }); if (!x) return`. This assumes React invokes the updater function synchronously within the `setX(...)` call, so `x` is populated by the time the `if` check runs. React's eager-state optimisation (computing the updater's result immediately to bail out of a re-render if nothing changed) only reliably fires for the *first* queued update in a batch. Any hook with realtime traffic or other competing `setState` calls firing in the same tick can cause a second queued update to skip that eager path, leaving `x` still `null` when checked, and the function returns early, silently, before doing whatever came after (often the actual network write).

**Why:** found 2026-08-27 in marketing-agent, `useClientOnboarding.js`'s `setItem`. "Mark call done" on the new kickoff page appeared to work (the optimistic UI flipped to done), but zero PATCH requests ever reached Supabase, confirmed via `query_logs` over a full day of real clicks. Root cause was exactly this pattern, made a near-certainty (not just a rare edge case) because the same hook carries a `postgres_changes` realtime subscription that calls a competing plain `setRows(array)` on every table change, constantly contending with the closure-extraction updater.

**How to apply:** if a hook needs a value that depends on the CURRENT state to do something after the state update (an API call, a side effect), don't pull it out of a functional updater via a closure variable. Either (a) compute it synchronously first from the state already in scope (works when the caller already has the row/value, see `toggleItem`/`setStatus` in the same file), or (b) accept a `[stateVar]` dependency in the `useCallback` and read `stateVar` directly rather than going through `prev` inside an updater. Also: make write functions like this THROW on a Supabase error rather than only setting some other piece of state — a silent swallow here is exactly how this bug hid for a day; see [[feedback_shared_scratch_docs_get_clobbered]] and [[feedback_realtime_channel_name_collision]] for other bugs from this same realtime-heavy hook this session.

---
name: rls-empty-read-looks-like-empty-table
description: "An unauthenticated read against an authenticated-only RLS policy returns ZERO ROWS with no error, so 'empty' and 'not allowed yet' are indistinguishable"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 17372e3a-a593-4324-9b71-a3011727d3cb
  modified: 2026-09-17T18:22:36.155Z
---

A Supabase read from a browser, against a table whose only policy is `for all to
authenticated`, returns **an empty array and no error** when the request is not
authenticated. RLS filters rows; it does not raise. So "this table is empty" and "you
are not signed in yet" look exactly the same to the caller.

This bit hard on the Sales Model board (2026-09-17, see [[project-sales-model-page]]).
The page called `supabase.from(...).select()` as soon as it mounted, which on a cold
load beats Supabase restoring the session from localStorage. The empty result was read
as "brand new board", and its one-off seed steps rebuilt the seeded content over work
the team had been doing all afternoon: source names reverted, every deliverable back to
Not live. It ran twice before I caught it.

**Why it was hard to spot:** by the time anyone clicked anything the session HAD
restored, so writes succeeded and the board looked populated. The symptom the user
reported was "it isn't saving", which sent me to the write path three times. The write
path was fine. The tell was in the data, not the code: all four rows had `updated_at`
within 0.15 seconds of each other, which is not a person clicking. **When something
"won't save", check `updated_at` on the rows before reading any write code.** Clustered
identical timestamps mean something is rewriting them, not that writes are failing.

**How to apply:**
- Await `supabase.auth.getSession()` before the first read in any browser code that
  initialises on mount, and re-read on `onAuthStateChange` when a session appears.
- Never let an empty read drive a destructive decision. If code branches on "no rows
  means fresh install", it needs positive proof of a session, not just absence of data.
- Better still, don't ship self-seeding page code at all: starting content belongs in a
  SQL migration that runs once against the database, never in a page that runs on every
  load against live data.

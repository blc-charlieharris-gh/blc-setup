---
name: feedback_charlotte_plain_explanations
description: "Charlotte's default reaction to a technical, multi-clause explanation is confusion ('huh?', 'i dont undertstand?'); lead with the concrete result in plain short sentences, save mechanism detail for if she asks"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 24ad4395-e293-445b-b359-401bf085cfbb
  modified: 2026-09-01T11:30:21.952Z
---

Recurring pattern across a 2026-08-31/09-01 session (marketing-agent, Creatives Matcher / meta-sync
debugging): whenever an explanation opened with technical framing (row counts, filter chains,
"non-deterministic", background-task execution ceilings) before the bottom line, the reply was a
flat "huh?" or "i dont undertstand?" — even when the underlying finding was correct and had already
been verified against the DB.

What worked every time afterward: restate as 2-4 short plain sentences — what was wrong, what I did,
what to do next — no jargon, no hedging, no multi-clause sentences. E.g. "LJP's data was a day old
because last night's sync got stuck and never reached LJP. I re-ran it manually. It now shows 3
active ads instead of 1. Hard refresh and they should show." Technical detail (exact mechanism,
verification steps, code paths) belongs in a follow-up only if she asks, not the first pass.

**Why:** she is clearly capable of directing detailed follow-up investigation (she asks sharp
clarifying questions like "huh? if it's an LJP creative, needs to be labelled LJP?" that cut right
to the real bug) — the friction is specifically with a wall of technical explanation on the FIRST
pass, not a lack of technical engagement generally.

**How to apply:** default every finding/fix summary in this project to the plain-first format above.
Don't preemptively load an explanation with mechanism ("Supabase's per-request row cap", "execution
ceiling") — lead with the observable symptom and the fix, then stop.

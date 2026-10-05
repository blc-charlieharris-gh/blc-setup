---
name: feedback_charlotte_plain_explanations
description: "Charlotte's default reaction to a technical, multi-clause explanation is confusion ('huh?', 'i dont undertstand?'); lead with the concrete result in plain short sentences, save mechanism detail for if she asks"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 24ad4395-e293-445b-b359-401bf085cfbb
  modified: 2026-10-03T12:21:22.511Z
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

**Prime + handoff write-ups too (2026-10-03):** after a marketing-agent prime she replied "arktek whats
this? coverage areas huh? nine migrations?" and "dont know what you're telling me here" about a
"Skipped: git fetch + two Supabase reads" line. Every item in a prime/handoff report must say in
plain words what it is, who it affects, and whether she needs to do anything. No bare issue titles,
no tool names (git fetch, Supabase reads, cross_agent_notes) without saying what they mean in
practice ("checking GitHub for newer code", "messages Serafim's agent left us"). Don't list
process steps I skipped; just run the safe read-only ones or drop the line.

**How to apply:** default every finding/fix summary in this project to the plain-first format above.
Don't preemptively load an explanation with mechanism ("Supabase's per-request row cap", "execution
ceiling") — lead with the observable symptom and the fix, then stop.

Charlotte 2026-10-05: updates between tool calls get lost ("you'll need to write it all at the end"): give the full explanation in the final message of the turn, not spread across progress notes.

---
name: feedback_diagnose_stated_symptom_not_substitute
description: "when Charlotte names a specific symptom, diagnose that symptom, don't quietly re-explain it as a different issue the data seems to point to"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3f262a58-c62e-4c69-b934-1d6d5ddfc1ff
  modified: 2026-09-02T13:12:49.683Z
---

When Charlotte states a specific, concrete symptom ("it says she's on a call
when she's not"), treat that as the thing to diagnose, not a vague complaint
to be reinterpreted using whatever other issue happens to be top of mind.

**Why:** During the [[project_installrhub_dialer_daily_cap]] /
[[project_installrhub_dialer_stuck_call]] incident (2026-09-02), Charlotte
reported the "already on a call" symptom while a daily-cap conversation was
already in flight. Because the rate-limit numbers were close (163/160), the
literal "already_live" report was reframed as "this is probably actually the
cap again" instead of being diagnosed on its own terms. She'd already fixed
the cap herself (raised to 180) and had to restate the actual symptom before
it was investigated directly. Wasted a turn and read as not listening.

**How to apply:** Diagnose the named symptom first, using whatever check
actually targets it (here: query for an open `agent_calls` row, not the
daily-cap count). If the data legitimately doesn't match their framing,
present that as an observation or question ("no stuck row right now, and
she's under the cap too, so nothing in the DB explains it, could it be X?")
rather than declaratively substituting a different root cause. Let her
correct the frame; don't pre-empt it.

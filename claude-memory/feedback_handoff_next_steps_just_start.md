---
name: feedback_handoff_next_steps_just_start
description: "When the handoff already briefs the next job and Charlotte expects it done, start it on a branch; don't stop to ask \"shall I?\""
metadata:
  node_type: memory
  type: feedback
  originSessionId: c36d660f-4b68-443e-a5c3-02b7bda1d86e
  modified: 2026-10-03T18:22:48.047Z
---

When the handoff's next steps fully brief a job and Charlotte signals she expects it done (e.g. "1 and 2 done" when they weren't), start it on a branch and PR it. Don't end the turn asking for a go-ahead.

**Why:** 2026-10-03, site-installrhub: I had the full brief for the calendar fix and the /book-a-discovery rename, but asked "want me to do both?" twice. She thought I was missing info and chased the other session for it. She called it out: "you made me chase for info you already had".

**How to apply:** Ask only when information or a real decision is missing, and then say exactly what's missing. Otherwise do the work and leave merging to her (merging is still her call). Related: [[feedback_session_management]], [[feedback_charlotte_plain_explanations]]

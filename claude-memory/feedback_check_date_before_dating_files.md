---
name: feedback-check-date-before-dating-files
description: "run `date` before naming migrations, What's new files or writing \"Charlotte MM-DD\"; I dated a whole PR a day ahead on 2026-10-14"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 2ecbe7ef-dfa3-4490-9dec-8e0a5da4e55e
  modified: 2026-10-14T20:06:39.940Z
---

Before naming anything with a date (migration versions, src/whatsNew/YYYY-MM-DD-HHMM files, "(Charlotte 10-14)" comments, handoff titles), run `date` and use it. On 2026-10-14 I assumed it was 10-15, and a subagent copied the assumption, so a migration, three What's new files and ~30 comments had to be renamed before merge.

**Why:** dates drive migration order, What's new sorting and the audit trail; a wrong one is silent.
**How to apply:** first dated thing in a session -> `date`; pass the real date to subagents in their prompt.

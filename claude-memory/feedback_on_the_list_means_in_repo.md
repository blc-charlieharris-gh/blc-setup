---
name: feedback-on-the-list-means-in-repo
description: "Only tell Charlotte something is 'on the list' / 'at the end of the audit' once it's written in the repo's audit README or known-issues, not just in Claude memory"
metadata:
  type: feedback
---

2026-10-04: Charlotte had asked twice for the Analysis page and was told it was "at the end of the audit". It was only in Claude's per-machine memory (project_analysis_page_roadmap), not in marketing-agent/.claude/docs/hub-audit/README.md, until #1419. She said she needs to be able to trust what she's told.

**Why:** memory is per-machine and handoffs get overwritten; the repo is what every session and Serafim read.
**How to apply:** before saying "it's on the list", check it's in the repo (audit README, known-issues or the handoff) and name where. If it isn't, write it there in the same turn. Same for "done": say exactly what's done and what isn't (10-04: called draft saving "part-built" after saying it was done). Related: [[feedback_verify_known_issues_against_live]], [[project_analysis_page_roadmap]].

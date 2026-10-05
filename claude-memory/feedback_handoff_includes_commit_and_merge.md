---
name: feedback_handoff_includes_commit_and_merge
description: A handoff isn't finished until the handoff file is committed, PR'd and merged to main; don't stop and ask, even though the handoff skill says it never commits
metadata:
  type: feedback
---

2026-10-05 Charlotte: "why do you leave handoffs half finished?" after the site handoff stopped at an uncommitted docs/current-handoff.md and asked permission to PR it.

**Why:** the handoff skill's own rule ("never commit, push, merge") leaves the file only on this machine, so the next session priming from GitHub reads the old notes. She counts that as an unfinished handoff.
**How to apply:** at the end of every handoff, put the handoff file (and any repo-tracked changelog) on its own docs/handoff-YYYY-MM-DD branch, open the PR and merge it (site-installrhub: gh is fine; marketing-agent: no gh, no Co-Authored-By, give her the PR link), confirm main = origin. Don't ask first. Related: [[feedback_session_management]], [[feedback_handoff_next_steps_just_start]]

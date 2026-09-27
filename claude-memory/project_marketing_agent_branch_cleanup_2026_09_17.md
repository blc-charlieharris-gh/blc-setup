---
name: project_marketing_agent_branch_cleanup_2026_09_17
description: "marketing-agent branch cleanup backlog as of 2026-09-17 — 13 just-merged branches confirmed safe, ~110 pre-existing stale ones need the GitHub Branches page"
metadata: 
  node_type: memory
  type: project
  originSessionId: 696dfa91-015b-4c1c-8308-6a8e631cf4a2
  modified: 2026-09-17T07:40:00.971Z
---

Handoff from another session, 2026-09-17: that session opened 15 PRs (#769-#783), all confirmed
merged to `main`. Their branches are confirmed safe to delete:
`feat/client-reports-eligibility-gate`, `fix/reports-picker-excludes-onboarding`,
`feat/creative-testing-improvements`, `fix/nurture-preview-name-leak`,
`docs/session-handoff-2026-09-14`, `fix/period-activity-leads-name-mismatch`,
`feat/campaign-client-labels-and-booking-rates`, `fix/performance-true-booked-per-ad`,
`fix/performance-unattributed-leads-row`, `feat/board-card-and-perf-table-clarity`,
`fix/board-card-child-styling`, `docs/session-handoff-2026-09-14-part2`,
`docs/session-handoff-2026-09-17`.

Beyond those, ~110 more stale branches going back weeks — a pre-existing mess, not from that
session's work.

**Why:** repo hygiene backlog, not urgent, but the mechanics matter enough to record:
- **Don't trust `git branch --merged`** — this repo squash-merges, so it undercounts massively
  (a prior check found only 1 of 124 actually-merged branches this way). See
  [[feedback_squash_merge_hides_from_commit_match]].
- **Use the GitHub Branches page instead** — it shows merge status per branch correctly via the
  PR record.
- **Bulk CLI deletes hit Claude Code's own classifier at an inconsistent threshold on this
  repo** (documented from a prior 165-branch cleanup) — see
  [[feedback_bulk_branch_delete_classifier_limit]]. Delete from the GitHub Branches page, not a
  scripted bulk CLI pass.

**How to apply:** when asked to clean up marketing-agent branches, start with the 13 named
above (already PR-confirmed merged), then work the ~110 pre-existing stale ones via the GitHub
Branches page rather than `git branch --merged` or a bulk CLI delete loop.

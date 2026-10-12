---
name: feedback-migration-version-collision-between-sessions
description: "Two sessions in marketing-agent both named a migration 20261012210000 on 10-12; check origin/main's migration list right before naming and commit"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 2ce9a8c2-9e9c-4e30-a7d9-643584af5866
  modified: 2026-10-12T20:39:01.745Z
---

On 2026-10-12 blc-36 (prospect_audits) and blc-5a (sales_reviews) each created `supabase/migrations/20261012210000_*.sql` on separate branches; both merged. Both were run by hand in the SQL editor, so prod was fine, but two files with one version break a rebuild from the repo. Renamed prospect_audits to 20261012210500 in the night handoff PR.

**Why:** sessions branch from main at different times and pick "next round number" timestamps independently.
**How to apply:** when another session is live in the same repo, `git fetch` and `ls supabase/migrations | grep <today>` immediately before naming a migration, pick an odd minute (e.g. ...210500), and re-check before merge. Related: [[feedback_whatsnew_conflicts_one_pr]], [[feedback_coordinate_other_sessions_automatically]].

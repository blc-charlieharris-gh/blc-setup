---
name: feedback_soft_reset_origin_main_moves
description: origin/main is shared across worktrees; a soft reset to it after merging can silently undo other sessions' newer commits
metadata:
  type: feedback
---

Never `git reset --soft origin/main` to squash a worktree branch: another session's fetch moves that shared ref, and the commit then reverts everything merged since.

**Why:** 11-08 zero-upfront branch; the commit showed 50 files instead of 33, reverting 13 files of others' work (caught before the merge link went out).

**How to apply:** after any squash, compare `git diff --name-only HEAD~1..HEAD` with the files you changed before pushing. Pin the base sha rather than the name. See [[feedback_check_branch_before_commit_new_worktree]].

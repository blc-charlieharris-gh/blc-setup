---
name: feedback_verify_merge_before_branch_cleanup
description: "Before deleting a PR branch/worktree, gate on origin/main actually containing it; \"merged\" from the user can be premature"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 2207cf9e-b1b7-4849-a16f-6859302e071b
  modified: 2026-09-27T12:10:58.442Z
---

Only delete a feature branch (local + remote) and its worktree after `git fetch` shows the PR's squash commit on origin/main (title + `(#NNNN)`), checked by a command that STOPS if it's missing, e.g. `git log origin/main --oneline -20 | grep -q "<PR title fragment>" || exit 1` before any `git branch -D` / `push --delete`.

**Why:** 2026-09-27 Charlotte said "sql ran and merged" for Actions PR 2; origin/main was still on the previous PR. I printed the log but chained the delete anyway, which removed the remote branch (and would have closed her PR). Recovered by re-pushing the commit from the local object store.

**How to apply:** every PR cleanup in the Hub audit ([[project_hub_page_audit]]). If the merge isn't there, say so and ask, don't clean up.

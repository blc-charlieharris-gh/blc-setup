---
name: feedback-never-commit-agent-worktrees
description: "git add -A in marketing-agent picked up a running helper's .claude/worktrees/ folder as an embedded repo (10-04); now gitignored, still add files by name when helpers run"
metadata:
  type: feedback
---

On 10-04 `git add -A` on a batch branch committed `.claude/worktrees/agent-…` (a live helper's worktree) as a gitlink, and the following branch switch tried to rmdir it mid-run. Fixed with `git rm --cached` + `.claude/worktrees/` added to .gitignore (#1432).

**Why:** helper agents with isolation "worktree" live inside the repo folder.
**How to apply:** while helpers run, stage files by name or check `git status` for `.claude/worktrees` before committing; remove finished helpers' worktrees (`git worktree remove --force`, then delete the `worktree-agent-*` branch) before switching branches. Related: [[feedback_commit_via_temp_index_on_main]].

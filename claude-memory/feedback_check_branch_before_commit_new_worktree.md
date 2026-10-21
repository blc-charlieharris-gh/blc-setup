---
name: feedback-check-branch-before-commit-new-worktree
description: "After making a new worktree, confirm the shell is in it (git branch) before editing/committing; a commit landed on the old branch and the PR wouldn't merge"
metadata:
  node_type: memory
  type: feedback
  originSessionId: ca3da656-04aa-480e-9e0a-2eb35fcf7ff5
  modified: 2026-10-21T07:06:50.268Z
---

10-21: `git worktree add ../new && cd ../new && ...` ran, but the next commands still ran in the PREVIOUS worktree
(no "Primary working directory" update followed). The image-rule commit landed on the already squash-merged
cover-design branch and was pushed as image-rule-1021, so GitHub wouldn't merge it (stacked on the unsquashed copy).
Fixed by cherry-picking onto a fresh branch off origin/main.

**Why:** Charlotte hit "this doesn't let me merge" and lost time.
**How to apply:** after creating a worktree, run `git branch --show-current` in the next command and check it before
editing; before every push, `git log --oneline origin/main..HEAD` must show only this change's commits.

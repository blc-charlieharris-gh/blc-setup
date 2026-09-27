---
name: feedback-shared-tree-on-other-branch-edit-in-worktree
description: Before editing in the shared marketing-agent tree, check its branch; if it isn't main (another session's branch), files may be stale, so edit in your own worktree off origin/main
metadata:
  type: feedback
---

On 2026-09-24 the shared marketing-agent tree was sitting on another session's branch
(fix/click-path-matches-every-address), which was cut BEFORE my Core Electrics PR #963 merged. I
had just reset my Core files there to that branch's HEAD, so the folder silently held the OLD site
(no heat pumps, no finance, no rebrand). I then edited it for the font change. The clue was the build
printing "built 9 pages" instead of 11. I undid the edits and redid the work in a worktree off
origin/main.

**Why:** a shared tree's checked-out branch is whatever the last session left it on. Its files can
be older than main even when `git status` is clean.

**How to apply:** before editing anything in the shared tree, run `git branch --show-current` and
`git rev-list --count HEAD..origin/main`. If it isn't main, or is behind, don't edit there: make a
worktree (`git worktree add -b <branch> <scratch path> origin/main`), symlink the repo's
node_modules into it if the build needs it (website-factory builds use lightningcss/rolldown from
there), copy any gitignored `.vercel/` link across for deploys, and work there. Sanity-check build
output (page counts) against what should exist. Related: [[git-commit-via-temp-index-on-main]],
[[reference-client-site-vercel-deploy]].

---
name: never-checkout-main-over-uncommitted
description: "Never run `git checkout origin/main -- .` (or a bare `git checkout origin/main --`) to compare against main: it overwrites uncommitted edits or detaches HEAD"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 8a6ce8b3-54c8-4a3b-a874-0c95a399b81c
  modified: 2026-11-03T18:50:40.139Z
---

To check whether a test fails on main too, use a separate worktree (or commit first). `git checkout origin/main -- .`
silently replaced 3 edited files with main's copies (11-03, Client updates follow-up), and a bare
`git checkout -q origin/main --` detached the shared marketing-agent checkout off its branch.

**Why:** both lost or moved work in a shared tree with no warning.

**How to apply:** commit (or WIP-commit) before any checkout; compare with main via `git worktree add` in a temp folder.

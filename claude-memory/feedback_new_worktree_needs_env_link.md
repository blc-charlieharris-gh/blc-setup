---
name: new-worktree-needs-env-link
description: "A fresh marketing-agent worktree fails every vitest file with \"supabaseUrl is required\" until .env/.env.local are linked"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9223e662-18bd-4a3f-b783-c951cc95799f
  modified: 2026-10-29T16:42:52.335Z
---

A new marketing-hub worktree (git worktree add) has no node_modules or .env files. Without them, 97 test files fail with "supabaseUrl is required", which looks like a broken branch.

**Why:** 10-29 golive-copy session, the first test run failed that way.

**How to apply:** right after creating the worktree, symlink `node_modules`, `.env` and `.env.local` from `../marketing-agent/`. They're gitignored, so the links never show up in git status. See [[feedback_check_branch_before_commit_new_worktree]].

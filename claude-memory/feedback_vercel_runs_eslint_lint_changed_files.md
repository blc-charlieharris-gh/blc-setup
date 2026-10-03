---
name: feedback_vercel_runs_eslint_lint_changed_files
description: "marketing-agent Vercel build is `eslint . && vite build`; vite build alone passing isn't enough, run eslint on the changed files before pushing"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 96fe6ac9-c04b-4843-addc-b53f56151d40
  modified: 2026-10-03T15:41:41.071Z
---

2026-10-03: feat/webinar-attendance-tags failed its Vercel check though `npx vite build` was green locally. Vercel
runs `npm run build` = `eslint . && vite build`; an invisible BOM character in a regex (`/^﻿/` written as the
literal char) tripped `no-irregular-whitespace`. Locally, full `eslint .` shows ~300 errors from worktrees/other
folders, so it's useless as a gate.

**Why:** a red Vercel check blocks Charlotte's merge and costs a round trip.

**How to apply:** before pushing a Hub branch, run
`npx eslint $(git diff --name-only origin/main...HEAD | grep -E '\.(js|jsx)$')` and fix any **errors** (warnings
are fine), plus `npx vite build`. Tell subagents to do the same. Related: [[feedback_api_imports_need_js_extension]].

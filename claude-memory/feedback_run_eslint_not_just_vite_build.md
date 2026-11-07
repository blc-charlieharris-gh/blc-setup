---
name: feedback-run-eslint-not-just-vite-build
description: "marketing-agent's Vercel build is `eslint . && vite build`; run `npx eslint .` before pushing, a clean vite build isn't enough"
metadata:
  node_type: memory
  type: feedback
  originSessionId: fc073161-15a1-457a-b65b-e017c6693ad1
  modified: 2026-10-26T09:11:26.290Z
---

26 Oct 2026: #2525 failed its production deploy on `no-sparse-arrays` (`|| [, a, 0, '']`) after I'd only run `npx vite build` locally; the next merge built on top would have failed too.

5 Nov 2026: #3255 broke production with one What's new line: `sed` put "double quotes" inside a double-quoted body string. I had only linted `src/pages/public`. Text-only edits count too: full `npx eslint .` + `npx vite build` before EVERY push, and never sed quote marks into JS strings.

**Why:** the build script lints first and any eslint error fails the deploy; vite alone doesn't lint.
**How to apply:** before every push in marketing-agent run `npx eslint .` (0 errors; ~240 warnings are normal) plus the touched tests (`VITE_SUPABASE_URL=http://x VITE_SUPABASE_ANON_KEY=x npx vitest run ...` in a worktree with no .env). After a merge, check `gh api repos/serafimparente-blc/marketing-agent/commits/<sha>/status`; logs via `blc-vercel inspect <dpl> --logs --scope blc-promotions`.

11-06 #3289: same apostrophe trap (website's in a single-quoted What's new body, added by a python replace). eslint was run but only `tail -1` looked at, which printed nothing. Check the exit code (`npx eslint . ; echo $?`) after every edit, and write What's new bodies in double quotes.

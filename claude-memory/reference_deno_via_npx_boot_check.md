---
name: reference_deno_via_npx_boot_check
description: This Mac has no deno, so scripts/boot-check.sh fails; boot paste copies with npx -y deno@2.1.4 run -A
metadata:
  type: reference
---

No `deno` on the Mac (10-19), so `scripts/boot-check.sh <file>` prints FAIL with no error lines. Boot the paste copy by
hand: copy it to a temp dir with `{"nodeModulesDir":"auto"}` as deno.json, then
`SUPABASE_URL=http://localhost:1 SUPABASE_SERVICE_ROLE_KEY=x SUPABASE_ANON_KEY=x perl -e 'alarm 40; exec @ARGV' npx -y deno@2.1.4 run -A fn.ts`
and look for "Listening". Kill it after (`pkill -f "deno.*run -A fn.ts"`) or the next run hits AddrInUse on :8000.
Bundle client-portal (imports src/lib) with `node scripts/bundle-edge-fn.mjs <entry> <out>`, not the .py. Related: [[feedback_paste_deploy_open_the_file]].

10-21: perl's alarm kills npx, not the deno child, so deno outlives the check and holds :8000 (one stale one ran 3h,
from another session: don't kill other sessions' ones). Port-free way: prepend
`const __s = Deno.serve; (Deno as any).serve = (a: any, b?: any) => typeof a === "function" ? __s({ port: 0 }, a) : __s({ ...a, port: 0 }, b);`
to the copy, run in a scratchpad temp dir, then kill only deno pids whose cwd (lsof -d cwd) is that temp dir.
A fresh worktree also needs node_modules and .env/.env.local symlinked from marketing-agent for bundling and vitest.

10-27: never `pkill -f deno` to free :8000 (blc-0b did once with two other sessions live; it can kill their checks).
Use the port-0 prepend above, or kill only the pid whose cwd is your own temp dir.

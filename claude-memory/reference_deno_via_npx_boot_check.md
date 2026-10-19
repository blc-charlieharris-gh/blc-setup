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

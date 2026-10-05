---
name: reference-edge-fn-bundle-and-boot-check
description: nurture-run/broadcasts paste copies need scripts/bundle-edge-fn.mjs directly; deno isn't installed, boot-check with npx -y deno
metadata:
  type: reference
---

In marketing-agent (2026-10-05): `python3 scripts/bundle-edge-fn.py nurture-run` refuses ("imports a _shared file this script does not inline yet"). Use the rolldown bundler directly: `node scripts/bundle-edge-fn.mjs supabase/functions/<fn>/index.ts ~/Code/BLC/_deploy/<fn>.ts`. `scripts/boot-check.sh` needs `deno`, which isn't installed on the Mac: boot by hand with `npx -y deno run -A fn.ts` (env SUPABASE_URL/SERVICE_ROLE_KEY/RESEND_API_KEY dummies, `{"nodeModulesDir":"auto"}` deno.json) and look for "Listening"; kill leftovers (`pkill -f "deno run -A fn.ts"`) or the next boot fails with AddrInUse. After Charlotte deploys, confirm with list_edge_functions (version, verify_jwt unchanged) and the next cron run (nurture-run every 5 min; joins_checked_at moves). Related: [[feedback-rebuild-deploy-files-before-paste]].

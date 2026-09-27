---
name: project_meta_sync_nightly_skips_tail_clients
description: "PR #753's meta-sync dispatchAll fix finally went LIVE as v56 on 2026-09-17 (Charlotte hand-pasted via dashboard Code tab). Before that it was never deployed (docs wrongly say v55 on 8 Sep). Nightly full sync dies at InstallrHub and every client behind it (HQ Group, Gas Worx, sometimes National Eco/Helix) silently never gets new ads. Workaround = targeted single-client POST. Dashboard hand-paste trap: a second OLD copy sits in .claude/worktrees."
metadata:
  type: project
---

Found 2026-09-17 when Charlotte's new test ads for HQ Group + Gas Worx wouldn't appear in the
Creative Testing "Tag the live ad" modal.

**Status 2026-09-17 ~09:48 UTC: FIXED, v56 live with `dispatchAll` (verified via get_edge_function).** Before that, what was running: the Greentide-first in-process `runAll` loop (the pre-#753 code). The
repo copy (`supabase/functions/meta-sync/index.ts`, commit 3bc428f, PR #753, 687 lines) is the
`dispatchAll` client-isolation rewrite. known-issues.md + CHANGELOG (2026-09-08) claim it was
"deployed (v55), live-verified 11/11". That is WRONG: `get_edge_function` showed v54 dated
2026-09-01 as current on 09-17 morning, and Charlotte's hand-paste that day became v55, so no
deploy happened between 1 Sep and 17 Sep. The 8 Sep "11/11 at 8s intervals" was per-client
triggers (`scripts/trigger-meta-sync-client.mjs` style POSTs), not the dispatch code. I first
wrote this up as "deployed then reverted"; there was no revert, it never went live. Likely the
same trap as [[feedback_supabase_dashboard_deploy_silent_noop]].

**Second trap (hit 2026-09-17):** the first hand-paste deployed the OLD code as v55. Cause: a
second copy of `meta-sync/index.ts` lives at
`.claude/worktrees/nurture-sms-date-steps/supabase/functions/meta-sync/index.ts` (636 lines, no
dispatchAll) and VS Code quick-open finds it first. Always open the file by absolute path and check
line 66 reads `CLIENT ISOLATION (2026-09-07)` before copying; check the same line in the dashboard
editor before clicking Deploy; then confirm with `get_edge_function` that `dispatchAll` is present.

**Symptom pattern (how to spot it fast):** `sync_runs` for the 03:00 run shows ~2-8 clients
`success` then `InstallrHub:started` and nothing after. Every hourly `:15` run is `mode:today`
with `ads:0` and CANNOT add ads. A client behind InstallrHub in heap order has `max(synced_at)`
frozen for days, and any ad created after that date is absent from `ads_ads`. Since 08 Sep
HQ Group and Gas Worx had zero full syncs; National Eco last 14 Sep, Helix 15 Sep.

**Workaround that works (used 2026-09-17, both finished in <10s):**
POST `https://ozmyjrzleejbqxqphbut.supabase.co/functions/v1/meta-sync` with header
`apikey: <publishable key, visible in cron.job>` and body `{"client_id":"<clients.id>","wait":true}`.
Small accounts are safe synchronously; it is the same call the cron makes. Do NOT run an
all-client full trigger by hand on the old code (that is the failing path).

**Deploy route on this machine:** no supabase CLI, no sbp_ token, MCP read-only. Charlotte's
dashboard has NO Deployments tab (tabs: Overview, Invocations, Logs, Code, Settings). Route =
Code tab, replace index.ts, click Deploy. The editor keeps `_shared/error-log.ts` (v55 bundle
still had it), so the `../_shared/error-log.ts` import is fine via the dashboard.

**Tag-modal side note:** `TagLiveAdModal` lists only status=ACTIVE ads in ACTIVE ad sets under
the test's campaigns, filtered by `keepLastPullOnly` (12h slack off the client's newest synced_at).
A stale client passes the freshness filter with ALL its rows, so stale statuses show as live.
Nothing in the modal is wrong; the data behind it was.

See [[project_edge_fn_repo_drift_A0]], [[feedback_supabase_dashboard_deploy_silent_noop]],
[[feedback_creative_testing_model]], [[project_new_client_onboarding_reality]],
[[feedback_never_starve_shared_prod_db]].

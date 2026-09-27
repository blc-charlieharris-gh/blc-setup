---
name: project_meta_assets_discovery
description: "'Find on Meta' crawl button on /clients, built 2026-08-10; frontend pushed, read-only edge fn staged for Serafim, and Gas Worx access never reached our token"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9f6ce79c-9f19-49d3-8535-930912ccc48f
  modified: 2026-08-10T12:01:57.887Z
---

Built and SHIPPED 2026-08-10. Frontend merged as **#547**, live and verified in the production
bundle. Edge fn `meta-assets-discover` **v1 ACTIVE**, deployed by Charlotte from the Supabase
dashboard (Serafim not involved, she overrode the usual Tier-2 gate). Confirmed working by her.

**Live is the STANDALONE build** (`meta-assets-discover.standalone.ts`, error-log helper inlined),
because the dashboard editor deploys one file and cannot resolve `../_shared/error-log.ts`. The
repo also holds `.index.ts`, the `_shared`-importing version. **Neither is in the InstallrHub repo
at all**, which is logged as an open mirror item in `.claude/docs/deployed-edge-fns/README.md`
(branch `docs/meta-assets-discover-mirror`). Mirror `.index.ts` then redeploy once, or the repo
holds something that is not what is running.

**Deploy note for next time:** this machine CANNOT deploy edge fns. MCP Supabase is read-only, no
Supabase CLI, no management access token. Only the dashboard, or an `sbp_` token in `.env`.

**What it does:** "Find on Meta" panel at the top of `/clients` crawls every ad account and Page our
Meta token can see, badges the ones no client owns, and assigns them from a dropdown. This was step 3
of `plan-new-client-onboarding.md`, the last missing piece of adding a client, open since 07-14.

**The thing to remember: `meta-sync` does NOT discover anything.** It only syncs ad accounts already
written into `clients.meta_ad_account_id`. A newly-permissioned account is invisible to the hub until
its id is typed in. Discovery is a separate Graph call (`me/adaccounts` + `me/accounts`) that nothing
in the stack made before this.

**Files:** `src/components/clients/MetaDiscoveryPanel.jsx`, `src/hooks/useMetaAssetsDiscovery.js`,
wired in `src/pages/hub/ClientsManage.jsx`. Edge fn staged (NOT deployed) at
`.claude/docs/edge-fn-drafts/meta-assets-discover.index.ts`, a near-copy of `meta-pages-admin`,
read-only, one `list` action, `verify_jwt=true`. Serafim deploys it, see
[[project_serafim_outstanding_2026_07_29]]. Until then the panel detects the 404 and says
"waiting on a deploy" instead of erroring, so the frontend merges independently.

**Assignment is frontend-only** because the browser has been allowed to write
`clients.meta_ad_account_id` since #345. Reassigning clears the previous holder FIRST, or the id sits
on two clients and every join double-counts. Pages go through `meta-pages-admin` → `link_client`.

**Gas Worx is NOT on our token** (crawled by hand 08-10 with the system-user token, app "Lead Forms").
BLC Promotions business `3371452816410016` holds 2 owned + 6 client ad accounts, 3 owned + 5 client
Pages, and no Gas Worx ad account or Page. Their Meta access has to be re-granted to the BLC business
or the system user, not to a personal profile. Gas Worx's client row `24e457e0` is otherwise ready
(tracked, retainer, target CPL £30, company linked); only `meta_ad_account_id` is null.

**Repo rule I nearly tripped:** marketing-agent's CLAUDE.md forbids `gh` in that repo entirely
(the CLI's active account is device-wide and switching it hijacks the personal-account project).
Push, then open the printed pull/new URL in a browser.

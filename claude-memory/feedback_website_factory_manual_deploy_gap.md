---
name: feedback_website_factory_manual_deploy_gap
description: "website-factory client sites don't redeploy on merge to main, and their stable alias doesn't follow new prod deploys either — both need manual vercel CLI steps"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 4e7a3e61-f8cb-45ac-b9a0-c3d4fcccbd9a
  modified: 2026-09-01T14:01:31.369Z
---

`marketing-agent/website-factory/clients/<slug>/` (each real client site: Arktek, Gas Worx, LW Heating, SWH Electrical, Retrofit Group, Renerji) is `.vercelignore`d from the main app's Vercel git integration — it's a separate static site, its own Vercel project. Editing HTML there and merging the PR to `main` changes **nothing live**. Discovered on Arktek 2026-09-01: a merged Web3Forms key-swap PR sat live-looking for hours while the actual site kept serving the old key.

**Worse:** even a correct `vercel deploy --prod` from the CLI doesn't move the human-friendly alias (e.g. `arktek-installrhub.vercel.app`, stored in `hub_clients.url` and used everywhere: the audit, TransferLinkPanel, staff preview links). That alias was manually pinned once (`vercel alias set <deployment> <alias>`) and stays frozen to that deployment forever unless re-pointed. New prod deploys get their own fresh throwaway `.vercel.app` URL and never touch it.

**Why:** two independent gaps stacking. The `.vercelignore` fence is deliberate (README: "isolated subfolder ... independent of that app"). The alias-pinning is just how Vercel aliases work — they don't auto-follow "latest production" unless you re-set them.

**How to apply:** after ANY content change to a `website-factory/clients/<slug>/` file that needs to go live (not just committed), run both, from inside that client's folder:
```
vercel deploy . --prod -y --no-wait --scope <team-slug>
vercel alias set <the-new-deployment-url-from-above> <the-client's-pinned-alias> --scope <team-slug>
```
Then verify with a direct `curl` against the pinned alias, not just the fresh deployment URL — they can diverge silently. See [[reference_installrhub_git]], [[feedback_spa_stale_bundle_vs_deploy]] (related but distinct: that one's about a stale browser tab on the main app, this is about the deploy pipeline itself never firing). Logged as an open known-issue in `.claude/docs/known-issues.md` (2026-09-01) pending real automation.

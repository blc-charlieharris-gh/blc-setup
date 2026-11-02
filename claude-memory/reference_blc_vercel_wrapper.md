---
name: reference-blc-vercel-wrapper
description: Deploy BLC sites with ~/code/blc-setup/bin/blc-vercel (own BLC login, scope blc-promotions); plain `vercel` on this Mac is another account
metadata:
  type: reference
---

Each project has its own scoped login (Charlotte 10-22). BLC's Vercel CLI is `~/code/blc-setup/bin/blc-vercel` (= vercel --global-config ~/.config/vercel-blc), signed in as charlieharris-4909, team `blc-promotions`. Plain `vercel` is the PULSET account: never say "can't deploy" from it.

Client site deploy (website-factory/clients/<slug>): git status clean in the folder, `blc-vercel link --yes --project <slug> --scope blc-promotions`, `blc-vercel deploy --prod -y --scope blc-promotions`. Link drops a `.gitignore` and `.env.local` in the folder: delete both after. Check the live page with curl. See [[feedback_client_folder_deploy_uploads_untracked]].

The Vercel MCP plugin is also on another account: `list_deployments` for blc-promotions returns 403. To check an installrhub-site deploy after a merge, use `blc-vercel ls installrhub-site --scope blc-promotions`, or the browser pane on vercel.com/blc-promotions/installrhub-site/deployments (Charlotte is signed in). A Production build can sit "Queued" for ~4 min before building (11-02); that is not a missed merge.

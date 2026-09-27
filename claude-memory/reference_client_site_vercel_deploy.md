---
name: reference-client-site-vercel-deploy
description: "How website-factory client sites get onto Vercel (CLI link + deploy per folder, blc-promotions team), Claude can run it"
metadata:
  node_type: memory
  type: reference
  originSessionId: 2eb85121-7db1-47ba-b989-ee3c914209db
  modified: 2026-09-24T08:52:52.369Z
---

Each website-factory client site (swh-electrical, gasworx, arktek, core-electrics) is its own Vercel project in team `blc-promotions`. They're linked by the CLI, which writes `.vercel/project.json` into the folder (gitignored), and none are git-connected. New site: `vercel link --yes --project <slug> --scope blc-promotions`, then `vercel deploy --prod --yes --scope blc-promotions` from the folder. That auto-aliases `<slug>.vercel.app`. On 2026-09-24 Claude ran both without being blocked; the CLI is logged in as charlieharris-4909. The folder's `.vercelignore` keeps `_*`, build-pages.mjs and meta.json out, so verify those 404 on the live URL. There's also a written playbook at `website-factory/docs/client-site-deploy-playbook.md`, but no skill.

The Hub's "Push to preview + audit" panel (`PushAuditPanel.jsx`) takes the vercel.app URL, and wants the end domain set in Delivery setup first. See [[feedback_website_factory_manual_deploy_gap]].

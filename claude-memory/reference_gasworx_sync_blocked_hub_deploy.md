---
name: gasworx-sync-blocked-hub-deploy
description: "\"Blocked\" Vercel deploys titled \"Gas Worx: automated Soro blog sync\" are the Hub project refusing the bot's commit; the Gas Worx site itself deploys fine"
metadata:
  node_type: memory
  type: reference
  originSessionId: 0576305c-b366-4b9c-8fa5-540ae6921ae3
  modified: 2026-10-27T11:57:46.532Z
---

The Gas Worx Soro blog sync (.github/workflows/gasworx-soro-sync.yml, about every 2 days) commits new posts to marketing-agent main as gasworx-soro-sync[bot], then deploys the Gas Worx site by CLI. Vercel blocks the **Hub** project's (marketing-agent) git deploy of that commit, because the bot isn't a team member. It shows as "Blocked, Production, github/actions". It's harmless: the next team commit deploys the Hub.

To check the site: `~/code/blc-setup/bin/blc-vercel ls gasworx --scope blc-promotions` (Ready deploys) and the new post on gasworx.vercel.app. Don't check gas-worx.co.uk, which is still their Wix site (it 404s Hub-built posts).

On 2026-10-27 Claude first misread this as the site failing. Charlotte chose to leave the Blocked lines. Making the bot commit as a team member was refused by the safety check, since it gets past Vercel's author check by having a robot appear as her.

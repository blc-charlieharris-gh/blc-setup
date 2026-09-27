---
name: prebuilt-deploy-overrides-main
description: "marketing-agent: a merged PR can be missing live because a manual `vercel --prod` from a stale local tree replaced the git-main deploy; check which deployment holds the alias"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 11f3dd0f-faf4-4335-be72-e4305464e479
  modified: 2026-09-18T13:53:02.765Z
---

On 2026-09-18, PRs #804-#806 were merged and deployed from git-main, but internal.installrhub.com did not have them. At 14:43, another session ran `vercel deploy --prod` from a stale local branch. That deploy was 2 seconds long, had no git ref, and took over every production alias. The other session re-promoted the git-main build (dpl_EaKAEs69yb8FnYYjCYMrHwxASHRH) and agreed to ship only through PRs from then on.

**Why:** in `vercel ls`, the manual deploy looks just like the git deploys: both show as Production, Ready, and under the same username. Only the ~2s duration and its absence from `vercel ls -m githubCommitRef=main` give it away.

**How to apply:** when a merged change isn't live, first grep the live bundle (`curl internal.installrhub.com/`, then the `assets/index-*.js` file) for a string unique to the change. Then run `vercel inspect <url> --scope blc-promotions` on the newest production deploys to see which one holds the aliases. If a non-git deploy holds them, don't re-promote over it yourself, since that could wipe someone else's work; flag it to Charlotte. Related: [[feedback_spa_stale_bundle_vs_deploy]], [[feedback_website_factory_manual_deploy_gap]].

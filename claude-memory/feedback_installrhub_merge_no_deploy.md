---
name: feedback_installrhub_merge_no_deploy
description: installrhub merge can skip auto-deploy (no GitHub PushEvent); Claude's prod deploy is blocked, Charlotte runs one plain command
metadata:
  type: feedback
---
On 2026-10-01 PR #87 merged but GitHub emitted no PushEvent, so neither Vercel nor the Actions push run fired (#86 an hour earlier deployed fine, GitHub status green). Diagnose with `gh api repos/.../events` (look for PushEvent after the merge) and `.../deployments`.

Claude's `vercel deploy --prod` from installrhub-static was denied by the auto-mode classifier (Production Deploy), so this is the user's step.

**Why:** Charlotte found the dashboard instructions confusing ("sorry what?"); one paste-ready line worked.
**How to apply:** after every installrhub merge, verify live content changed. If no deploy appears in ~3 min, give her only: `cd ~/code/BLC/site-installrhub/installrhub-static && vercel deploy --prod --yes`, run from a clean main equal to origin/main. Related: [[feedback_prebuilt_deploy_overrides_main]], [[feedback_charlotte_plain_explanations]].

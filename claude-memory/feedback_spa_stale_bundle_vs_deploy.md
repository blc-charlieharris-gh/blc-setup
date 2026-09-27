---
name: feedback_spa_stale_bundle_vs_deploy
description: "'My merged change isn't showing' is usually a stale SPA bundle, not a failed deploy — how to confirm"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f3464756-143b-439f-9d2b-a80980932e89
  modified: 2026-08-27T12:30:49.364Z
---

When the user says a just-merged marketing-agent change still isn't visible (even "for an hour"), it is almost always the **SPA tab running the old JavaScript bundle**, not a failed deploy. React Router does client-side navigation, so clicking around in the app never reloads the code; only a **full page reload (Cmd+Shift+R)** swaps in the new bundle.

**Why:** Real production for the hub is **internal.installrhub.com** (marketing-agent.vercel.app 404s, see [[reference_internal_installrhub_is_marketing_agent]]). Vercel auto-deploys `main` in ~1-2 min.

**How to confirm deployment (don't guess):** curl the live bundle and grep for new string literals (minification keeps string literals, so they survive; local variable names like `posFrac` do NOT, so don't grep those):
```
curl -s https://internal.installrhub.com/ -o i.html
B=$(grep -oE 'assets/index-[A-Za-z0-9_-]+\.js' i.html | head -1)
curl -s "https://internal.installrhub.com/$B" | grep -c "Some New UI String"
```
If the string is present, the code IS deployed and the user is on a stale tab. Absent-because-renamed (e.g. text you removed) is also confirmation. **Fix:** hard-reload, and verify the URL isn't a pinned `-git-<branch>` preview.

**A miss in the main `index-*.js` is NOT proof of a bad deploy (2026-08-25).** Route/lazy-loaded code lives in separate chunks, and Vite/Rollup names a shared chunk after whichever of its constituent modules it picks, not after the feature you're looking for — a coverage-picker change ended up in `onboardingDraft-*.js`, not `PlacementSignup-*.js` or the main bundle, despite `PlacementSignup.jsx` importing it. Before concluding "not deployed": grep the main bundle for the chunk filenames it references (`grep -oE '"assets/[A-Za-z0-9_-]+\.js"' index.html-or-mainbundle`), then curl and grep EVERY one of them, not just the one named after the page. Also cross-check via `vercel inspect <deployment-url> --logs` (needs `vercel` CLI + scope access) for the actual git commit + build output hash — that's the ground truth when string-grepping gets confusing.

**Why it burned a session:** I kept re-checking merge status instead of checking the live bundle. Also **[[feedback_commit_via_temp_index_on_main]]**-style branch churn: pushing more commits to an already-merged branch re-triggers merge conflicts; rebase onto latest main (reset --soft origin/main + recommit) each time.

**The inverse trap (2026-08-27): checking the live bundle immediately after merging can ALSO mislead you, in the other direction.** Curled the live bundle right after confirming a PR was merged, got a bundle hash, and reported the fix as confirmed live. It was the PREVIOUS deployment — Vercel's production build was still mid-build (`vercel ls <project> --scope <scope>` showed a Production deployment with status `● Building`, ~45s old). The CDN happily served the old bundle (`x-vercel-cache: HIT`) the whole time; nothing about the curl response signals "this is stale, a newer build is coming." **Fix:** after a merge, before declaring anything live, run `vercel ls <project> --scope <scope>` and confirm the latest Production row says `● Ready`, not `● Building` — poll every ~8s if it's still building. Only THEN curl-and-diff the bundle hash against what you saw before the merge.

---
name: project-swh-golive-ranking-2026-10-11
description: "SWH go-live ranking work 10-11 (redirects, blog + town pages kept, speed 99-100, strict CSP) all merged + live; business details settled 10-12, nothing waiting on SWH"
metadata:
  node_type: memory
  type: project
  originSessionId: 85dce401-19cd-4e37-9225-3649e86474ae
  modified: 2026-10-11T18:32:19.465Z
---

SWH sent a "don't lose our Google ranking" checklist on 2026-10-11. All of it was merged and deployed to swh-electrical.vercel.app the same day.

- **Old addresses.** The 131 old WordPress addresses are listed in `_old-site-redirects.json`, the one list. `build-pages.mjs` writes it into `vercel.json` and `.htaccess`. Posts and town pages map to themselves, and only the trailing-slash form redirects.
- **Kept content.** The 69 blog posts plus `/news-insights`, and the 38 town pages, were imported by `_client/import-wp-blog.py` (WP REST, browser UA needed) into `_client/blog/*.json`. They are built at their old addresses.
- **Speed.** Mobile Lighthouse is 99–100. Two causes of the earlier `NO_LCP` were fixed: content that started at opacity 0, and snap rails that scrolled 2px on load (fixed with `scroll-padding`).
- **Scripts.** All page scripts are generated into `assets/site.js`, so the CSP's script-src is `'self'` only.
- **Fonts.** Down to 4 weights. This cleared both items deferred in [[project-swh-final-updates-2026-09-25]].
- **Business details.** The MCS (IAA10017) and TrustMark (TMRN256) numbers came from SWH's 3 Sep preview reply. SWH are not RECC or HIES members.
- **Business details settled (Charlotte 2026-10-12).** We have what we need from SWH. Don't chase them for ICO, NICEIC or NAPIT numbers, and don't list it as waiting.

**Deploy:** use `~/code/blc-setup/bin/blc-vercel deploy --prod --yes --scope blc-promotions` from a clean origin/main checkout of the folder. Plain `vercel` on this Mac is signed in to PULSET.

**Why:** they're a transfer client. Once the files move to their host, the redirects and pages must already be right.

**How to apply:**
- Any new SWH page must go through `PAGES` in `build-pages.mjs`.
- Never edit `assets/site.js`, `vercel.json` redirects or the `.htaccess` OLD SITE ADDRESSES block by hand. They are generated.
- Re-run the build twice to check it's idempotent.

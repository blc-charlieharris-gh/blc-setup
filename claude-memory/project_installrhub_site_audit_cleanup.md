---
name: installrhub-site-audit-cleanup
description: "installrhub.com audit clean-up 09-24 (PRs #72-#75), apex is now canonical, what's left on the audit is expected"
metadata:
  node_type: memory
  type: project
  originSessionId: 05b83947-3a55-475d-96c1-273eb43af7f1
  modified: 2026-09-24T17:14:04.382Z
---

installrhub.com was put through the Hub site audit for the first time on 2026-09-24 and cleaned up in site-installrhub PRs #72-#75 (all merged, live).

- **Apex is canonical now.** Vercel domains swapped by Charlotte: installrhub.com serves, www 308s to apex (was apex 307 to www). Sitemaps, canonicals and api/ fallbacks all use apex.
- /sitemap.xml is a sitemap index (sitemap-pages.xml + /insightshub/sitemap.xml). Blog URLs are /insightshub/*, /blog/* only redirects.
- Videos use a srcdoc click-to-play facade with self-hosted thumbs in images/video-thumbs/; fonts self-hosted (css/fonts.css); /cookies page + [data-cookie-settings] reopens the banner (js/consent.js).
- funnel-beacon.js + split-test.js take optional `canStore()` from split-test.config.js; InstallrHub only stores gt_vid/gt_v_*/gt_experiments after ih_cookie_consent=accepted. Green Tide copies synced in site-greentide PR #2 (open 09-24, no behaviour change there since its config has no canStore).
- Remaining audit items are expected: GHL booking iframe on /book-a-demo (kept, strictly necessary), hello@ + support@ both used (Charlotte confirmed), forms_wired/anti_spam are Web3Forms-specific false positives (forms use company_website honeypot), CSS/JS caching left short on purpose (unversioned refs), long blog titles are CMS content.

**Why:** next audit run will show the same leftovers; don't re-fix them.
**How to apply:** run the audit once per session at most, 3 back-to-back crawls got my IP a Vercel 403 challenge for ~6 min. See [[site-audit-upgrade]].

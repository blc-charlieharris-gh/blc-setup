---
name: project-renerji-reaudit
description: Renerji re-audit (09-22): client edited live site themselves, build from LIVE not our source; own Web3Forms key; LiteSpeed reads .htaccess
metadata:
  type: project
---
Renerji (hub id `renerji`, transfer client, live https://renerji.co.uk on LiteSpeed so .htaccess works).

- Our source `internal-installrhub/internal-hub/CustomSites/renerji` = renerji-ltd.vercel.app preview (Charlotte's PERSONAL Vercel scope) = OLD. Client edited live themselves: Login buttons (quote.renerji.co.uk/portal) in nav + mobile, 5-col footer with "Quote Tools", sitemap edits (incl. their "hhttps" typo + duplicate), small CSS change. 15 of 42 files differ. **Always build the fix from the live mirror, never our source.**
- Live forms use Web3Forms key e562af48-... which appears nowhere in our files (our source had BLC key f17d1e8d), so they swapped in their own. hub_clients still webform_transferred=false, end_domain null, notification_email = ours.
- Issues found: http serves unencrypted (no redirect), www duplicate, no security headers, Google Fonts @import, Spruce/EasyPV/Simplified Energy embeds load before consent (index + book-survey), PNGs 3-4 MB.
- No contact email on record, Charlotte to supply.

Related: [[project-retrofit-group]], [[feedback-audit-security-headers-attribution]]

**Progress 09-22:** working copy scratchpad rn-work (from live mirror rn-live), served on :8796 (live copy :8797). Done: self-hosted fonts, WebP images (~13 MB -> 1.1 MB), sitemap rebuilt (typo/dup/portal removed, contact added), 404, .htaccess (tested on local Apache: http+www 301, headers, 404; LIGHT CSP on purpose because quote tools pull Stripe/Maps/PostHog etc.), titles/descs, a11y (contrast via darker orange #cf4419 buttons + #b83a14 labels, template hover bug #52bdff blue fixed, footer h4->h2, skip link + main, labels, #rg-form anchor id). All pages 100/100/100 except index + book-survey (third-party tool issues only). Contact: liam@renerji.co.uk. Charlotte chose: SEND FILES (not ask them to edit). PENDING: Charlotte's answer on click-to-load consent gating for Spruce/EasyPV/Simplified Energy; then zip, hub SQL (end_domain renerji.co.uk, webform_transferred true), preview deploy (personal scope project `renerji`), re-diff live right before sending.
**Update 09-22 later:** Charlotte chose LEAVE quote tools ungated (don't risk breaking). Spruce iframe now data-lazy-src + IntersectionObserver in main.js (homepage PSI was 27 from Spruce's 5 MB). CSP upgraded to scheme-based default-src (see headers feedback). EasyPV injector script in <head> is a harmless LEFTOVER: easy-pv.co.uk rejects origin renerji.co.uk (CORS 401) but nothing visible uses it (solar tool = Simplified Energy, heat pump = Spruce). Charlotte: IGNORE it, don't mention to client, don't call it 'broken'. Zip rebuilt 10:23.

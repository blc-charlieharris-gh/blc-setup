# Handoff, 2026-10-22 (php2shell security cleanup, session blc-76)

## What we worked on
- Serafim asked where we're exposed to php2shell (PHP CVE-2026-109618 / 109619, disclosed 21 Oct, unauthenticated takeover).
- Checked every repo, all 21 Vercel projects and every Cloudflare domain. Our app, Hub and sites have no PHP.
- Found old GHL WordPress hosting (`*.wpdns.site`) still running about 12 sites. 11 deleted in GHL, BLC sub-account WordPress cancelled.
- New Vercel project `blc-promotions/blcpromotions` (folder `site-blcpromotions/`, copy of `site-installrhub/installrhub-static/blcpromotions/index.html`) now serves blc-promotions.com and blcpromotions.co.uk (+ www). IONOS DNS done and verified.
- `apply.home-upgrades.co` and `eco-grants.org` (+ www) now 308 to greentideenergy.com (Vercel domain redirect on the `greentide` project, no code).
- About 130 dead DNS records deleted across blc-promotions.com, eco-grants.org and home-upgrades.co.
- Retrofit emailed by Charlotte (Namesco host has PHP-FPM on; our static site is fine).

## Current state
Done and checked live. Charlotte is deleting the leadgenmastery.co.uk WordPress site in GHL now; the domain stays (no traffic).

## Next steps
1. Check `jf2n5ejoec.wpdns.site` / leadgenmastery.co.uk stops answering once deleted.
2. Check IONOS and GoDaddy hosting sections for any PHP web-hosting packages; cancel if found.
3. Optional DNS tidy: greentideenergy.com old Microsoft 365 / GoDaddy webmail records; Mailgun records once off GHL.

## Decisions and open questions
- Cold-email records on blc-promotions.com (Mailgun `replies`, Mailrush `mx674`) kept by choice.
- Arktek/Renerji: low risk (host doesn't route to PHP). Harvard/Core/SWH old sites replaced by new builds.

## Working tree and other sessions
- `site-blcpromotions/` is live on Vercel. Copy saved to git as `blcpromotions-site/` in site-installrhub (in `.vercelignore`), PR from branch `chore/blcpromotions-site-1022`, Charlotte merges: https://github.com/blc-charlieharris-gh/site-installrhub/pull/new/chore/blcpromotions-site-1022
- Retrofit draft, Cloudflare export and DNS keep list deleted at Charlotte's request. Lead Gen Mastery WordPress deleted and verified off.
- blc-47 and blc-27 running; their files not touched.

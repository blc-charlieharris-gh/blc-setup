---
name: project-php2shell-cleanup-1022
description: "php2shell (PHP RCE, Oct 2026) response: our stack has no PHP; old wpdns.site WordPress host + DNS cleanup status, IONOS + host deletion + Retrofit email pending"
metadata:
  node_type: memory
  type: project
  originSessionId: 49fe163b-d05d-470d-8dc3-c8b35c7b7c34
  modified: 2026-10-22T12:25:51.954Z
---

php2shell (CVE-2026-109618/109619, disclosed 2026-10-21, Serafim asked 10-22). Our app/Hub/Vercel sites have no PHP.

Done 10-22: blc-promotions.com + www -> new Vercel project blc-promotions/blcpromotions (folder site-blcpromotions/, copy of installrhub-static/blcpromotions one-pager). apply.home-upgrades.co + eco-grants.org/www -> greentide project, 308 to greentideenergy.com (Vercel domain redirect, no code). ~130 dead client subdomains deleted across blc-promotions.com, eco-grants.org, home-upgrades.co (all Cloudflare). Kept cold-email records (Mailgun replies, mx674 Mailrush) by choice.

wpdns.site = GHL's WordPress hosting. 10-22: BLC sub-account WP cancelled, 11 old WP sites deleted across sub-accounts (all verified off). leadgenmastery.co.uk (GHL WP, GoDaddy DNS) still live, awaiting her call.

Also checked clean 10-22: all 21 Vercel projects, greentideenergy.com zone, all 4 installrhub domains (installrhub.com zone has no PHP/WP records). Retrofit emailed (Cammi, sent manually 10-22). blcpromotions.co.uk IONOS DNS done + verified 10-22. leadgenmastery.co.uk WP deleted + verified off 10-22, domain kept (no traffic). php2shell cleanup COMPLETE except optional IONOS/GoDaddy hosting-package check. Cloudflare export + Retrofit draft deleted 10-22, and check IONOS/GoDaddy hosting sections for any PHP hosting packages.

Pending (older note): blcpromotions.co.uk DNS at IONOS (boss has access): A @ 216.150.1.1, www CNAME ac0199cbcfb6ff85.vercel-dns-016.com. Old WordPress hosting account (all *.wpdns.site, ~11 sites still running incl. old blcpromotions, apply.home-upgrades, eco-grants, renerji, national-eco-solar) must be deleted/cancelled: DNS removal only hides them. Retrofit (Namesco host, PHP-FPM on) = email client last; Arktek/Renerji low risk.

**Why:** DNS removal doesn't stop PHP on the host. **How to apply:** next session, check IONOS change landed, then chase host deletion.

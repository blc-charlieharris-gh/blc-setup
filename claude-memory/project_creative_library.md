---
name: project_creative_library
description: "InstallrHub Creative Library pitch deck (interactive single-HTML sales deck), LIVE at portfolio.installrhub.com"
metadata: 
  node_type: memory
  type: project
  originSessionId: 4ae3f812-5519-48ce-9765-8ea1445f0e38
---

Interactive single-file pitch deck used on installer demo/sales calls. Sells InstallrHub's done-for-you lead-gen (solar + heat pump). Light theme matching installrhub.com brand, click-to-build reveals, animated CSS mockups, real blended/anonymised performance data (no account names), real ad thumbnails + compressed videos, 26 real client logos in an About-page ticker, 6 YouTube case-study testimonials.

- **Source:** `site-installrhub/creative-library/index.html` (vanilla JS/CSS, no build step). Its OWN git repo `blc-charlieharris-gh/installrhub-creative-library` (NOT inside installrhub-static). Assets in `thumbs/ statics/ videos/ testing/ client-logos/`; `videos/_orig/` is gitignored AND `.vercelignore`'d (keep heavy originals out of deploys).
- **LIVE:** https://portfolio.installrhub.com (cutover done 2026-06-23, verified HTTP 200 + SSL).
- **Hosting:** Vercel project `blc-promotions/installrhub-portfolio` (projectId prj_U6QmiOw8DU99IPQJ5dadHmjF0xxx), GitHub-connected, so a push to repo `main` auto-deploys. No build (static). Deployment Protection is OFF (must stay off for public access).
- **DNS:** installrhub.com is on Cloudflare. Record: CNAME `portfolio` -> `cname.vercel-dns.com`, Proxy = DNS only (grey cloud). Other installrhub subdomains (www, app, website) are separate Vercel projects in the same team; see [[reference_installrhub_domains]] and [[reference_vercel_domains]].

**Gotchas learned during go-live:** a Vercel project serves ONE site, so the deck needed its OWN project (do not point portfolio.* at `installrhub-site`, that serves www). New Vercel projects default to Deployment Protection ON (SSO login wall) which 302s the prod URL to a Vercel login. The CLI can deploy/attach domains but the safety classifier blocks destructive shared-infra moves (domain force-move, rm) and there is NO CLI for the protection toggle, so those steps go via the dashboard/user. Google Trends figures on the "We know ads" slide are illustrative (not in Supabase).

---
name: reference-installrhub-site-deploy-and-verify
description: installrhub.com merges usually auto-deploy but #108 didn't; Vercel bot checkpoint blocks curl + headless Chrome, so Charlotte verifies pages in her browser
metadata:
  type: reference
---

site-installrhub (repo installrhub-static, Vercel project blc-promotions/installrhub-site):
- After merging, check `vercel ls installrhub-site --scope blc-promotions` for a new Production row. On 3 Oct 2026 PR #108's merge produced none (#109's did, within seconds). Fix: on clean, up-to-date main run `vercel deploy --prod --yes --scope blc-promotions`, then `vercel inspect installrhub.com` to confirm the alias.
- installrhub.com sits behind a Vercel Security Checkpoint for non-browser traffic: curl (even with a browser UA) and headless Chrome get a 403 challenge page, including /api/*. Live checks of pages need Charlotte's browser; API status codes from a headless page context still show 403 for the checkpoint, not the app.
- 10-08: www.installrhub.com only redirects to installrhub.com, so `curl -s https://www.installrhub.com/...` returns the redirect body and a grep finds nothing (looked like "not live"). Use `curl -sL` or the bare domain; on 10-08 the checkpoint did not block curl -sL for /js and /webinar/replay.
- Branch previews are behind Vercel SSO, see [[reference-installrhub-preview-sso]].

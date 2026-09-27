---
name: project_careers_pixel_and_job_deeplink
description: "site-installrhub careers page has a second, page-scoped Meta Pixel and a ?job= deep-link to open a specific role's form"
metadata: 
  node_type: memory
  type: project
  originSessionId: 586366cb-84b7-44c1-b4b5-02d014c77429
  modified: 2026-08-18T14:58:17.085Z
---

`site-installrhub/installrhub-static/js/consent.js` now carries TWO Meta Pixels: the site-wide `6022454534459147` (fires on every page) and a careers-only `4001437520152330` (fires only where `window.IH_JOBS_PIXEL` is set, currently `careers/index.html` and `careers/thank-you/index.html`). The jobs pixel uses `fbq('trackSingle', ...)` so it never double-fires the main pixel.

`careers/index.html` also supports `?job=<slug>` to deep-link straight to one job's expanded card + inline apply form (e.g. `?job=client-success-marketing-manager`), landing scroll at the card top (title/description) rather than jumping to the form. Works for any job added via the existing `/add-job` command since it reuses that command's `job-<slug>` / `job-body-<slug>` / `job-form-<slug>` id convention.

**Why:** boss wanted a custom conversion tracked on job applications separately from the main site pixel, and a direct ad link into a specific role's form without a manual click.

**How to apply:** for the custom conversion, it's a URL-rule based on the jobs pixel's `PageView` + URL contains `/careers/thank-you`, no code needed. If adding a third page that should carry the jobs pixel, just set `window.IH_JOBS_PIXEL = true` in its `<head>`, same pattern as `IH_TRACK_LEAD`. Repo is `installrhub-static/` (see [[reference_installrhub_git]]), deploy is `vercel --prod --scope blc-promotions` then `vercel alias set <deployment-url> installrhub.com --scope blc-promotions`, changes do not go live on push alone.

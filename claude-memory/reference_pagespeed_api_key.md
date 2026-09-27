---
name: reference-pagespeed-api-key
description: "PAGESPEED_API_KEY is set in the marketing-agent Vercel production env (2026-09-21); the site audit's Lighthouse checks depend on it"
metadata:
  type: reference
---

Charlotte created a Google PageSpeed Insights API key on 2026-09-21. It is stored as `PAGESPEED_API_KEY` (Production, encrypted) on the `marketing-agent` Vercel project (scope blc-promotions); the value is not recorded here. `api/site-audit.js` uses it for the four Lighthouse checks. If Lighthouse checks come back "manual" with a quota or key error, check this env var first. See [[project_site_audit_upgrade]].

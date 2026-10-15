---
name: reference-client-preview-vercel-address
description: Client preview sites get a clean <name>.vercel.app via vercel domains add from the linked folder; vercel alias set lands behind Vercel SSO
metadata:
  node_type: memory
  type: reference
  originSessionId: 9b517cff-3cc4-4bdb-9b34-a250456a2d0e
  modified: 2026-10-15T13:12:11.917Z
---

New client preview site (blc-promotions team): from the client folder, `vercel link --yes --project <name> --scope blc-promotions`, then `vercel domains add <name>.vercel.app --scope blc-promotions` (single argument, linked project) and `vercel deploy --prod`. A project domain added this way is public. `vercel alias set <deployment> <name>.vercel.app` instead puts the address behind Vercel SSO (302 to vercel.com/sso-api), so clients can't open it. If the bare name is taken Vercel adds a random word (elect-lilac); Charlotte wants a clean name like elect-energy.

Previews stay out of Google with an X-Robots-Tag noindex header in the site's vercel.json for `*.vercel.app` hosts (Elect build-pages.mjs writes it). Related: [[reference-client-site-vercel-deploy]]

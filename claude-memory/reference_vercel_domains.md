---
name: ClientSiteGenerator Vercel production domains
description: Production domain names, scope, and fix procedure when domains get pinned to old deployments
type: reference
originSessionId: b17d1a4c-edf5-46c2-a208-76c5ac1bff75
---
Project: `client-site-generator` under Vercel scope `blc-promotions`

Production domains:
- `internal.installrhub.com` (the generator tool BLC uses)
- `website.installrhub.com` (client-facing: intake, signoff, and redirect URLs for clients)

CRITICAL: Both domains belong to `client-site-generator` ONLY. Never alias either to `installrhub-site`. The public blog is at `installrhub.com/blog` and is served by `installrhub-site`.

When these get pinned to an old deployment (symptom: GitHub code is correct, deployments show Ready, but live site serves old code), fix with:

```
npx vercel ls  # find the latest Ready deployment URL
npx vercel alias set <latest-url> internal.installrhub.com --scope blc-promotions
npx vercel alias set <latest-url> website.installrhub.com --scope blc-promotions
```

**Why:** manual `vercel alias` calls override Vercel project domain settings and pin to a specific deployment hash. This has happened multiple times. The CLAUDE.md in the project has been updated with this procedure.

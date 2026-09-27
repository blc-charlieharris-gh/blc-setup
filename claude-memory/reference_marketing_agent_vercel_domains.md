---
name: reference_marketing_agent_vercel_domains
description: "marketing-agent's real production Vercel aliases (CLAUDE.md's marketing-agent.vercel.app 404s); possible domain overlap with client-site-generator on internal.installrhub.com"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 629249a7-7cfd-45bf-aa95-5a3d20892223
  modified: 2026-08-23T11:59:42.225Z
---

Project: `marketing-agent` (Vercel scope `blc-promotions`, project id `prj_nBnk5kEIyAygAJtmiNkTaE9ogDr2`).

marketing-agent's own `CLAUDE.md` states production is at `marketing-agent.vercel.app` — that 404s.
Verified live via `npx vercel inspect <latest-production-deployment-url> --scope blc-promotions`
(2026-08-23), the real production aliases are:
- `internal.installrhub.com`
- `crew.installrhub.com`
- `website.installrhub.com`
- `marketing-agent-khaki.vercel.app`

**Possible conflict, not confirmed:** [[reference_vercel_domains]] (a separate memory) says
`internal.installrhub.com` and `website.installrhub.com` belong EXCLUSIVELY to a different Vercel
project, `client-site-generator`, and warns "CRITICAL: never alias to `installrhub-site`, this has
happened multiple times". Both of those exact domains are now aliased to marketing-agent's latest
production deployment instead. This may be a deliberate result of the "Hub merge" mentioned in
marketing-agent's `CLAUDE.md` (marketing-agent absorbing functionality previously served by
`client-site-generator`) — plausible since marketing-agent's own email templates already reference
`internal.installrhub.com` as their asset host. But nobody has confirmed this was deliberate rather
than two projects racing for the same domain. Worth settling with Serafim before trusting either
memory blindly; whichever project deployed most recently is currently winning the alias.

---
name: feedback-vercel-cleanurls-breaks-custom-rewrite
description: "vercel.json cleanUrls:true can silently break a custom rewrite for \"/\" (homepage 404, edge-cached); use explicit rewrites+redirects instead"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: b8a0b3af-bca4-4fcc-bf36-47871812540c
  modified: 2026-09-04T13:00:52.857Z
---

Don't use `"cleanUrls": true` in a `vercel.json` that also has a custom rewrite for `/` to a non-index file (e.g. `{"source":"/","destination":"/template.html"}` on a static site with no `index.html`). The two interact badly (undocumented), and the homepage can start 404ing, serving `404.html`'s content with a genuine 404 status, cached at the edge (`x-vercel-cache: HIT`), so it looks fine to a shallow check but is actually broken for every real visitor.

**Why:** hit this live in production on [[project_swh_legal_compliance_cleanup]]. A first deploy with `cleanUrls:true` broke swh-electrical.vercel.app's homepage; a curl-based spot check that only grepped for page CONTENT (not status code) missed it, the user caught it, not the verification.

**How to apply:** for a static/hand-built site (website-factory client sites, or anything similar) that needs extensionless URLs, write explicit `rewrites` (serve `X.html` at `/X`) and `redirects` (308 `/X.html` → `/X`) per page instead of the `cleanUrls` shortcut. More verbose, but predictable, and doesn't fight a custom homepage rewrite. Also: after any routing change on a live site, verify the ACTUAL HTTP status code of `/` (`curl -o /dev/null -w '%{http_code}'`), not just that some expected text appears in the body, a 404 page can still contain expected-looking boilerplate.

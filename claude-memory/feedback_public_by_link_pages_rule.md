---
name: feedback_public_by_link_pages_rule
description: Event pages (webinar slides) may be public-by-link; anything with client/lead/money data may not; Hub public/ files bypass login
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6c55e0d6-ba87-41a2-97b6-bcdbcd30f8c6
  modified: 2026-10-04T15:51:56.560Z
---

Charlotte 2026-10-04: event pages like the webinar slides are fine to be public by link (unlisted, noindex). Anything showing client, lead or money data must not be. Hub app routes are login-gated (AuthGuard + RLS), but files in marketing-agent `public/` (`/subscriptionmodel`, `/sitescore/<client>`, `/present/<deck>`) open for anyone with the link.

**Why:** she asked for the webinar deck on internal.installrhub.com and said it being public is actually better (team opens it from Events > Presentation slides with no login). She wants the audit to review the security of all no-login pages at the right stage.

**How to apply:** host decks and event material under marketing-agent `public/present/` (built by site-installrhub `webinar-deck/build.py --publish`). Don't propose login-gating for event pages. The review of every no-login page is logged in the Hub audit README (Cross-page findings, SECURITY 10-04, at Global #26). Related: [[project_hub_page_audit]], [[feedback_public_client_link_needs_crosshost_route]]

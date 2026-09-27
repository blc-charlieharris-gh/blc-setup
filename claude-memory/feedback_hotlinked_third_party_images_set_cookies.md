---
name: feedback-hotlinked-third-party-images-set-cookies
description: Partner banners/images hotlinked on client sites can set cookies with no consent (Phoenix set 30-year cfid/cftoken); curl -I first, self-host if so
metadata:
  type: feedback
---

Before hotlinking a partner's image on a client site (finance banners, badges, widgets), run `curl -sI <url>` and look for Set-Cookie. Phoenix Financial Consultants' banner PNG set 30-year cfid/cftoken cookies (2026-09-25, SWH). Loading it would have fired third-party cookies before consent. So we saved a local copy (assets/phoenix-finance-banner.webp) and kept the click-through link to their calculator.

**Why:** the sites promise "nothing third-party before consent", and the audit only checks markup, so a hotlinked image that sets cookies slips past it.

**How to apply:** self-host the image, link out to the partner, and note in the build where to re-download it if the partner changes it (rates, branding). Related: [[project-swh-final-updates-2026-09-25]].

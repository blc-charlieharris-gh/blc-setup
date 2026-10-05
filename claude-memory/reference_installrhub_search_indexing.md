---
name: reference_installrhub_search_indexing
description: What may appear on Google for installrhub.com and the Hub, and where that is set (meta robots, vercel.json X-Robots-Tag, sitemap)
metadata:
  type: reference
---

Set 2026-10-05 after Charlotte found Hub, privacy and thank-you pages on Google.
- installrhub.com indexed on purpose: /, /webinar, /forecast, /book-discovery, /careers, /contact, /insightshub, /blcpromotions (kept for searches on the old BLC Promotions name). Only these are in sitemap-pages.xml.
- Everything else has `noindex` in its meta robots, and site `vercel.json` adds `X-Robots-Tag: noindex` by path (thank-you, booking, MOT, forecast/reveal, breakdown, sitescore, portfolio, watch, website-offer, privacy/terms/cookies, webinar/replay). installrhub-site.vercel.app sends noindex, nofollow (host rule). New private pages: add the meta tag AND the path to that rule.
- marketing-agent (internal., crew., website.installrhub.com): `X-Robots-Tag: noindex, nofollow` on every response in its vercel.json, plus public/robots.txt (Allow, so crawlers see the noindex).

**How to apply:** removal from Google is gradual; Search Console Removals is the fast route. Related: [[reference_marketing_agent_vercel_domains]]

---
name: feedback_audit_crawl_asset_extension_filter
description: "site-audit's internal-link crawl should exclude by known asset extension, not require .html — a fixed page-extension requirement silently drops real pages on any clean-URL site"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 4e7a3e61-f8cb-45ac-b9a0-c3d4fcccbd9a
  modified: 2026-09-01T14:01:43.448Z
---

`api/site-audit.js`'s bounded crawl (`MAX_CRAWL`) collects internal `href=` matches to check for broken links, legal pages, and (added 2026-09-01) which pages have a wired form. The regex matches every `href=` in the document, not just `<a>` nav links, so `<link>` tags (favicon, CSS) count toward the cap too. On Arktek this meant 2 asset hrefs plus a 5-item Services dropdown ate the entire 10-link budget before Contact or Get-a-Quote (both real pages) were ever reached.

First fix attempt: require the pathname to end in `.html`/`.htm` or `/` before counting it as a "page". This worked for Arktek's original `.html`-suffixed URLs, but broke the moment the same site's URLs were migrated to clean/extension-less paths (`/contact` instead of `/contact.html`) — a genuine page with no extension no longer matched the filter and silently vanished from the crawl again, same bug, different cause.

**Correct fix:** exclude by known ASSET extension (`.css|.js|.svg|.png|.jpe?g|.webp|.gif|.ico|.woff2?|.xml|.json|.pdf|...`) rather than requiring a page-like one. A page might have any extension or none; an asset almost always has a recognizable one. Also raised `MAX_CRAWL` from 10 to 25 — a real client site (Arktek: 15 real pages) can exceed 10 easily once assets stop consuming slots.

**How to apply:** whenever touching internal-link discovery/crawling logic on ANY site, default to an exclusion filter over an inclusion filter for "is this a real page" — inclusion lists (extension whitelists, path-pattern whitelists) break the instant the site's own conventions don't match what you assumed while writing the filter.

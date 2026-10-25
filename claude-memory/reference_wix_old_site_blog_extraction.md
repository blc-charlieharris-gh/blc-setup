---
name: reference-wix-old-site-blog-extraction
description: "How to copy a client's old Wix blog posts word for word, and which Wix pictures can't be reused"
metadata:
  node_type: memory
  type: reference
  originSessionId: ac067d84-b19c-4082-ab20-706e0779fdb5
  modified: 2026-10-24T20:30:58.834Z
---

Old Wix sites (e.g. helix50.co.uk, 2026-10-24): each /post/ page has the body inside `data-hook="post-description"` up to `</article>`, and a BlogPosting JSON-LD block with `datePublished`. Pictures are `static.wixstatic.com/media/<id>`; the original is that URL without the `/v1/...` part. A "Tags:" paragraph and list at the end is Wix chrome, not post text.

Media id prefix tells the source: the client's own uploads share one prefix (Helix: `c699a1_`); `11062b_` is Wix's own stock (licensed for Wix sites only, drop it); `nsplsh_` is Unsplash; other prefixes are not the client's uploads, so ask about rights.

Old posts often carry dead contact details, expired grant figures or copied text: read every post before publishing (INSTRUCTIONS "their blog comes across" rule) and redirect left-out ones to the closest kept page.

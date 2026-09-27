---
name: feedback_confirm_which_page_before_implementing
description: "When multiple related pages are in flight (e.g. a new landing page + the existing homepage), don't assume which page a terse UI instruction applies to"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e1d1c92c-a0bf-4805-8536-1cd9ac98343d
  modified: 2026-09-04T16:13:38.033Z
---

Building [[project_gasworx_energy_savings_landing]], Charlotte gave a promo-banner instruction
("Free tool: upload your bill... Get My Free Report →, as a much better looking strip under the
hero") while we were deep in landing-page work, and I put it under the landing page's own hero. She
had to correct it: "does not go on the landing page, it needs to go on the HOMEPAGE" — it was meant
to cross-promote the new tool FROM the existing homepage, not live on the page it promotes. Same
session, a similar back-and-forth happened over hero CTA count/labels and phone-number display,
each requiring a redo.

**Why:** a short instruction like "add X under the hero" reads as page-agnostic, but when two
related-but-distinct pages exist (a new ad landing page vs. the site's real homepage), "the hero"
and "the landing page" are not interchangeable, and the correct target is often the OTHER page from
the one currently open in the conversation, especially for cross-promotional content driving traffic
between them.

**How to apply:** when a UI/copy instruction doesn't name a page explicitly and more than one
plausible target page exists in the current task, either ask which page, or reason explicitly about
which page the *stated purpose* of the content implies (a banner that drives traffic to a landing
page belongs on the page traffic is coming FROM, not the destination) before implementing — don't
default to "whichever file I already have open."

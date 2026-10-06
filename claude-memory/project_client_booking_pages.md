---
name: project-client-booking-pages
description: "installrhub.com /catch-up (Brad) and /access-call (Charlotte) client booking pages, live 2026-10-06; open to anyone without a link"
metadata:
  node_type: memory
  type: project
  originSessionId: 4148eff6-2934-4b6c-b325-0d0e39218aba
  modified: 2026-10-06T08:26:06.492Z
---

Live 2026-10-06 (site-installrhub #174, #175): /catch-up books the client calendar 6ggFBGtzBNRH7ctKmw1l (same as /client-mot), /access-call books zmZLaMrgLn9ywp9w5gdA (Facebook or Google ad-account access). Script js/client-booking.js (own file, not js/booking.js); api/book.js CALENDARS `catchup` / `access` with `open: true`. Links: installrhub.com/catch-up?cid={{contact.id}}, /access-call?cid={{contact.id}}.

With a client's cid: books onto that contact. Without (or not a client): name + email, books onto the GHL contact with that email untouched, else upserts a new one (source "Client catch-up booking" / "Access call booking", no tags). /client-mot stays clients-only.

**Why:** Charlotte 2026-10-06: "would still let them book, worst case it's a dupe contact and Brad can merge in GHL manually". The GHL installr workflow that feeds Hub leads is tag-triggered (Charlotte confirmed), so untagged contacts aren't counted as leads.
**How to apply:** don't add tags or n8n to these bookings, or they become leads. The Hub (blc-b5's side) links to these from the link list, Clients Shown broadcast, client report and the access request email. Related: [[reference_client_mot_link]], [[feedback_installrhub_signup_vs_lead_rule]]

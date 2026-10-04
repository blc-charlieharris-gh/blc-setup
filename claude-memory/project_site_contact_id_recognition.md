---
name: project-site-contact-id-recognition
description: installrhub.com recognises Hub email links (?cid=) site-wide since 4 Oct 2026; n8n bodies keep first-touch via the Existing contact flag
metadata:
  type: project
---

Live 4 Oct 2026 (site #119–124). Hub emails put `?cid={{contact_id}}` on links, and /go/ short links forward cid + book=demo. js/track.js keeps the cid for the visit, looks it up once via `/api/book?contact=`, and prefills every form. Booking pages ask only what's unknown, and bookings land on that contact. Every form payload to n8n carries `GHL contact id` (only when recognised with the same email) and `Existing contact` yes/no (GHL duplicate check by email).

Charlotte's rules: a contact's source and first-touch tracking never change once set; leads are never double counted; blanks never wipe GHL values.

n8n: she pasted new upsert bodies into MOT, Resources, Homepage, Contact, Forecast and Webinar. They key off `Existing contact` and skip blanks. Instant-form flows (e.g. "Instant form - DTO offer campaign") and website offer were deliberately left alone: adding nodes was too risky, and marketing-agent handles it when n8n is replaced.

Knock-on handed to marketing-agent: `isSignupIntake()` reads contactSource, which is now first-touch, so it should classify on Converted Page.

**Why:** duplicates and overwritten sources were losing attribution.
**How to apply:** new site forms must call ihTrack.prefill and send cid. Never add risky n8n nodes; propose paste-only changes. Related: [[reference-ghl-booking-token-custom-fields]], [[feedback-n8n-paste-expressions]].

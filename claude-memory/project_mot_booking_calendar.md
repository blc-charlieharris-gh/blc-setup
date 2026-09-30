---
name: project-mot-booking-calendar
description: "Installer MOT custom booking flow (PR #85, 09-30) replaces GHL iframe; inert until GHL_BOOKING_TOKEN is set in Vercel, never test-booked"
metadata:
  node_type: memory
  type: project
  originSessionId: db777652-e6ad-4267-ab01-9e5bcbeac4bc
  modified: 2026-09-30T20:36:43.896Z
---

30 Sep 2026: /installer-mot results page got our own booking flow (api/book.js + "5. Booking" in js/mot.js), styled as three more quiz questions. PR #85; Charlotte merges (Claude's merge is blocked).

**Why:** Charlotte wanted the calendar to look like ours while GHL still holds availability and bookings. She turned down strip/month/week/dark-steps layouts and chose the quiz style. Main Service + Installs are not re-asked (quiz already has them).

**How to apply:** it stays on the GHL widget until `GHL_BOOKING_TOKEN` (Private Integration: calendars read, events write, contacts write) is in Vercel installrhub-site; `?cal=new` previews. The GHL custom field ids in FIELD_IDS were read off the live widget form, so the first real booking must confirm they land. See docs/current-handoff.md in installrhub-static.

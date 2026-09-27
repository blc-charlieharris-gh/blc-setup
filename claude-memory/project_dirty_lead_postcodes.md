---
name: project-dirty-lead-postcodes
description: "Lead postcodes are dirty free-text (US zips, phone numbers, junk) — needs intake-form validation/cleanup"
metadata: 
  node_type: memory
  type: project
  originSessionId: dc1469d2-bede-46dc-b266-8718f0dfa3c5
---

`lead_intake_events.postcode` is free text from the Meta lead forms, so a chunk of values are junk: US zips ("16046", "22101"), phone numbers, placeholders ("88888", "77777"), full addresses, partial postcodes. Surfaced 2026-06-03 while building the Targeting map (the geocoder silently drops the unmappable ones, so the map is fine, but it's noise and means some real UK leads with malformed entries don't plot).

**DECIDED 2026-06-04: leave it / do not pursue.** Charlie's call: if the values are unreadable (US zips, phone numbers, placeholders) we can't recover them, so a cleanup of existing rows is pointless, and intake-validation is deprioritised. Do not re-raise unless Charlie reopens it. The geocoder already drops unmappable values silently, so the Targeting map is unaffected. Related: [[project-installrhub]], the Targeting feature (PR #19).

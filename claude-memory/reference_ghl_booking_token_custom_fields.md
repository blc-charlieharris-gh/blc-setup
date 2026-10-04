---
name: reference-ghl-booking-token-custom-fields
description: installrhub.com's GHL booking token can't list custom fields; write custom fields by key, reading one needs its id
metadata:
  type: reference
---

The site's GHL token (GHL_BOOKING_TOKEN, api/_ghl.js) does not have the customFields list scope: `GET /locations/{id}/customFields` fails, so `api/_known.js fieldIds()` returns an empty map. Found 4 Oct 2026 when the 6 booking_* fields came back empty on a live test.

- **Writing works by key:** `customFields: [{ key: 'booking_page_url', field_value }]` on upsert/PUT, the same way the n8n flows write (`"key": "installs_per_month"`). api/book.js does this since #123, retrying with id-only fields if GHL refuses.
- **Reading by key is impossible:** `GET /contacts/{id}` returns customFields as `{id, value}` only. So the site can't read `mcsstatus` for a recognised contact (it asks MCS again). The fix is the `GHL_FIELD_IDS='{"mcsstatus":"<id>"}'` env override, or adding the scope.
- Fields with known ids (company_name, main_service, installs_per_month, utm_*, ih_*) are hard-coded in api/book.js FIELD_IDS.

Related: [[project-site-contact-id-recognition]], [[feedback-ghl-custom-field-title-case-keys]].

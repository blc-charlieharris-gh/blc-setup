---
name: reference_installrhub_n8n_payload_fields
description: installrhub.com form payload names per n8n branch, GHL custom field keys (mcsstatus), source line; breakdown name bug fixed 10-01
metadata:
  type: reference
---
installrhub.com forms post flat JSON to n8n (api/contact.js + api/_forms.js `fields` map; forecast via api/lead.js). n8n builds the GHL contact upsert (locationId hnkWBrlwiI4ZPlquJYDl). Field names differ per form:
- homepage + /not-a-fit: `First name`, `Last name`, `Company name`, `Email`, `Phone`, `Installs`, `Service` (a code: heat/solar/both)
- webinar, breakdown (resources), MOT: single `Name` (split in n8n with `($json.body.Name || '').split(' ')`), `Company name`
- contact page: `Name`, `Phone number`, `Company`, `Message`
- every form: `source` = form key (map to GHL top-level `source` = contact source), flat utm_*, ih_channel, ih_place, ih_landing, fbclid, page
- `MCS status` on webinar/homepage/forecast/breakdown (+ MOT from 2026-10-07); GHL custom field key is `mcsstatus` (field name "mcs-status")

Found 2026-10-01: breakdown branch read First/Last name, so breakdown leads landed nameless since Aug; several branches hard-coded `fbclid` to "" and set no `source`. Charlotte pastes branch bodies to check. Related: [[reference_installer_lead_flow_and_mailing_list]], [[reference_installrhub_track_js_attribution]].

Audit 2026-10-19 (Charlotte pasted every body): each form has its OWN n8n flow, so a field the site starts sending reaches GHL only once that flow's body maps it. MOT had no phone or mcsstatus mapping (fixed). Every flow except DTO and Live Q&A guards source/UTMs with `b['Existing contact'] !== 'yes'`; DTO gets that flag from meta-lead-webhook v49 (GHL lookup, installer_recruitment routes) since 10-19. GHL keys added: `bottleneck` (breakdown "Biggest issue"), `event_question` (Live Q&A). Event tags are typed per flow (webinar-oct2026, webinar-replay, webinar-missed, qa-oct26-registered): change when duplicating for the next webinar. GHL also matches new sign-ups to an existing contact by PHONE, so a signer can sit in mailing_contacts under an older email: check by sales_lead_intake_events contact id before calling them missing.

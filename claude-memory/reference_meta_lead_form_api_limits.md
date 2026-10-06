---
name: reference-meta-lead-form-api-limits
description: "Meta instant forms by API: can set privacy, submit end page, SMS verify; can't do disqualify logic, rename, or edit after publish; archived names stay reserved"
metadata:
  type: reference
---

Learned 2026-10-06 building the Green Tide AS01 form (meta-access):
- POST /{page}/leadgen_forms with the PAGE token accepts privacy_policy {url, link_text}, question_page_custom_headline, thank_you_page {title, body, button_type VIEW_WEBSITE, button_text, website_url}, is_optimized_for_quality, block_display_for_non_targeted_viewer and is_phone_sms_verify_enabled (accepted, but the field can't be read back).
- Branching / disqualify logic and the disqualify end page are Ads Manager only: they can't be set or read by API. Charlotte duplicates the API-built form, adds the logic and publishes, then `clone_campaign.py swapform` moves the ads.
- A published form can't be edited. Renaming by API returns success but does nothing. Archiving (status ARCHIVED) works, but the archived form's name stays reserved (subcode 1892019 "Form Name exists").
- Ad-level "Website events" = ad tracking_specs `{"action.type":["offsite_conversion"],"fb_pixel":["<pixel>"]}`. Green Tide's live pixel is 2551121045236896. Ad writes are limited to 1 per 30s per ad (#613). "CRM events" isn't visible by API.

Related: [[reference-meta-clone-campaign-skill]], [[feedback_meta_targeting_write_rate_limit]].

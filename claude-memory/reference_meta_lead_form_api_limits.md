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

2026-10-14 re-checked on v21 and v24: no logic field exists to read or write (logic, conditional_logic, end_pages, disqualify_page etc. all #100 nonexisting). To tell if a form has logic, look at its leads in meta_lead_events.raw->field_data: any "tenant" / "only if free" answer = no logic. Elect V3 had none (2 tenants, 6 free-only); fixed as V4 + swapform. Ads Manager "Edit" on a published form makes a NEW form with the same name and renames the old one "<name> (v1)" (Gas Worx 14/10), so the new id still needs a Hub route + swapform. Ads built in Ads Manager also hold the form id in object_story_spec link_data/video_data call_to_action, which swapform now updates. Best flow: Charlotte builds the form in the Page's Instant Forms library (not inside an ad, which hits the home-only ad set publish error #1870194), then I swapform.

Related: [[reference-meta-clone-campaign-skill]], [[feedback_meta_targeting_write_rate_limit]].

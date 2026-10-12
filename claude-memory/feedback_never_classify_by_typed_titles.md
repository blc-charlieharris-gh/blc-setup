---
name: feedback-never-classify-by-typed-titles
description: "Never sort or count leads/campaigns by free-text names (GHL contact_source, form names, ad names); use structured ids (Meta ad id, site form log, form key)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6a33dffe-7abe-450c-b4b9-bfc677a26314
  modified: 2026-10-09T13:20:12.200Z
---

Charlotte 2026-10-09 (repeating an earlier rule): "don't use manually written titles for anything, it's not trustworthy." Status Lead flow filed Gas Worx and SWH instant-form leads as "landing pages" because the GHL contact Source text said "Manual Check ECO4 Fillout" (leadFlow.js LANDING_SRC = /landing|forecast|fillout/ on contact_source). She doesn't use Fillout at all.

**Why:** typed titles get renamed, copied and reused, so any rule built on them silently miscounts.
**How to apply:** classify by structured data only:
- an instant-form lead = a Meta ad id plus a meta_lead_events row;
- a website lead = a site_form_submissions row (form_key / page);
- a campaign's role = lead_role / is_tracked.
When you find a rule matching on contact_source, form_name, ad or campaign names, flag it and replace it. Related: [[feedback_never_use_ad_names]], [[feedback_source_first_touch_classify_on_page]].

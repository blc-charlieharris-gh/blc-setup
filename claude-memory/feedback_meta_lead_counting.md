---
name: feedback_meta_lead_counting
description: How to count Meta lead-gen leads / CPL correctly via the Marketing API (canonical action type)
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d78970bf-5121-459a-bed6-e185ab65af73
---

When reading lead-gen results from the Meta Marketing API `insights` `actions` array, count leads with ONE action type: `lead` (instant-form leads plus website pixel leads). `onsite_conversion.lead_grouped` is instant-form leads only, so it matches `lead` only on form-only ads.

26/10 slip: on InstallrHub's Direct to offer ad (form + website) I summed `lead` (108) and `lead_grouped` (100) and reported 208 leads at £11.80; the truth was 108 at £22.70, and the wrong note reached the Hub's Standard texts before I caught it.

**Why:** Meta returns the *same* lead under ~6 redundant action types: `lead`, `onsite_conversion.lead_grouped`, `offsite_complete_registration_add_meta_leads`, `offsite_search_add_meta_leads`, `offsite_content_view_add_meta_leads`, plus pixel variants. They all hold the identical value. Summing anything matching `"lead" in action_type` inflates the lead count ~5-6x and makes CPL look ~6x cheaper than reality (e.g. showed £15 CPL when the true CPL was ~£88).

**How to apply:** filter `actions` to `action_type == 'onsite_conversion.lead_grouped'` only; never sum across lead-ish types. Sanity check: lifetime CPL on the Retrofit Group account is ~£80, never £15-17. If a CPL looks suspiciously low, you are probably double-counting action types. Related: [[project_retrofit_group]].

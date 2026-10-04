---
name: feedback-source-first-touch-classify-on-page
description: "Since 10-04 a GHL contact's source is FIRST touch only (site + n8n never overwrite it); 'which form was this' must read Converted Page first, source only when no page"
metadata:
  type: feedback
---

Charlotte's rule (10-04): a contact's source and first-touch utm/fbclid/ih_* never change once set; the conversion touch is stored separately (site api/book.js writes booking_utm_source/medium/campaign/content, booking_ih_placement, booking_page_url on every booking; the Hub's booking_attribution reads them first). So contactSource no longer means "this form".

**Why:** a webinar registrant who later fills the homepage form kept source "Webinar Sign Up" and was counted as a sign-up.
**How to apply:** classify forms on `Converted Page` first, source only when there's no page (instant forms). Done in b2bAppointments isSignupIntake/isClientOnlyIntake and _shared/nurtureJoins formKeyOfIntake; others still to check are listed in hub-audit README row 23. InstallrHub form fills land in sales_lead_intake_events (not lead_intake_events). Related: [[feedback_installrhub_signup_vs_lead_rule]], [[reference_installrhub_track_js_attribution]].

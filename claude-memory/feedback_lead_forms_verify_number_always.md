---
name: feedback_lead_forms_verify_number_always
description: "Every Meta lead form ticks 'Require leads to verify number' (API is_phone_sms_verify_enabled, write-only); conditional logic is NOT in the API (tested 26/10)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: e9c88c5d-c315-4ad5-80c5-8b022261870b
  modified: 2026-10-26T09:55:53.785Z
---

Every lead form we make has "Require leads to verify number" on: in meta-access, in Ads Manager, and in any future Hub form-making. By API it's `is_phone_sms_verify_enabled: true` on POST /{page}/leadgen_forms (Meta type-checks it: "must be a boolean"), but it's write-only, so no read on v21-v25 returns it and existing forms can't be checked.

Conditional logic (go to question / submit / close) can't be set by API, tested 26/10 with throwaway forms on the BLC Promotions page (archived). Unknown top-level and option keys save silently with no error, so a 200 proves nothing. `conditional_logic` on a question is refused. `dependent_conditional_questions` is the CSV conditional-answers feature. Forms with logic are built in Ads Manager and wired in with config `form_id` + `clone_campaign.py swapform`.

**Why:** Charlotte 26/10, when Madola's V2 form (logic added by hand) went live. She asked for a triple check on the logic.

**How to apply:** clone_campaign.py step_form sends it (meta-access ec299ab, SOP section 4). Hub plan-meta-in-hub.md Risks has the note for Stage 3. Never trust a 200 from leadgen_forms as proof that a setting took. Related: [[reference_meta_finance_special_category_rules]]

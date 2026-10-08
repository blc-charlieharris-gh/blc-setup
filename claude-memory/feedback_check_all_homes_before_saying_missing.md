---
name: feedback_check_all_homes_before_saying_missing
description: "Before telling Charlotte \"we don't ask/store X\", grep the code and every JSON column (criteria, solar_profile, onboarding_answers...) for it"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 4d169e9e-5d48-4101-a9ec-00314ce2fab3
  modified: 2026-10-07T15:35:41.116Z
---

On 2026-10-07 I told Charlotte "we never ask installers about finance" and "the Hub doesn't store locations" after checking only `companies.onboarding_answers`. Finance is asked in onboarding ("Do you offer finance?", StepCriteria/CriteriaFields) and saved in `companies.criteria.offersFinance` / `financeTypes` / `financeZeroUpfront`; installer areas are `companies.postcode_areas`. She was rightly annoyed ("what on earth?").

**Why:** a wrong "we don't have that" sends her into doubt and wastes a round trip; the onboarding data lives in several JSON columns.
**How to apply:** before saying a question isn't asked or a fact isn't stored, grep `src` + `supabase/functions` for the word and check every JSON column on the row (criteria, solar_profile, sales_profile, onboarding_answers, earlier_answers, website_intake, packages). Say "I haven't found it yet" until both are done. Related: [[feedback_verify_known_issues_against_live]], [[feedback_check_history_before_building]].

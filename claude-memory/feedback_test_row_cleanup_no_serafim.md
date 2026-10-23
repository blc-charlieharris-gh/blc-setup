---
name: feedback-test-row-cleanup-no-serafim
description: "Removing the Hub's own test leads from app tables (e.g. dialer_contacts) doesn't need Serafim's sign-off; Charlotte runs it"
metadata:
  type: feedback
---

On 23 Oct 2026 Charlotte said: "we dont need serafim if all we're doing is removing test leads". This was about hub_remove_test_dialer_contacts, which only deletes or closes dialer_contacts rows the dialer made from a lead record (auto:intake), for the test's own contact ids, when is_test_lead matches.

**Why:** Serafim reviews changes that alter how the app behaves. Cleaning up the Hub's own test data doesn't.
**How to apply:** don't route narrowly scoped test-data cleanup to Serafim. Still flag anything that changes app behaviour or touches real rows. Related: [[feedback_serafim_signoff_and_handoffs]], [[feedback_hub_only_db_we_remove]].

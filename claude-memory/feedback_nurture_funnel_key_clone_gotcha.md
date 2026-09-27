---
name: nurture-funnel-key-clone-gotcha
description: "A new funnel_key/sequence existing and active in the Hub means nothing until a GHL workflow's Fire-a-webhook action actually sends that key; cloned workflows carry over the OLD key silently"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 155518cd-fc0a-46af-9f90-238c22e0ba6f
  modified: 2026-09-03T12:37:38.350Z
---

`nurture-enroll` (the Hub's edge fn) does zero source-awareness: it enrolls a contact into whatever `funnel_key` arrives in the webhook body, full stop. Routing to the correct nurture sequence is decided entirely on the GHL side, by whichever value is typed into that workflow's "Fire a webhook" action.

Found 2026-09-03: built a dedicated "Webinar-Oct2026" sequence (`funnel_key: webinar-oct2026`) in the Hub for [[project_installrhub_webinar_oct2026]], active with steps, looked fully wired. First test lead through the real webinar form instead landed in "Lead Nurture - No Booked Call" (`funnel_key: nurture-sequence`), the general new-lead cadence. Root cause: the GHL workflow handling webinar contacts was cloned from an existing "new lead" workflow, and its Fire-a-webhook action's `funnel_key` value was never updated from the old one. Confirmed by querying `nurture_enrollments` joined to `nurture_sequences` by email, since edge fn logs only capture errors, not successful enrollments.

**Why:** the Hub has no way to know a GHL workflow exists, let alone what value it sends. A sequence being active in the Hub UI proves nothing is broken on our side; it proves nothing about whether GHL is actually calling it with the right key.

**How to apply:** whenever a new funnel-triggered sequence is added for a campaign, do not consider it "wired up" until a real or test lead has been traced end to end: query `nurture_enrollments` (join `nurture_sequences` on `sequence_id`) for that email and confirm the `funnel_key`/sequence name matches intent. Especially suspect a cloned GHL workflow, check its Fire-a-webhook body value explicitly rather than assuming a clone updated everything it needed to. See [[reference_nurture_engine]] for the enrollment mechanics.

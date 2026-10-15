---
name: new-services-questions-email-route
description: Onboarding questions for a product added later go by Email client (New services form), never the auto welcome; add-on "No form needed" is ticked by default
metadata:
  type: reference
---

On 2026-10-15, Helix Power's website was added as an add-on in the onboarding picker. The add-on's "No form or call needed" box starts ticked, so no form was sent, and the board put the website straight into Website build with no questions asked. Their old onboarding was marked form_not_needed on 10-04.

How it works:
- lib/onboardingEmails dueOnboardingEmails skips anyone with formIn(checklist), and form_not_needed counts as in. So the automatic welcome never goes to them, even though generate-invite-token's welcomeEmail.willFire only checks form_submitted and can say "will fire".
- A "new services only" link (generate-invite-token `only`, plus checklist.added_form) is emailed through Email client (lib/clientEmailBuilder, variant 'added': "Answer them in your portal"). canSendAdded ticks it by default.
- On the client card, Send onboarding questions (components/clients/SendOnboardingQuestions.jsx, #feat/send-onboarding-questions-1015) does both for any product they already have, then opens Email client.

Related: [[marketplace-client-model]].

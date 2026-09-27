---
name: project_crew_google_profile_checklist
description: "CREW Google area (GBP set up/audit) built 09-22 as a scored checklist, no Google API, branch feat/crew-google-checklist, testing on Core first"
metadata: 
  node_type: memory
  type: project
  originSessionId: da79255b-fe3c-4017-91ec-6c33a1c2f194
  modified: 2026-09-22T07:44:05.725Z
---

2026-09-22: built the CREW Google Business Profile product on branch `feat/crew-google-checklist` (marketing-agent). The PR was not opened yet: Charlotte opens it from the push URL.

- **Model:** a 15-item checklist worth 100 points (pass = full points, partial = half, fail = 0). Audits record "as found" and "now" for each item, giving a before and after score. Set ups record "now" only. There's no Google API: Charlotte decided a staff checklist is enough, and the score comes from it.
- **Storage:** everything saves to `crew_deliverables.checklist` jsonb, added by migration 20260922090000. The public read goes through the new `crew_google_delivery_public(token)`. The logo's `crew_deliverable_public` was not changed.
- **Mode (updated 09-22, PR 2 `feat/crew-google-send-and-mode`):** Charlotte wants the Set up/Audit switch to CHANGE THE PACKAGE. It does a fresh read of companies.packages, flips only the two Google flags and writes it back directly (hub users pass the `is_admin` RLS policy, no edge function needed). It also moves a ticked client_onboarding item across. `checklist.mode` is now only used for crew clients with no linked company. Checked companies triggers: notify_installer_added only fires if installer_added_notified_at is null, so it's safe for onboarded clients.
- **Send:** a Send button emails the page (kind `google_delivery` in api/transactional-email.js, wording from googleEmail.js). It's disabled until all 15 items are marked. Sending sets the status to delivered (Approved) and ticks google_profile_audit/setup on the onboarding checklist.
- **Reviews service dropped:** "Google reviews" just means calling their old clients, a one-off, not ongoing. The delivery page only gives the client their review link to send out.
- **Client page:** `/google-delivery/:token` (reuses `delivery_token`) is read-only, and Charlotte confirmed it needs no approve step. PR 1 merged as #882 and its SQL has been applied.
- **Clients:** Core Electrics = audit (their package had both ticked from before the 09-18 exclusivity rule; Charlotte ran SQL on 09-22 setting setup=false). Harvard Renewables = set up, no Google access yet.

- **Questions + photos (MERGED #884, SQL applied 09-22, migration 20260922120000):** built like the website preview's info_requests, stored on `crew_deliverables.info_requests`. There are standard questions (areas, services, premises, year started, photos) plus custom ones. Send has two stages (googleSendState): first "score so far + before we finish we need" (the audit needs every As found marked first, and status goes to ready_for_review), then the final hand-over. Photos upload from the client page with the anon key straight into the PRIVATE bucket `crew-client-photos/<token>/`; the insert policy uses crew_google_token_ok. Staff view them through signed URLs.
- **Core as found (09-22, from Charlotte's paste of the Edit profile screens):** 48/100 if services is empty. Missing: secondary categories, service area (77 Alfred St is shown publicly but is postal-only), attributes and photos. Website points to /contact.html. Description is about 260 characters and says only "greater Manchester". 0 reviews. 

- **PR 4 (`feat/crew-google-reviews-item`, 09-22):** adds a `reviews` item (10 pts: none = fail, 1 to 9 = partial, 10+ = pass; 5 pts each taken from description and services), so the checklist now has 16 items. The standard questions are now ONLY the photo request. Charlotte's rule: "if we're asking them everything, they may as well have done it themselves". Staff research areas, services, address and year started themselves from the website, Facebook, Companies House (Core was incorporated Jan 2022) and onboarding.

- **State at end of 09-22 (#882 to #889 plus later fixes, all merged):**
  - The checklist has 19 items worth 100: primary category, service area, job photos and reviews are 10 each, everything else 4. Added: social profiles, products, recent update. The website item also covers the quote/booking link.
  - One-button "Re-score after changes". The page opens on re-scoring once As found is complete, because a click after the audit had silently rewritten Core's as-found answer.
  - The client link is on crew.installrhub.com (googleDeliveryUrl, early-return route in App.jsx).
  - Core: 42 as found, 72 now. 4 questions: photos, socials, accreditations, jobs wanted. SENT 2026-09-22 ~13:55, status ready_for_review (Awaiting client). Next: when replies arrive, add products + upload photos to GBP, re-score, Send finished audit.
  - Verification step BUILT (branch feat/crew-google-verify-step): standard `verify` request, always offered on set ups, and on audits only while Verified and live is not Done. The client clicks "I've verified it". Staff then mark Verified as Done.
  - Charlotte's plan: automate later via the GBP API. Suggested applying for access early, since approval takes weeks.

- **Access chase email (09-22):** RESTORED the original client-card "Email access request" button (#850, removed in #852 as a "one-off") on branch feat/restore-access-request-email. The duplicate CREW deliverable card (#905) was removed in the same PR. Core's social is waiting on Meta; Harvard is waiting on Google and Meta. Follow-up fix (branch fix/access-email-setup-steps): the Google section now picks its steps from packageGoogleMode (set up = create then invite, audit = invite, unknown = both). Harvard was first sent the audit steps and needs a resend.

**Why:** Charlotte wants "a well set up or audited profile" delivered with a score, and wants the audit to include the fixes we applied.
**How to apply:** future work could auto-fill the checklist from the Business Profile API. That needs Google API approval and access is already guaranteed by onboarding, so it's an optional time-saver, not the product. Related: [[project_crew_workspace]], [[project_crew_status_alignment]].

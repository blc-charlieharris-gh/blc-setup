---
name: meta-phone-number-required-fix
description: "Meta ad error 3858013 \"Phone number required\": verify a mobile in Ad account settings > Contact information; clears only when ad is switched on"
metadata:
  node_type: memory
  type: reference
  originSessionId: c00cad1f-660c-44dd-ac1e-561ab8037b58
  modified: 2026-10-08T12:28:39.556Z
---

Meta error 3858013 "Phone number required: You need to verify a phone number for this ad account" (seen on Elect act_1458286432823255, 2026-10-08).

- Fix location: Ads Manager menu > **Ad account settings** > Contact information > Mobile phone number > verify by SMS code. Not Account overview, not Business portfolio info.
- Works from a partner login (BLC Promotions has DRAFT/ANALYZE/ADVERTISE only, can't see the client's portfolio); no client admin needed.
- The number sits on the person's login, so use a company number (Brad/client), not a personal one, or it goes when they leave.
- Paused ads keep showing the error after verifying; it only re-checks when the ad is switched on (status ACTIVE -> IN_PROCESS/PENDING_REVIEW, error gone).
- API can't do the verification (needs SMS). Find the error via ads `issues_info`.

Related: [[meta-api-create-payload-gotchas]], [[log-client-meta-changes-in-hub]]

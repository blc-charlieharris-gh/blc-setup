---
name: reference-onboarding-board-tick-means-done
description: Ticking a branding item (e.g. "Website build") in the onboarding checklist = FINISHED, its board card disappears; to show waiting-on-client, drag to Awaiting client approval
metadata:
  type: reference
---

On the Clients onboarding board (src/lib/onboardingChecklist.js boardCards), ticking a branding track's checklist item ("Website build" = checklist.website) marks that track done, so its card folds away. It does NOT move to Awaiting client approval. Waiting on the client is a separate flag (awaiting_website, etc.), set by dragging the card to the Awaiting client approval column. Core, 2026-09-25: Charlotte ticked Website build, and only the Google card was left under Awaiting.

Charlotte was offered a clearer label ("Website finished (signed off)"), but she hasn't decided. Related: [[project-crew-roster-and-retainer-pill]].

Update 2026-09-25 (branch fix/simplify-site-status-merge-approval, pending merge): before this, dropping a website/content card on Awaiting client approval silently snapped back (no COLUMN_PATCH entry). Now fixed, and 2+ pieces awaiting approval fold into one `approval` card with a pill per piece (click pill = approved: deliverable -> delivered, website -> ticked done).

Update 2026-09-25 later: #1015 merged. Branch feat/link-site-status-to-board (pending): website card now follows hub_clients.status when a site exists (building->Website, ready_to_preview->Awaiting approval, signed_off/awaiting_payment/paid->Ready, transferred/archived->done); drags write the site status. Tick still = done unless site is ready_to_preview. Empty note in Awaiting approval shows "Awaiting sign-off". Realtime is NOT enabled on hub_clients or crew_deliverables (only client_onboarding), so those listeners never fire.

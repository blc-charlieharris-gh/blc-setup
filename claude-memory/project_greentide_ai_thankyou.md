---
name: project_greentide_ai_thankyou
description: "Green Tide solar thank-you page has an \"AI agent\" button POSTing lead data to an n8n webhook; heat-pump reverted to original"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9eabcc5e-eb80-48f5-b4ee-cddfdcd0c961
---

Green Tide ([[project_greentide]], [[project_greentide_site]]) post-form thank-you (eligible) pages got an "AI agent" variant (2026-06-25).

**Live state:**
- `site/solar/eligible/index.html` = AI version. A "Skip the wait" box sits ABOVE the fold inside the hero `.ty-next-card` (replaced the telesales image). Button "Speak to an AI agent now" POSTs to n8n webhook, then shows a confirmation modal.
- `site/heat-pump/eligible/index.html` = REVERTED to original (no AI button), per Charlotte "not doing it with that atm". Original heat-pump design backed up at `docs/thankyou-original-backup/heat-pump-eligible.html` (and solar-eligible.html) for easy re-enable.
- The interim `eligible-b` A/B folders were created then DELETED (redundant once AI design went onto `/eligible` directly).

**Webhook:** `https://n8n.srv1152514.hstgr.cloud/webhook/509ac9aa-3508-4707-a49f-7d2c289563f4` (n8n on hostinger). WORKING as of 2026-06-25. Two fixes that session:
1. The n8n Webhook node was registered for GET, so the page's POST 404'd ("not registered for POST requests") and nothing landed. The developer (Charlotte has no n8n access) flipped the node method to POST. Verify from outside: `curl -X POST <url>` should return `{"message":"Workflow was started"}`, NOT a 404. GET 200 + POST 404 = node still on GET.
2. Body format changed from a JSON blob (`text/plain`, needed `JSON.parse($json.body)`) to **flat `application/x-www-form-urlencoded`** so n8n parses each value into its OWN body field, no parse step. Still `mode:'no-cors'` + `keepalive` (form-encoded is a simple content type, no CORS preflight). Confirmation popup is still OPTIMISTIC (fires on send, not on a real 200) because no-cors hides the response, so n8n's execution log is the only true delivery proof.

**Payload (flat form fields, each its own field in n8n `body`):** `product` (=`"solar"`), `source` (=`"eligible"`), `page`, `referrer`, plus EVERY URL query param flattened to top level (no nested `lead` object anymore). Built by `leadBody()` via `URLSearchParams`. Fillout's redirect params define the lead keys. Current solar keys (lowercase): `name`, `number` (the phone, NOT `phone`), `email`, `address`, `postcode`.

Deployed to prod 2026-06-25 (`greentideenergy.com/solar/eligible` confirmed serving `leadBody`/`x-www-form-urlencoded`). Charlotte to send a live test through; dev to confirm split fields land in n8n.

**Fillout side (Charlotte does this):** set the redirect via "Redirect link parameters" (NOT field Default value) on the solar form: name/number/email/address/postcode. n8n workflow must be Active for the live `/webhook/...` URL to fire. Lead data only populates if Fillout appends these params.

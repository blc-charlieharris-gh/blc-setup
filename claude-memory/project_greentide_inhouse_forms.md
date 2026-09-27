---
name: project_greentide_inhouse_forms
description: "In-house Green Tide form is BUILT but OFF behind a kill switch (form-flag.js); Fillout is STILL LIVE until an n8n webhook exists. Form -> /api/lead (Vercel fn) -> n8n -> GHL -> lead_intake_events; the dashboard owns the destination."
metadata: 
  node_type: memory
  type: project
  originSessionId: 34db696c-bde3-45e3-beaf-1e39998ea23b
---

Built 2026-07-14, NOT LIVE. **Fillout is still the live form.**

**The kill switch is the first thing to know.** Both forms ship in the page; `site/js/form-flag.js` sets
`window.GT_LEAD_FORM_LIVE = false`, and `lead-form.js` renders one at boot and deletes the other. So Fillout is the
DEFAULT and `site/` is safe to deploy at any time. Going live = flip that one line + deploy. `?gt_form=new` on any
URL forces the in-house form for one visitor, so the whole chain can be tested ON PROD while real customers keep
getting Fillout. Blocker: the n8n workflow does not exist yet (spec in `site-greentide/docs/n8n-landing-lead-webhook.md`).

**The pipeline (Fillout never gave us a webhook, it used its own native GHL integration):**
`js/lead-form.js` -> `POST /api/lead` (Vercel serverless fn in `site-greentide/site/api/`) -> n8n -> GHL upsert -> existing GHL workflow -> Supabase `ghl-new-lead-webhook` -> `lead_intake_events`. Everything downstream of GHL is unchanged.

**Load-bearing payload fields, breaking any one is silent:**
- `utm_content` = the AD ID, the join key to `ads_ads`. Drop it and CPL/cost-per-sale die.
- `Type of Customer:` must be explicit. Blank silently defaults every lead to ASHP, so solar gets misfiled.
- `contact_source` = `Greentide Landing Form`. The dashboard classifier ([[feedback_meta_lead_counting]] adjacent) used to match only "fillout"; `useLeadReconciliation.js` now matches `fillout|landing`.

**DQ rules (Charlotte):** both products DQ on tenant, flat, park home. Heat pump also DQs on "only interested if it's free". DQ = instant redirect to `/:product/not-eligible`, NO lead sent, no contact details captured (`captureDisqualified: false` flips it).

**The dashboard owns the webhook.** `landing_form_routes` table + secret-gated `landing_route_lookup` RPC; edit the destination in marketing-agent -> Lead Intake -> Forms -> "Landing page forms". `/api/lead` looks it up per submit (60s cache) and falls back to the `LEAD_WEBHOOK_URL` Vercel env var if the lookup fails, so config problems can't drop a lead. Migration `20260714000000_landing_form_routes.sql` is Tier-2 = Serafim gate.

**This is the client-lander template.** The engine is config-driven (`GT_LEAD_FORMS` / `window.GT_LEAD_FORM_OVERRIDES`); a new client overrides config, never forks the engine. See [[project_client_landers]].

Fixes the junk-postcode problem at source ([[project_dirty_lead_postcodes]]): real UK postcode + UK phone validation, enforced server-side, phone normalised to E.164.

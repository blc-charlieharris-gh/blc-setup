---
name: reference-marketplace-lead-routing-chain
description: How a Meta lead is filed to a client end to end (meta-lead-webhook -> lead-ingest -> register-installer/apply-company-packages), and the gaps that block Green Tide-account campaigns for marketplace clients (read from live fns 2026-09-25)
metadata:
  type: reference
---

Read from the DEPLOYED functions on 2026-09-25 (all in Serafim's repo, readable via Supabase MCP get_edge_function):

- **meta-lead-webhook v36**: client = ad first (`ads_ads.external_id` -> `client_id`, i.e. the AD ACCOUNT owner), then page, then `meta_lead_form_routes.client_id` only as a FALLBACK. Delivery (`destination_url`) always follows the form route. So an ad set for a client inside the Green Tide account is filed as Green Tide.
- **lead-ingest v17**: trusts `body.client_id` from the webhook; `projectName = client.name`, `company_id` from it; lead_only branch skips GHL.
- **register-installer / onboarding-satellites**: `retainer_sop` (availability, pricing the Qualify agent books against) only written when `flags.is_retainer`.
- **apply-company-packages**: creates a `clients` row only for retainers (tier 'retainer'), never changes an existing client's tier, refuses retainer+marketplace together, never resets `client_onboarding.status` on a re-sale.
- Nightly `resolve_meta_lead_attribution()` re-stamps `meta_lead_events.client_id` to the ad account owner.

Fixes requested of Serafim: `.claude/docs/serafim-note-2026-09-25-marketplace-lead-routing.md` (marketing-agent repo). Related: [[project-session-2026-09-25-parked]].

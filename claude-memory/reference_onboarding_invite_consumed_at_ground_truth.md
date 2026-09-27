---
name: reference-onboarding-invite-consumed-at-ground-truth
description: onboarding_invite_tokens.consumed_at is the definitive proof a client has actually submitted the onboarding wizard; checklist flags and presence of onboarding_answers can both be misleading
metadata: 
  node_type: memory
  type: reference
  originSessionId: 44cde540-6616-4a88-a3b2-aa3dcd206c88
  modified: 2026-09-03T12:48:03.771Z
---

To know for certain whether a client has actually submitted InstallrHub's client-onboarding form (not just "does data exist on their record"), check `onboarding_invite_tokens.consumed_at` for their company's most recent minted token. Null means the link has never been opened/submitted, full stop, regardless of what else looks filled in.

**Why this beats the alternatives:** `client_onboarding.checklist.form_submitted` could get stuck false by an insert-only writer bug (fixed 2026-09-03, see [[feedback_supabase_dashboard_deploy_silent_noop]] for how that fix was verified). And `companies.onboarding_answers` being non-empty can predate the CURRENT invite entirely, a company can have real answers from an earlier, separate signup process (e.g. a PPS/marketplace intake) while their current retainer-onboarding invite sits completely unopened. Found exactly this on NIBE 2026-09-03: rich `criteria`/`sales_profile`/`onboarding_answers` from an 08-10 process, current invite minted 09-02, `consumed_at` null the whole time, i.e. they had never touched the actual current form despite looking "mostly onboarded."

**How to apply:** when diagnosing "did this client actually submit" or "why does their record look incomplete", query `onboarding_invite_tokens` for that `company_id` first (`select jti, packages, minted_at, consumed_at from onboarding_invite_tokens where company_id = '<id>' order by minted_at desc`) before trusting any inference from `companies` or `client_onboarding` data. `packages` on that row also tells you which invite variant (core/marketplace) was minted, useful for knowing which form steps would even have applied.

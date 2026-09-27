---
name: onboarding-picker-doesnt-prefill-services
description: "OnboardingPicker.jsx's service checkboxes always start blank for an existing client, need to flag to Serafim before staff use it for real package add-ons"
metadata: 
  node_type: memory
  type: project
  originSessionId: 696dfa91-015b-4c1c-8308-6a8e631cf4a2
  modified: 2026-09-21T07:51:45.109Z
---

`/onboarding-picker?company_id=<uuid>` (`src/pages/hub/OnboardingPicker.jsx`) is the real sales-side tool for setting what a company bought, writing to `companies.packages` via the `apply-company-packages` edge function (lives in Serafim's InstallrHub repo, not this one).

Found 2026-09-21 while helping Charlotte add a logo package to an existing client for a demo: the page pre-fills `sold.brand`/`sold.retainer`/`sold.marketplace` from the company's existing record, but the `services` checkboxes (Website/Google/Social/Logo/Sales) always start blank (`emptyKeyed(...)`, `OnboardingPicker.jsx` around line 82), even for a company that already has services ticked.

**Why it matters:** can't confirm from this repo whether the edge function merges the submitted `services` into the existing `packages.services` or replaces it wholesale (the function's source is server-side, not in this codebase). If it replaces, using this picker to add ONE new service to an existing client (e.g. adding Logo to a client who already has Website) would silently wipe their other services unless staff happen to re-tick everything already bought.

**How to apply:** flag to Serafim at the next handoff. Either (a) have the picker pre-fill `services` from the company's current `packages.services` so a partial edit is safe by default, or (b) confirm the edge function merges rather than replaces, so the blank-start UI isn't actually risky. Until resolved, tell anyone using this picker for a real add-on to re-tick every service the client already has, not just the new one.

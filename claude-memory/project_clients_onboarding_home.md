---
name: project_clients_onboarding_home
description: "Ads-client onboarding now lives at /clients (Clients home), not scattered across Parameters/Settings"
metadata: 
  node_type: memory
  type: project
  originSessionId: abb305e4-98ac-4641-82a4-26eb4e794ede
---

marketing-agent has a **`/clients` "Clients" page** (in the existing CLIENTS nav section, `client_sites`
perm) as the single home for ADS clients (the `clients` table, NOT CREW `hub_clients`). Shipped Phase 1
2026-07-23 (#315, #317, #318):
- New Client form (`components/clients/AddClientCard.jsx`), per-client targets, tracking
  (`TrackingPanel`), and setup-status badges. Live (tracked) clients up top, not-live grouped at bottom.
- Moved off Parameters (targets + add-client) and Settings (tracking); the stale "needs Serafim"
  onboarding copy is gone (the clients INSERT policy has been live since 2026-07-10).
- Shared `NumField`/`Card` live in `components/shared/ParamField.jsx`.

**Phase 2 (not built, plan in `current-plan.md`): discovery-first onboarding.** Meta access is granted
BEFORE onboarding, so it should START with a "find new ad accounts" button that lists accounts our system
user can see but that aren't in `clients` yet (Graph `/me/adaccounts` diffed against
`clients.meta_ad_account_id`) — no manual `act_` id. That's the one Serafim-gated edge-fn
(`meta-discover-accounts`). First real client through it = InstallrHub (behaves like Greentide, not
lead_only). Lead routing (page/form/landing → client) stays in Lead Intake, not deep-linked.

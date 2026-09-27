---
name: hub-permissions-guard-and-default-role
description: profiles.hub_role defaults to team_member for every app sign-up; hub_permissions writes are blocked unless auth.role() is service_role (backfill needs set_config)
metadata:
  node_type: memory
  type: feedback
  originSessionId: 074717eb-e574-4f49-9c99-c126f7aaa2b7
  modified: 2026-09-24T17:31:54.026Z
---

Two facts about the shared `profiles` table, learnt 2026-09-24 while adding Hub areas (#986/#988):

1. `profiles.hub_role` DEFAULTS to `'team_member'`, so every InstallrHub app sign-up (installers, demo@installrhub.com) silently gets a Hub role. Since #986, Hub access is by area keys (marketing/crew/clients/installrhub in hub_permissions), so an account with no areas sees nothing; only @blc-promotions.com and @installrhub.com staff were backfilled.
2. Trigger `hub_profiles_privilege_guard` raises 42501 on any change to hub_role / hub_permissions / is_active unless `auth.role() = 'service_role'`. A SQL-editor backfill therefore fails and rolls back the whole script. Pattern: `begin; select set_config('request.jwt.claim.role','service_role', true); update ...; commit;` (transaction-local).

**Why:** the first areas SQL run failed on the guard while the frontend was already merged, briefly leaving staff without their Hub areas.

**How to apply:** any migration touching hub_permissions needs the set_config line; never assume "has hub_role" means staff. New Hub permission keys also need hub-admin-users' whitelist updated first, see [[dashboard-edge-fn-paste-deploy]].

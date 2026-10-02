---
name: reference_old_tab_guard_client_info
description: Hub requests carry X-Client-Info 'hub-web build/<id>'; trigger hub_guard_old_tab refuses stale-tab writes to hub_tasks / hub_track_owners
metadata:
  type: reference
---

Since 2026-10-02 (migration 20261003100000) every Hub supabase request sends X-Client-Info `hub-web build/<__BUILD_ID__>` (src/lib/supabase.js). Trigger `hub_guard_old_tab` on hub_tasks and hub_track_owners raises "This Hub tab is out of date. Reload" for an authenticated request without it. Cron, service-role edge fns and hand-run SQL pass. The top bar shows "New version, reload" (lib/buildVersion, /version.json) and the set-up sync / repeating jobs stand down on old code.

Root case: Erin's Safari tab from before #1281 reopened 3 held Brand "Build campaign" cards twice (1 Oct 19:48, 2 Oct 09:56); the old code wrote hub_track_owners by POST upsert, the new by PATCH, which is how it was told apart in edge_logs (request.sb.jwt...subject gave the user).

**How to apply:** any rule that only lives in the browser can be undone by an old tab or half-loaded data (audit checklist 7a). Back it with the DB, or have the write re-check fresh data. To find who wrote something: edge_logs log_attributes request.headers.user_agent / x_client_info / request.sb.jwt.authorization.payload.subject. Related [[feedback_audit_changes_must_not_break]].

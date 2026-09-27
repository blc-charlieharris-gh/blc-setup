---
name: project_installrhub_dialer_daily_cap
description: "InstallrHub dialer's per-agent daily call cap is one GLOBAL app_settings value, not per-agent; raising it isn't self-reverting"
metadata: 
  node_type: memory
  type: project
  originSessionId: 3f262a58-c62e-4c69-b934-1d6d5ddfc1ff
  modified: 2026-09-02T13:49:36.228Z
---

The InstallrHub agent dialer (`agent-call-start` edge function, see
[[project_installrhub_dialer_stuck_call]]) refuses new outbound calls with
reason `rate_limited` when an agent's call count for the current LONDON day
reaches `app_settings.agent_calling_daily_cap` (default 150). This is a
distinct blocking reason from `already_live`, different bug class, different
fix.

**Why:** The count (`agent_calls` rows today, per `agent_user_id`) is scoped
per agent, but the cap it's compared against is ONE global row in
`app_settings`. There is no per-agent override in the schema or code, so
"give this one person more headroom" can only be done by raising the limit
for every agent. Confirmed 2026-09-02: only the call COUNT resets nightly
(new day = zero calls logged); the cap SETTING itself does not auto-revert,
so a manual bump (e.g. 150 → 160) stays in effect indefinitely until someone
runs the UPDATE back down.

**How to apply:** When someone hits "today's call limit": query
`agent_calls` for that agent's count today (`started_at >= ` London day
start) to confirm it's actually at/over the cap, and check who else is
dialing today (group by `agent_user_id`) before bumping, since raising the
global cap affects everyone currently dialing, not just the person who
asked. To change the value, hand off the SQL (`UPDATE app_settings SET
value = '<n>'::jsonb WHERE key = 'agent_calling_daily_cap'`) since Supabase
MCP here is read-only, see [[feedback_supabase_mcp_read_only]]. Always pair
a temporary raise with an explicit revert statement/reminder, since nothing
in the system will do it automatically. Don't run the raise and the revert
back to back, the cap is re-read on every dial attempt, so if it's already
back at the old value by the time the agent tries again, the raise
accomplished nothing, space them apart (raise now, revert once they're
actually done for the day).

Full cycle confirmed working end to end 2026-09-02: 150 → 160 → 180 (each
bump needed because the agent kept dialing past the new ceiling within
minutes) → reverted to 150 same evening once she finished. Typical bump
size for one busy agent finishing out a day: +10 to +30 over default.

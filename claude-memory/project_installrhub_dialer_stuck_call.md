---
name: project_installrhub_dialer_stuck_call
description: "app.installrhub.com's telesales dialer is Twilio + Supabase edge functions (not a checked-out repo); known \"already on a call\" false-block bug and its fix"
metadata: 
  node_type: memory
  type: project
  originSessionId: f04d5cea-197d-4bd0-b9c6-d48bb8089f54
  modified: 2026-09-02T13:49:46.608Z
---

app.installrhub.com (the InstallrHub Dashboard) has a custom agent→homeowner
calling feature for telesales/admin staff, built on Twilio Voice + Supabase
edge functions in the shared `ozmyjrzleejbqxqphbut` project — **not** a
frontend repo checked out on this machine. Relevant tables: `agent_calls`,
`agent_call_presence`, `agent_numbers`, `calls`. Edge functions:
`agent-call-start/-status/-voice/-token/-control/-inbound`, shared logic in
`_shared/agent-calling.ts` + `agent-call-rules.ts`.

**Why:** The app enforces one live call per agent by checking for an
`agent_calls` row with `ended_at IS NULL`. Twilio's completion webhook
(`agent-call-status`) normally stamps `ended_at` within seconds of a call
ending. Confirmed 2026-09-02: Sophie Halla's "already on a call" report was
NOT a bug, her call genuinely ran ~7 min and the block cleared the instant
the webhook landed. But the failure mode is real and already present in prod:
two Serafim Parente rows from 2026-08-24 are still open (`ended_at` null,
`calls_id` null) because the webhook never landed for them — if that happens
within the 2-hour `LIVE_MAX_MS` window it falsely blocks that agent.

**How to apply:** If telesales/admin staff report "already on a call" again,
use the [[fix-stuck-agent-call]] skill (`BLC/.claude/skills/fix-stuck-agent-call/`)
rather than re-deriving this from scratch. It has the read-only diagnostic
SQL, the safety gate (confirm the agent isn't genuinely mid-call before
touching anything), and the exact minimal write to hand to whoever has
Supabase write access (Supabase MCP here is read-only, see
[[feedback_supabase_mcp_read_only]]). See also
[[feedback_diagnose_stated_symptom_not_substitute]]: diagnose this exact
symptom, don't assume it's actually [[project_installrhub_dialer_daily_cap]]
just because a cap conversation is already in flight, check both.

**If the skill's own checks come back clean** (no open `agent_calls` row,
and confirmed not over the daily cap either) but the report persists: check
`agent_call_presence` for that `admin_user_id`. It's one row per open
browser TAB, and the one-live-call rule is per-agent, not per-tab, so an
agent with two tabs open (dashboard left open + a fresh one, or two
windows) can get correctly blocked dialing from tab B while tab A is mid-
call, and it reads to them as a false block since they're not looking at
the tab that's actually busy. Not a bug in that case, just ask if they have
more than one tab/window open. Confirmed 2026-09-02: this resolved itself
once the extra tab situation cleared, without any DB write needed.

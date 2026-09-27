---
name: reference_telesales_dialer_diagnostics
description: "Start-here pointer for any InstallrHub telesales/dialer issue: which system, which tables, which known issue it probably is"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 3f262a58-c62e-4c69-b934-1d6d5ddfc1ff
  modified: 2026-09-03T07:47:22.395Z
---

Entry point for diagnosing telesales dialer problems ("can't dial", "stuck
on a call", "hit the limit", agent name + symptom). Charlotte flagged
2026-09-02 that this effectively needs to be a "telesales" section
somewhere discoverable, this memory is that section until/unless it becomes
a real doc.

**The system:** app.installrhub.com's agent→homeowner calling feature.
Twilio Voice + Supabase edge functions in the shared `ozmyjrzleejbqxqphbut`
project. Source repo is `serafimparente-blc/InstallrHub-Dashboard` on
GitHub, **not cloned anywhere under BLC** (exhaustive search confirmed
2026-09-02, see [[reference_installrhub_dashboard_repo_not_local]]) and
Charlotte doesn't have access to it while Serafim is away. Until that
changes, diagnosis and fixes go entirely through the Supabase MCP, same
project, no source-code visibility needed for the two known issues below.

**Key tables to check, in this order:**
1. `profiles` — resolve the agent's name to `id` (`agent_user_id` everywhere else)
2. `agent_calls` — one row per call attempt, `ended_at IS NULL` = still open
3. `agent_call_presence` — one row per open browser TAB for that agent
4. `app_settings` — global toggles, keys prefixed `agent_calling_*` and `dialer_*`

**Known issue #1, "already on a call" when they're not:**
→ [[project_installrhub_dialer_stuck_call]] + run the
[[fix-stuck-agent-call]] skill. Usually a Twilio webhook that never landed
(check `agent_calls` for an open row), occasionally a multi-tab false
positive instead (check `agent_call_presence` for 2+ rows).

**Known issue #2, "hit today's call limit":**
→ [[project_installrhub_dialer_daily_cap]]. `app_settings.agent_calling_daily_cap`
is ONE global number, not per-agent, resets only the call count nightly
(London day), never the setting itself. Bumping it affects every agent
currently dialing.

**Constraint that shapes every fix:** Supabase MCP here is read-only, see
[[feedback_supabase_mcp_read_only]]. Diagnosis is always self-serve, the
actual UPDATE statement always gets handed to Charlotte or whoever has
write access to run.

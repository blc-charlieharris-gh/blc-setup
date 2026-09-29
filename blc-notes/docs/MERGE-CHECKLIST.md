# Merge checklist (kept up to date by Claude)

Last updated: 29 Sep, late evening (Mac). Everything is on GitHub. Safe to switch devices.
Hub handoff: marketing-agent/.claude/docs/current-handoff.md (PR docs/handoff-2026-09-29-evening, merge it).

DONE today (all merged + live): #1165 Targeting rebuild (SQL run), #1166/#1167 Taskboard Priority + Bank decisions,
#1168 SOPs/Parameters to Admin, #1169/#1172 client groups everywhere, #1170 lead-only no-bookings, #1171/#1173/#1175
Brand package pause flow, #1174 archive Coverage/Placement/AI Ops/chat (SQL run). Edge fns deployed + verified.

## Still to do
1. [x] DONE 29 Sep (verified): L W Heating SQL (ticks their onboarding form so the campaign card sits in Campaign set up).
       On the Mac it's in the Claude scratchpad; on another device ask Claude to write it again:
       update client_onboarding set checklist = checklist || '{"form_submitted": true}' where id = 'c2e972e3-5bd5-4b3d-8e28-bc97b3db1073'
2. [x] DONE: handoff docs PR merged (#1176):
       https://github.com/serafimparente-blc/marketing-agent/pull/new/docs/handoff-2026-09-29-evening
3. [ ] Optional: delete unused edge fns in Supabase (marketing-sweep, agent-execute, agent-apply, agent-tweak, placement-rollout).

## For Serafim, at the end of the audit (only things that affect him)
- Supabase disk to 8 GB (Spend Cap warning).
- GHL: a fixed "Out of area" lost reason for telesales.
- Old targeting functions + targeting_pins can be dropped (Hub-only; we can do it ourselves).

## Next session (on the other device)
Run blc-sync pull, say "prime project", then: item 1-2 above, then page 12 SOPs + Parameters, then Crew pages 13-15.
Edge fn paste files: ALWAYS rebuild before pasting (scripts/bundle-edge-fn.py), never trust _deploy.

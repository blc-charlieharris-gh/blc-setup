# Merge checklist (kept up to date by Claude)

Last updated: 29 Sep, end of session. Everything is on GitHub. Safe to switch devices.
Report: ~/code/BLC/docs/FINAL-AUDIT-REPORT.md

DONE: #1158 notes, #1159 Urgent (SQL run), #1160 launch, #1161 Performance (SQL run),
#1162 By creative + Why it works, #1164 Dashboard/Actions/Status.

## Still to do

1. [ ] Paste-deploy 2 edge functions (from #1164, not live yet: checked 29 Sep):
   Supabase > Edge Functions > open the function > paste > Deploy
   - hub-action-alerts      <- ~/code/BLC/_deploy/hub-action-alerts.ts
   - marketing-status-check <- ~/code/BLC/_deploy/marketing-status-check.ts

2. [ ] READY: Library, Bank and Taskboard.
   a. Merge: https://github.com/serafimparente-blc/marketing-agent/pull/new/fix/final-library-bank-tasks
   b. Run SQL: ~/code/BLC/docs/final_library_repairs.sql (when nobody has the Hub open)

3. [ ] Page 8 Targeting decisions, then Claude builds the page 8 fixes:
   - A. Headline %: A1 show "1 of 1 areas" and grey until enough areas (recommended) / A2 loosen the rule.
   - B. "Add / remove targeting" sketch pad: remove (recommended) / relabel "Planning sketch".
   - C. Excluded installers: one shared list (small SQL) / drop the feature.

## With you and Erin
- Tag the live ads for Arktek, SWH and webinar 3/4/5; change Arktek's test to 4 days.
- National Eco: send the 2 missing 22 Sep leads by hand (Leads Center, 03:32 and 11:35).
- Supabase disk: shrink to 8 GB after a heads-up to Serafim.

## Next session (on the other device)
Say "prime project", then: finish items 1-3 above, build page 8 fixes, then page 9 Coverage.

Note for the other device: the 2 edge function paste files live only on the Mac (_deploy). On another
device, Claude rebuilds them from the repo: `python3 scripts/bundle-edge-fn.py hub-action-alerts` and
`... marketing-status-check` in marketing-agent (main already has the code, #1164).

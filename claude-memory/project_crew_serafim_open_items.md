---
name: project_crew_serafim_open_items
description: "3 CREW/dashboard backend items still open on Serafim's side as of 7 Jul 2026, verified live despite \"handed over everything\""
metadata: 
  node_type: memory
  type: project
  originSessionId: 86e40a14-f3ce-4a10-b20f-32a5c513b4d6
---

As of 7 Jul 2026, Serafim said he "handed over everything." Verified against the live Supabase project:
he DID ship the CREW backend (crew_clients table + crew-report / crew-audit-request / crew-intake /
crew-login edge fns + portal password). But three follow-ups from the handoff doc are still NOT done
(re-verified live, not assumed):

1. **Count-all-spend NOT applied.** Both `tech_windowed_totals` and `ad_windowed_totals` still contain
   `AND v.campaign_id IN (SELECT id FROM ads_campaigns WHERE is_tracked)`. Remove that campaign-level
   line from both; the client-level `cl.is_tracked` (in the p_client='all' CASE) stays. This is the one
   with a real number (Greentide week under-reports).
2. **`crew-request-public` edge fn does not exist** (get_edge_function -> Function not found). Needed for
   the public cold-lead landing: POST {site,email,social} -> create crew_clients row -> kick crew-audit
   -> return {slug}. Landing falls back to book-a-demo until it exists.
3. **CREW seed migration NOT applied.** crew_clients holds only greentide, hq-group, installrhub.
   Synergi / Gas Worx / Arktek are frontend-fallback only. Apply
   `20260706120000_crew_seed_audits.sql`. Tidy-up, not blocking.

Also unconfirmed: client-auth activate/reset for crew.installrhub.com/<slug> (crew-login is live).

Parked for next session. Source of truth = marketing-agent docs/crew-serafim-handoff.md (updated 7 Jul,
branch docs/crew-handoff-7jul). Related: [[project_crew_workspace]], [[project_sitescore_audits]],
[[feedback_serafim_signoff_and_handoffs]].

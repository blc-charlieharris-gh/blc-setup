---
name: project_sops_vs_flag_parameters
description: "SOPs (AI agent playbook) vs dashboard flagging parameters are two separate, unsynced rule sets in marketing-agent"
metadata: 
  node_type: memory
  type: project
  originSessionId: 974ae2cb-f0c9-4dc6-88e0-ce74375e8195
---

In marketing-agent there are TWO rule sets that look like "the parameters" but are separate:

1. **SOPs** — the `sops` table, editable live at `/sops`, versioned. Six markdown docs that are the **AI agent's** playbook (read via `get_sop` by the chat + recommendations/sweep engine ONLY): `cpl_thresholds` (CPL bands vs `clients.target_cpl`: Scale ≤0.8×, Healthy 0.8-1.0×, Watch, Pause), `creative_testing` (winner floor: spend ≥£500 AND ≥20 leads), `data_sufficiency` (Weak/Moderate/Strong), `lifecycle_classification` (7 stages), `trailing_windows` (2d/7d/14d), `anomaly_types`.

2. **Dashboard flagging parameters** — HARDCODED in code, consumed only by the dashboard UI: `src/lib/adAlerts.js` (red-flag rules: £50+ no leads 5d, £100+ no bookings, cost/booked >£70/30d, etc.), plus the reconcile/status thresholds in `ReconcileBar.jsx` and `Status.jsx`, plus `clients.target_cpl` in the DB.

Overlap is CONCEPTUAL only (both encode "good/bad ad"); they are two stores, two formats, two consumers, NOT synced. Only `target_cpl` is shared by both.

Charlotte's "see and eventually change the parameters" goal = set #2 (dashboard flags), which is invisible/hardcoded today. Set #1 (SOPs) is already visible+editable. The centralisation follow-on: surface + make editable the dashboard flag params like SOPs already are, and decide whether to unify the two. See [[project_db_meta_underreporting_attribution]] for the reconcile/status split.

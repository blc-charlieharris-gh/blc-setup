---
name: feedback_reconcile_direction_asymmetric
description: CRM/DB vs Meta reconcile must be direction-aware — CRM under Meta is always a real flag; CRM over Meta is tolerable
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 974ae2cb-f0c9-4dc6-88e0-ce74375e8195
---

Charlotte (2026-06-24): the data-health/status reconcile between CRM(DB) leads and Meta conversions must treat the two directions differently.

- **CRM < Meta (deficit):** Meta logged conversions that never reached the CRM = real tracking/pipeline loss. ALWAYS flag, low tolerance.
- **CRM > Meta (surplus):** expected and benign within a band (Meta attribution lag, cookie/consent blocking, attribution-window timing).

Two surfaces had this symmetric bug:
1. `src/components/performance/ReconcileBar.jsx` (Performance page) — used `Math.abs(meta - bridge)/denom`. FIXED 2026-06-25 (direction-aware, merged as #88).
2. `src/pages/Status.jsx` "Lead pipeline (ads → database)" card — showed "Flowing" for any DB count even when DB < Meta (e.g. 38 vs 41). FIXED 2026-06-25 frontend-side (branch fix/status-leads-pipeline-direction): chip/banner now flag when DB short by ≥3 and ≥5%. Mirrors ReconcileBar thresholds.

OUTSTANDING follow-up (cross-repo, Serafim-gated): the `marketing-status-check` edge fn (source in InstallrHub repo, NOT checked out in BLC workdir) computes `leads.ok` symmetrically and drives the 2-hourly EMAIL alert + server `overall`. The Status.jsx fix only makes the dashboard stricter; the email won't notify on a DB-under-Meta deficit until the edge fn gets the same rule. Spec: `.claude/docs/status-monitor-edge-fn-spec.md`.

**Why:** symmetric tolerance hides the one direction that signals lost leads, which is the whole point of the check.
**How to apply:** make reconcile asymmetric — hard flag on deficit at a low threshold (e.g. ≥3 leads and ≥~5%), wide tolerant band on surplus (~10/25% drift), with distinct labels ("Leads not reaching CRM" vs "Drift, worth a look"). See [[reference_greentide_utm_attribution]] for how bridge leads are attributed.

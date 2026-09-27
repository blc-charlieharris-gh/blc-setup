---
name: reference_leadintake_forms_active_tick
description: "Lead Intake > Forms \"Active\" tick is a routing flag (webhook forwarding), NOT a visibility filter; the list is lead-driven. Since 2026-07-28 inactive forms are hidden by default with a Show-inactive toggle."
metadata: 
  node_type: memory
  type: reference
  originSessionId: 726b17e5-24fc-4a96-96ab-28ba57a9c410
---

The **Active** checkbox on Lead Intake > Forms (FormsTab.jsx) writes `meta_lead_form_routes.active`. That column is consumed by the `meta-lead-webhook` edge fn (in the InstallrHub repo, not marketing-agent) to decide whether to FORWARD a form's incoming leads. It is a routing flag.

The Forms table itself is **lead-driven**: `useLeadIntake` builds the rollup from `meta_lead_events`, showing any form that has a lead on a tracked campaign whose owner client `is_tracked=true`. So unticking Active never removed a form from the list on its own. That is why "National Eco ECO4 V2" (form `1354127009872704`, client National Eco `is_tracked=true`, 211 leads) kept showing after being unticked, and confused us on 2026-07-28.

**Fixed 2026-07-28** (`fix/leadintake-hide-inactive-forms`, merged): FormsTab now hides forms whose route `active=false` by default, with a "Show inactive (N)" toggle to reveal + re-activate them (revealed rows muted). `active` still defaults true for forms with no saved route.

Levers that ALSO drop a form off the list (beyond the tick): its leads aging out of the rollup window, or marking the owning client / campaign `is_tracked=false`. See [[project_greentide_lead_pipeline]] and [[reference_lead_counting_model]].

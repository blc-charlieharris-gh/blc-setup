---
name: feedback-hub-costs-hub-side-only
description: "Hub cost/storage figures must be the Hub's share only; the Supabase project is shared with Serafim's InstallrHub app"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 091d3959-9912-4d6b-8a11-180c9a2c135f
  modified: 2026-09-29T16:07:07.201Z
---

When reporting or building cost, storage, egress or disk figures for the Hub, show the Hub's own share, not the whole Supabase project. The project (ozmyjrzleejbqxqphbut) is shared with Serafim's InstallrHub app.

**Why:** Charlotte 2026-09-29, while speccing the Settings "Costs and storage" calculator: "remember this is just the hub side of things, not the app, and we both are on the same project".

**How to apply:** tag buckets and tables as Hub / App / Shared and lead with the Hub subtotal. Label project-wide numbers (egress, disk, plan) as "whole project, Hub and app together". Project-level changes (disk size, spend cap, log clean-up) need a heads-up to Serafim. State on 09-29: disk is 12 GB provisioned vs 8 GB included, DB is ~1.2 GB, egress is ~57 of 250 GB in 9 days. See [[reference-blc-supabase-cli-wrapper]].

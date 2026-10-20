---
name: project-n8n-replacement-session-1020
description: "DONE 2026-10-20: every lead form moved off n8n to the Hub's lead-ingest; what's left (delete paused flows, rotate lead password)"
metadata:
  node_type: memory
  type: project
---

Done on 2026-10-20 (blc-27): every live Meta and website form (clients, Green Tide, National Eco, InstallrHub DTO + 10 installrhub.com forms) goes to lead-ingest, each tested, n8n workflows paused, n8n removed from Hub set-up and installrhub.com fallbacks. Details: repo memory [[reference-lead-routing-ghl-accounts]], hub-audit README End deliverables.

Left: delete the paused n8n flows after a few days; rotate LEAD_INGEST_SECRET once n8n is deleted; NIBE/HQ/Eco Green deliberately left on n8n links (paused/churned). GHL nurture workflows are GHL, not n8n: separate item, not done.

**How to apply:** a new client's form = Lead intake > Send to Lead ingest + Advanced settings (or Connect their area ad set > "Set up like Green Tide's form"); never an n8n link. Related: [[project-solar-marketplace-route-drops-reenquiries]] (fixed 10-20).

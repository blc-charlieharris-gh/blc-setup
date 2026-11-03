---
name: feedback_ghl_never_a_fallback
description: "GHL is being switched off; never keep or add GHL as a fallback (booking widgets, lookups, writes) for anything moved to the CRM/Hub"
metadata:
  node_type: memory
  type: feedback
  originSessionId: b5437a73-bedd-46e2-b804-8bbdbff4b93e
  modified: 2026-11-03T10:06:30.883Z
---

Charlotte 3 Nov 2026, strongly: "GHL IS GETTING TURNED OFF AND SHOULD NOT BE USED AS A FALLBACK!" (after I only
narrowed the site's GHL booking-widget fallback to network failures).

**Why:** a GHL fallback silently books/writes past the CRM and creates drift; GHL will soon not exist at all.
**How to apply:** when moving anything off GHL, remove the GHL path completely (widgets, iframes, form_embed.js,
api fallbacks, env-switch "else GHL"), show a plain error instead. Also sweep EVERY place offering the same thing
(all disco/demo booking spots, Parameters > Calls) in one change, never one surface at a time. Related:
[[project_ghl_removal_hub]], [[feedback_crm_crossover_additive_only]].

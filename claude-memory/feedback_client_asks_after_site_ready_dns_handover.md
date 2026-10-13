---
name: feedback_client_asks_after_site_ready_dns_handover
description: "Website builds: don't list client items as \"waiting on\" before we send the site; going live = we send DNS instructions, never ask for Wix/registrar logins"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 98eb999d-40d6-4a2b-a138-d2ad552d2ea4
  modified: 2026-10-13T18:34:32.874Z
---

Charlotte 2026-10-13 (Jones and Baker): "we won't get them from them until we've got the site in a good place and send it to them" and "why do we need their wix logins, I told you at finish we give them DNS instructions".

**Why:** the client only sees the build once it's good (preview link + questions go together). Hosted sites go live by the client pointing their DNS at us from the deliver page (host = DNS instructions), so a Wix, registrar or domain login is never needed. The Hub research brief's "asks" list included a Wix/domain login line; that line is wrong, don't repeat it.

**How to apply:** while building, put real-photo, review, Web3Forms key and accreditation gaps under "goes to the client with the preview", not as blockers or "still waiting on". Never ask for or list Wix/domain/registrar logins; domain = DNS instructions at the end. See [[project_website_delivery_workflow]], [[project_client_area_plan]].

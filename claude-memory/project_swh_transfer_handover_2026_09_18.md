---
name: project-swh-transfer-handover-2026-09-18
description: "SWH is a TRANSFER client, handover build host-proofed + audit 29/29 (09-18), files not sent yet, Web3Forms key still ours"
metadata: 
  node_type: memory
  type: project
  originSessionId: d3093207-ac63-477f-a42a-2d70b1efb989
  modified: 2026-09-18T18:26:56.205Z
---

SWH Electrical (hub_clients id `swh-electrical`) switched to delivery_method=transfer on 2026-09-18. #813 made the build host-proof (index.html, .htaccess with clean URLs + security headers, SITE_URL www.swh-electrical.co.uk) and fixed all audit/Lighthouse items; verified by serving the zip under local macOS Apache (/usr/sbin/httpd, custom conf in scratchpad). Hub audit re-run 09-18 16:00: 29 pass, 4 manual, 0 fail. #816 put open preview questions at the top, answered collapsed.

**Why:** once a transfer site moves it's out of our hands, see [[feedback-audit-security-headers-attribution]].

**How to apply:** SWH have only had the preview link, NOT files. At handover: build zip (exclude build-pages.mjs, meta.json, _*, .vercel, vercel.json, .vercelignore, .gitignore), upload in SiteDetail handover panel, then generate the transfer link (bakes audit into URL). Web3Forms key must be switched to SWH's own first. Deploying the SWH Vercel project is blocked for Claude by auto mode; Charlotte runs `vercel deploy --prod` from the site folder. Speed unscorable (hero opacity-0 fade, NO_LCP) unless fade made transform-only.

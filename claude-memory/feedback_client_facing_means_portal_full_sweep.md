---
name: feedback_client_facing_means_portal_full_sweep
description: "Everything client-facing lives in the portal; never say \"sorted\" without a full inventory of every client page and link across all repos"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0ea6a7cf-0bcc-4ebe-9632-c217b8701115
  modified: 2026-10-15T10:22:23.699Z
---

Charlotte has asked many times for EVERYTHING client-facing to be in the client portal (crew.installrhub.com, behind sign-in). On 2026-10-15 she said: "you assured me all is sorted. yet every day, i find new client facing pages working outside the portal".

**Why:** each fix only covered the pages the session happened to know about (product links, then /review, then report links...), so she kept finding more and lost trust.

**How to apply:**
- Before saying client pages are "in the portal" or "sorted", run a FULL inventory: every public route in marketing-agent src/App.jsx + src/pages/client/ClientApp.jsx + public/ static pages (e.g. public/sitescore), every link the Hub's client emails send (onboarding welcome/chaser, report, audit, go-live, Email client), and installrhub.com (site-installrhub/installrhub-static: /client-mot, /catch-up, /access-call, any ?cid page). Then list each as in portal / redirects to portal / outside.
- Old links for retainer and new-marketplace clients must open the portal or its sign-in, nothing else. Old marketplace clients are Serafim's (batched at end of audit).
- Show her the one complete list, never a drip of "found another one".

Related: [[project_client_portal_ours]], [[feedback_audit_full_page_hidden_and_linked]], [[feedback_check_all_homes_before_saying_missing]]

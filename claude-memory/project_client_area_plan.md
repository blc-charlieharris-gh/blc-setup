---
name: project_client_area_plan
description: "Agreed 10-06 - turn the CREW client dashboard (crew.installrhub.com/<slug>/dashboard, demo data) into the real per-client area, opened by personal link; Email client becomes a short update + one button"
metadata:
  node_type: memory
  type: project
  originSessionId: 80a695d8-d187-47ec-bf37-138c0dcdbe74
  modified: 2026-10-06T11:04:44.891Z
---

Charlotte 2026-10-06: clients need one page "similar to the builder" holding everything: order + status per thing bought, what's waiting on them (onboarding form, access instructions / book access call, previews and site audits to review, approve ads, ready to launch?), their work (website, audit, Google, social, logo), campaign (ads, go-live, weekly report links), book a catch-up. Email client then = short update (what we're waiting on, what they ordered and its status) + "Open your InstallrHub page".

Decisions: access by PERSONAL LINK, no password (like the weekly report ?k= token). Build it by evolving the existing ClientApp/ClientDashboard (src/pages/client, crew host), not a new page; /first-ads and Ready to launch? pages become sections (same RPCs). Order: merge the 10-06 email builders + ad approvals batch first, audit "always true" checks next, then the client area with a short plan for her approval.

**Why:** emails were scattered and clients get several links; one page per client is simpler and one way per thing.
**How to apply:** when this comes up, start from this plan and src/pages/client; reuse lib/clientEmailBuilder status logic, adPreviews, launch requests. Related: [[feedback_no_duplicate_solutions]], [[feedback_public_by_link_pages_rule]].

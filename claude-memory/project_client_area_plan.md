---
name: project_client_area_plan
description: "Client area: one page per client by personal link (built 10-08); 10-11 agreed ONE key per client, every product page under it (/<slug>/website?k=), one Crew by InstallrHub frame, one Add media pop-up"
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

**10-11 update (Charlotte "yes"):** the page exists (crew.installrhub.com/<slug>?k=<page token>, ClientPage), but each product still has its own address and key (/preview/<t>, /logo-delivery/<t>, /social-delivery/<t>, /google-delivery/<t>, /transfer/<t>, /go-live/<t>). Agreed shape: ONE key per client, every product page under their page: /<slug>?k= home, /<slug>/website?k=, /<slug>/logo, /social, /google, /website-files, /go-live (same ?k=); old links redirect. Every client page gets the same "Crew by InstallrHub" top banner (their logo, back to home) and footer, and looks better. Wherever we ask for imagery (website questions, Google, social, home) ONE "Add media" button opening the same pop-up as the home page (client-drive page upload, their Drive folder). Build as its own batch after crew B3b (it is crew audit B6.2 job page frame + B7.1 easy uploads); her message ended on "and", ask what else.

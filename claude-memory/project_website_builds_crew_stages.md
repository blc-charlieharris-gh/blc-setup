---
name: project_website_builds_crew_stages
description: "2026-09-26 Website builds page rebuilt on Crew stage labels + 5 numbered steps (#1027); Google auto-moves back to build when all questions answered"
metadata:
  node_type: memory
  type: project
  originSessionId: 4e3dc7b6-2395-4ab1-853b-6d5b2eae9167
  modified: 2026-09-26T19:36:18.945Z
---

Shipped + live 2026-09-26 (#1027, marketing-agent):
- `/sites` + `/sites/:id` use the Crew stage vocabulary via `src/lib/siteStages.js` (siteState maps hub_clients.status; Being improved = ready_to_preview + signoff_decision requested_changes). Raw statuses unchanged.
- Build page = 5 collapsible steps: Set up, Build and preview, Client approval, Hand over, Review. Audit check lists collapse. Only the delivery-method's hand-over panel shows.
- Removed: Deploy, Intake link, Signoff link, AI generation, Crawl panels, SiteNew page, issueIntakeToken.
- #1030: websites have an extra Paid stage. The client's approval auto-sets Awaiting payment (site-feedback). The go-live link (host) and the handover link + files (transfer) stay locked until staff set Paid. Charlotte: don't mention payment in the client's approval message. On the board, Approved/Awaiting payment/Paid all sit in Ready to go with no paid pill, and Charlotte is fine with that.
- `crew_google_reply` (migration 20260926150000, applied) moves a Google piece ready_for_review -> in_progress when the last question is answered.
- Prospect site audits box KEPT (Charlotte: may be handy).
- #1032 + trigger `hub_clients_answers_back_to_build` (migration 20260926190000, APPLIED): the client's last website answer moves ready_to_preview -> copy_generated. The preview stays live once audited (siteStages previewLive, checked on the page, not in site-public). On the board, requested_changes sits in the build column, and a drop on Awaiting approval clears it. Dead clients-context methods removed.
- Old /intake form: Charlotte doesn't use it, leave it live.
- Why Core's 22 Sep answers never alerted: hub-action-alerts first run 24 Sep baselined all older answers silently. As of 09-26 Charlotte's action_emails still lack question_answered and site_approved (told her).

Related: [[crew-status-alignment]], [[project_site_audit_upgrade]].

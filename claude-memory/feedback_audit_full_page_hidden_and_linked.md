---
name: feedback_audit_full_page_hidden_and_linked
description: Hub audit pages must cover EVERY part - each card checked against live data, folded/hidden sections, modals, the edge fn/cron behind it, and every linked page/email/badge it feeds
metadata:
  type: feedback
---

Charlotte 2026-09-28 after page 6 Status: "make sure this audit covers full pages, hidden pages and linked pages, dont just do half like you did with status". I had audited the lead checks deeply but only reworded Lead fields, Websites and the folded day-by-day section without checking them against data; she found the mismatched totals, false "broken" timeouts and unfair field rules herself.

**Why:** she relies on each page being signed off as correct; a half audit means she finds the bugs.

**How to apply:** before calling a page audited, list every section (incl. folded/collapsed, tabs, drawers, modals, empty/error states, admin vs non-admin views), the edge fns / crons / RPCs feeding it, and every page, badge, email or card it links to or feeds. Check each against live data (does the number mean what the label says, do totals reconcile) and write each one into pages/<page>.md with a verdict. Say explicitly if any part was not checked. Related: [[project_hub_page_audit]], [[feedback_audit_findings_simple_with_options]].

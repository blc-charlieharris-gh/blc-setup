---
name: feedback-audit-scope-checklist
description: "Charlotte's required scope for every Hub audit (retro and new), set 10-09: security, speed/mobile, one source of truth, no app breakage, linked/hidden pages, cross-page, bugs, data accuracy, no hardwiring"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6a33dffe-7abe-450c-b4b9-bfc677a26314
  modified: 2026-10-09T13:59:23.557Z
---

Charlotte 2026-10-09: every audit, retro or new, must cover ALL of these on each page:
1. **Security:** who can see and do what (RLS, grants, admin-only), and no secrets in the browser.
2. **Speed and mobile:** load time and heavy queries; usable at phone and laptop widths.
3. **Data hygiene:** no duplicate things doing similar jobs, no drift or divergence between copies, one source of truth for each fact.
4. **Doesn't break Serafim's side (the app):** shared tables, functions and indexes.
5. **Linked and hidden pages:** pages reached from this one, including ones not on the menu, so none are missed.
6. **Interactions with other pages,** already audited or still to come: they must agree.
7. **Bugs and breakages.**
8. **Data accuracy:** the right source, no assumptions, no typed-name rules ([[feedback_never_classify_by_typed_titles]]).
9. **No hardwiring:** every threshold or metric that could change belongs in Parameters, Settings or SOPs.

Added the same day:
10. **Failures are loud:** an error or warning shows, never a quiet 0 or empty table.
11. **Every change leaves a trail:** History with who and when.
12. **Personal data is safe:** shown only to those who need it, public links never expose others' data, nothing kept longer than needed.

Added 2026-10-12:
13. **Outdated and duplicated features:** two buttons or paths doing the same job (e.g. a job page's own email button beside the one Email the client), or an older way left on the page after a newer one replaced it. One way per thing: fold what the old one did (its side effects, e.g. moving the job's stage) into the one way, then remove the old. Also check live data that every box/field/button is actually used (Performance creative "Purpose & notes": 0 of 2,108 ever filled); never used = propose removal.

She turned down per-page automated smoke tests as an audit item ("if it's blank I just ask you to fix").

**Why:** "we've done so much" and bugs keep landing between audits. She wants one complete pass, not repeat rounds.
**How to apply:** this list is the checklist for every page in every audit. Each finding comes back in the simple format of [[feedback_audit_findings_simple_with_options]], and nothing is fixed until she agrees. It's also kept in the repo at .claude/docs/hub-audit/README.md. Related: [[feedback_build_check_every_pr]], [[feedback_audit_full_page_hidden_and_linked]], [[feedback_audit_end_state_zero_issues]].

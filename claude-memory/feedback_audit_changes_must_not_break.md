---
name: feedback-audit-changes-must-not-break
description: Charlotte must be able to trust audit fixes; an audit change that breaks something (IH Dashboard appointments 09-29) is a serious failure
metadata:
  node_type: memory
  type: feedback
  originSessionId: b59204df-bc2e-490f-8678-99e1bc8acc41
  modified: 2026-09-30T10:12:40.760Z
---

Charlotte 2026-09-30: "I need to trust your audits. If your audits break things or add new problems, that's an issue." Trigger: the 09-29 final audit (#1164, item A16) deleted InstallrHub's Dashboard appointment code as "dead" because IH had no Dashboard option; #1169 merged the same day gave IH its own option, so cost per appointment silently went N/A. The retrospective missed it.

**Why:** she relies on the audit to make the Hub more reliable; every regression it causes costs trust and her time.
**How to apply:**
- Before deleting anything as "dead/unused", grep open and same-day branches/PRs and the current queue for anything that could make it reachable again; prefer leaving it with a comment over deleting when unsure.
- When several PRs merge the same day, re-check each one against the others (the combined main), not each branch alone.
- Retrospective after each page = re-check every PR merged since the last one against the pages it touches, with live numbers (e.g. Dashboard per scope incl. InstallrHub), not only a code read.
- Say plainly when a problem was caused by our own change.
Related: [[feedback-audit-end-state-zero-issues]].

---
name: feedback-say-what-audit-already-covers
description: Before presenting a website rule or check as new, inventory what the site audit already does and say so plainly
metadata:
  type: feedback
---

Charlotte 2026-10-15: "i thought indexing was already sorted for all this through audit? and social sharing? again asked MANY times for the audit process to be refined". I had presented favicon / share card / indexing rules as new when the site check (api/_audit/engine.js) already tested most of it.

**Why:** she has asked repeatedly for the audit to be refined; describing existing checks as new reads as not knowing the system and hides the real gaps.
**How to apply:** before adding a website rule or check, grep the audit's check keys (`add('key'` / `mk('key'` in api/_audit/*.js) and the rule book's CHECK_KEYS, then report "already checked: X; new: Y". Stage 6b's coverage test (src/lib/websiteRules.test.js) now keeps checks and rules matched. Related: [[project-website-rulebook]]

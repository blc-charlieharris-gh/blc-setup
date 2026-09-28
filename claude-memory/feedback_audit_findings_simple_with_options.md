---
name: feedback_audit_findings_simple_with_options
description: "Present audit/review findings simply, each with a proposed fix plus pros, cons and impact; never an open-ended list"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 2207cf9e-b1b7-4849-a16f-6859302e071b
  modified: 2026-09-27T09:57:26.478Z
---

When presenting audit or review findings, give each one as: what's wrong (one plain sentence, no internal jargon like "ad-tagged", "rpcCached", "scope"), then the proposed fix, then pros, cons and what changes for her/clients/Serafim, then MY RECOMMENDATION and why (she relies on it when stuck). When explaining an issue, first say what the feature even is: she builds a lot and forgets. Number them so she can reply by number. Keep technical detail in the findings file, not the chat.

**Why:** 2026-09-27 Dashboard audit summary was "complex to understand and felt open-ended"; she had to ask what several points meant.

**Repeat slip (09-27, Performance PR3):** two DECIDE items were given as bare option lists, no explanation of what the feature is, no pros/cons, no recommendation. Charlotte had to ask again. Applies to EVERY decision handed to her, including the short "decisions for you" at the end of a PR report.

**Third slip (09-27, pages 1-4 rescan):** findings used internal terms ("topped-up", "silent failures", "credits to us") and never said WHERE on screen. Charlotte replied "huh?" to 6 of 10. Every finding must start with the exact place (page > section > card/column), then what it shows wrong in everyday words, with a real example from live data. Drop findings that don't matter in practice (check live first, e.g. attribution links: there are none). Don't re-raise settled business rules (no top-up model: a Green Tide survey handed to a client is a supp survey, cost is ours, never on client reports).

**How to apply:** every page in the Hub audit ([[project_hub_page_audit]]), and any similar review. Also skills/process issues: she wants them handled as part of the work, not presented as a separate decision. Builds on [[feedback_charlotte_plain_explanations]].

---
name: feedback-h1-place-only-home-and-areas
description: Website H1s name the town only on Home and Areas pages; every other H1 says what the homeowner gets
metadata:
  node_type: memory
  type: feedback
  originSessionId: ac067d84-b19c-4082-ab20-706e0779fdb5
  modified: 2026-10-24T20:30:57.801Z
---

On client websites, only the Home page and the Areas page name the place in their H1. Every other page's H1 says what the homeowner gets, in words no other page uses, and no heading ends "in <Town> and <County>". The place stays in each page's title and intro (Charlie, 2026-10-24, Helix Power build).

**Why:** Hub copy had given every page the same "X in Gainsborough and Lincolnshire" H1, which reads like a template.

**How to apply:** When building from a kit, override H1s in the generator (an `H1` map) if the Hub copy still has place-ending H1s, keep titles and intros word for word, and note that the Hub copy needs updating.

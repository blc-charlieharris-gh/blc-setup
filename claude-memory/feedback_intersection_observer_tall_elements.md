---
name: intersection-observer-tall-elements
description: "IntersectionObserver with a % threshold never fires for elements taller than the viewport, so fade-in content stays invisible on phones"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 5c8f1f45-8226-4bf6-978d-a53b35551b63
  modified: 2026-09-29T14:57:09.830Z
---

A reveal-on-scroll pattern (opacity 0 until IntersectionObserver adds `.is-seen`) with `threshold: 0.3` never fired for a fix-list group ~2800px tall on a 390x844 phone: 30% of it can never be on screen at once, so the whole group stayed invisible. Found on /installer-mot 2026-09-29.

**Why:** threshold is a ratio of the element's own height, not the viewport.
**How to apply:** for reveal animations use `threshold: 0` with a negative bottom `rootMargin` (e.g. `'0px 0px -12% 0px'`), and screenshot results at phone width with long content before shipping.

---
name: seedance-garbles-ui-text
description: Seedance rewrites small on-screen/UI text (wrong email, "Gour Business Lttb"); build UI screens in HTML and animate them, Seedance only for word-free visuals
metadata:
  type: feedback
---
Seedance 2.5 start/end-frame clips of app screens (13/10 access videos): small changes (a pop-up opening) stay sharp, but whole-page changes and typing garble text, and it typed the invite email wrong. Overlaying exact text on top fails too: Seedance re-lays-out the screen a few px, so words double up.

**Why:** a how-to video with a wrong button label or email gets copied by clients.
**How to apply:** screens = exact HTML copies animated with puppeteer (meta-access `access-videos/*/work/anim.mjs`, 2x for 4K); Seedance only for backgrounds/B-roll with no words; all text as edit overlays (Charlotte's rule). Related: [[gpt-writes-all-content]].

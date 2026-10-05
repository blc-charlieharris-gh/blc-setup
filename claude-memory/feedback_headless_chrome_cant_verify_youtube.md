---
name: feedback_headless_chrome_cant_verify_youtube
description: Headless Chrome CLI screenshots of YouTube embeds come out blank or Error 153; check the iframe is in the DOM and ask Charlotte to look in a real browser
metadata:
  type: feedback
---

On 2026-10-05 the /webinar/replay YouTube embed rendered in a headless Chrome screenshot once, then came out as an empty box on every later run (live and localhost alike). Opening the embed URL directly shows YouTube "Error 153" (no referrer). No CSP or console errors: YouTube was refusing the headless browser, not the page.

**Why:** a blank video in a screenshot looks like a broken page and wastes time chasing CSP/headers.
**How to apply:** verify embeds with `--dump-dom` (the iframe and its src are there) plus a headers check (frame-src allows https), then give Charlotte a ?preview link to confirm it plays in her browser. Related: [[headless-chrome-window-size-floor]]

---
name: headless-chrome-window-size-floor
description: Chrome CLI headless --window-size below ~500px is silently ignored/floored; use puppeteer-core with a real setViewport for mobile-width testing
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c7c39c79-131d-47df-9b91-2fb3e10aa44c
  modified: 2026-08-27T14:58:57.677Z
---

Plain `google-chrome --headless --disable-gpu --window-size=390,844 --screenshot=...` (or `--dump-dom`)
does NOT reliably render at the requested width when that width is below roughly 500px. The browser
renders at a floor width (~500 CSS px observed) regardless of the requested smaller value, and the
`--screenshot` flag then produces an image file at the REQUESTED pixel dimensions anyway (e.g. a
genuine 390x900 PNG) by cropping the top-left corner of the wider render, not by scaling it down.

**Symptom this causes**: content that legitimately wraps/fits within the real ~500px render appears
"cut off" or "overflowing" at the right edge of the 390px screenshot, because the screenshot only
shows the left 390px slice of a wider layout. This looks exactly like a real CSS overflow bug (text
truncated mid-word, elements missing) but isn't one. Confirmed by injecting a visible on-page
diagnostic (`window.innerWidth`) into the actual page and reading it back via screenshot: it read 500
regardless of `--window-size=390,...` or even `--force-device-scale-factor=1`. `--headless=new` did
not fix it either. Widths at or above ~500px (e.g. 1600px used elsewhere this session) DO work
correctly with this same CLI approach — the floor only bites at phone-width viewports.

**Fix**: use `puppeteer-core` (point `executablePath` at the existing installed Chrome, no need to
download a bundled Chromium) and call `page.setViewport({ width, height, deviceScaleFactor, isMobile:
true, hasTouch: true })` before `page.goto()`. This renders at the exact requested width — verified
`window.innerWidth` reads correctly (e.g. 390) once done this way, and previously-alarming "overflow"
disappeared entirely once the real viewport was used. `npm install --no-save puppeteer-core` in a
scratch directory is enough; no new project dependency needed for one-off mobile testing.

**How to apply**: any time you need to visually test or screenshot a page at a mobile/narrow viewport
(≤~500px) via headless Chrome, don't trust the plain CLI `--window-size` flag — use puppeteer-core
with `setViewport` instead. For desktop-width screenshots (≥~500px), the plain CLI flag is fine and
was used successfully many times this same session.

**Quicker alternative (2026-10-07, worked)**: no install needed. Write a scratch wrapper page served by the same local static server with `<iframe src="/page?preview=1" style="width:390px;height:1500px;border:0">` (several side by side for 390/768), and screenshot the wrapper with the plain CLI at a wide window. Inside an iframe the page's viewport is the iframe's width, so media queries hit phone widths exactly. Caveat: a tall iframe makes `min-height:100vh` sections tall, so extra space above centred content is an artifact. Delete the wrapper before committing.

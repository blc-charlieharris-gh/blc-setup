---
name: feedback_headless_chrome_canvas_tests
description: "Headless Chrome canvas/SVG checks hang unless frames run; it can't reach Supabase storage from the sandbox; big PNGs stall"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 55c5e2e4-3164-48d5-961b-b7160ec7cd7b
  modified: 2026-10-21T12:09:10.830Z
---

Checking canvas drawing (finance strip, logos on downloads) in headless Chrome on the Mac (2026-10-21):
- `img.decode()` (SVG logos via coverCompose logoImage) never resolves without `--run-all-compositor-stages-before-draw --virtual-time-budget=30000`.
- Chrome can't fetch Supabase storage URLs from here (curl can): copy files into `public/__tmp` and serve them through a vite dev server on a spare port.
- `createImageBitmap` on a ~2.5MB PNG stalls under virtual time: shrink it with `sips -Z 1200` first.
- `--screenshot` comes back blank; write the result into the DOM as a data URL, `--dump-dom`, then base64-decode it.

**Why:** an hour went on blank screenshots before the cause was found.
**How to apply:** use this recipe for any visual check of browser canvas code; delete the `public/__*` files afterwards. Related: [[feedback_headless_chrome_window_size_floor]]

---
name: feedback-public-client-link-needs-crosshost-route
description: "In marketing-agent, any new public token-scoped link sent to a client (not opened from inside the hub) must be handled in App.jsx's cross-host early-return block, or it silently 404s on crew.installrhub.com"
metadata:
  type: feedback
  originSessionId: 51270093-683e-4896-8b2e-04b4672503df
  modified: 2026-08-25T10:37:48.025Z
---

`src/App.jsx` branches on hostname before rendering routes: `crew.installrhub.com` renders `<ClientApp />` entirely (a different route tree), `website.installrhub.com` renders a narrow route set (only `/preview/:token`), and everything else (`internal.installrhub.com`, the bare vercel.app URL) gets the full staff `Routes` tree. `/intake/:token` and `/signoff/:token` live in that last, staff-only tree — they only resolve on `internal.installrhub.com`, never on `crew.installrhub.com`, which is fine for those two because staff already know to open them from inside the hub.

Built a new public form (`/review/:token`) by copying the `/intake`/`/signoff` pattern exactly, including their route placement. Wrong call: this new link is *sent to the client*, who will open it from wherever the mint UI displayed it, and the mint UI (`ReviewLinkPanel`) is only ever viewed on `internal.installrhub.com` (staff work there). So the link staff copied was an `internal.installrhub.com` URL, and clicking it would hit `CLIENT_MODE`'s `<ClientApp />` on `crew.installrhub.com` if the link's default host were ever `crew.*`, or would 404 for the client if the host stayed `internal.*` and they're not staff. Either way it doesn't reliably resolve for a client the way `/preview/:token` does.

**Why:** `/preview/:token` already solved this exact problem — it's handled in an early `if (pathname.startsWith('/preview/'))` return *before* the `CLIENT_MODE`/`WEBSITE_MODE` host branches, so it resolves identically regardless of host. `previewUrl()` in `clientIntake.js` also defaults to `crew.installrhub.com` specifically (not `window.location.origin`) so the URL staff copy is always the client-reachable one, not wherever staff happen to be viewing the hub from.

**How to apply:** before adding any new public token-scoped route, ask whether it's (a) opened by staff from inside the hub (→ default branch is fine, `signoff`/`intake` precedent) or (b) sent to and opened by someone outside the hub (→ needs the `/preview/`-style cross-host early-return, and its URL-builder should default to `crew.installrhub.com`/`VITE_WEBSITE_URL`, not `window.location.origin`). Caught this one only because the user manually tested the link and got "Failed to fetch"/wrong-host confusion — it wasn't caught by lint, build, or code review, since the code was syntactically correct and worked fine for staff testing it from `internal.*`.

2026-09-22 repeat: /google-delivery/:token was moved to crew.installrhub.com (googleDeliveryUrl) without an early-return route in App.jsx, so crew showed the InstallrScore landing page. curl returned 200 (it's an SPA shell), which proves nothing. Any new client link on crew needs the pathname early-return next to /preview/ and /review/. Verify with ?crew=1 locally in puppeteer, not curl.

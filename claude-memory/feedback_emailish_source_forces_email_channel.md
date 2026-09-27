---
name: feedback-emailish-source-forces-email-channel
description: "track.js's deriveChannel() forces the email channel off bare utm_source values (nurture/resend/ghl/email) regardless of utm_medium, so a new non-email medium reusing one of those source strings gets silently miscounted"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 455b5539-c5f7-4f75-b5b4-d3e9f27b046f
  modified: 2026-09-08T11:36:14.683Z
---

`site-installrhub/installrhub-static/js/track.js`'s `deriveChannel()` has this check near the top:

```js
if (medium.indexOf('email') === 0 || src === 'email' ||
    src === 'resend' || src === 'ghl' || src === 'nurture') return 'email';
```

The `src === ...` half is unconditional on medium. Any link whose `utm_source` is exactly `nurture`, `resend`, `ghl`, or `email` gets classified as the email channel no matter what `utm_medium` says.

**Why:** these four systems used to only ever send email, so the source alone was a safe enough proxy. That stopped being true 2026-09-03 (nurture engine SMS shipped, see [[reference_nurture_engine]]) and again 2026-09-08 (nurture-sent WhatsApp added to the Link Builder). Building a WhatsApp/SMS link with `utm_source=nurture` would have silently landed in the Email channel row on the Sources dashboard, exactly the kind of miscount `EMAILISH_SOURCES` in `marketing-agent/src/lib/sources.js` was already built to warn about for the medium side ([[feedback_email_channel_exact_match]] is the sibling `utm_medium` version of this), but nobody had extended the same defense to the source side until this bit us.

**How to apply:** if a new link-generation path (Link Builder preset, a new automation) reuses `nurture`/`resend`/`ghl`/`email` as `utm_source` for a send that ISN'T actually email, suffix the source (e.g. `nurture-sms`, `nurture-whatsapp`) so it doesn't literal-match. Keep `EMAILISH_SOURCES` in `marketing-agent/src/lib/sources.js` and this list in `track.js` in step, both files say so in their own comments. Check both before adding a new automated-send channel.

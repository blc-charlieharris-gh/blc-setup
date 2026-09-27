---
name: feedback_unique_slug_from_content
description: "Deriving a globally-unique slug from a human name (utm_content, post name) guarantees collisions; use a random token and keep the meaning in other columns"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 23fb8fb7-279b-452d-91af-528df3f767d1
  modified: 2026-08-10T08:26:44.893Z
---

If a column is **globally unique** and its value is derived from a **human-chosen name**, it will
collide, because people reuse names across contexts. Marketing-agent's short links had
`suggestSlug` build `/go/<slug>` from `utm_content`, so the first YouTube bio link named
`installrhub` burned `/go/installrhub` for LinkedIn, Facebook and every future link with that name.
The user spotted it immediately: "surely its just a little short link like what bit.ly would produce?"

**Why:** the slug is an *identifier*, not a *description*. The description already lived in
`label` and the `utm_*` columns, so making the slug meaningful bought nothing and cost uniqueness.

**How to apply:** default to a random token (`randomSlug()`, 7 chars, alphabet with `0/o/1/l/i`
removed so it survives being read off a screen); let a custom vanity value override it. Retry a
*generated* collision silently, but report a *custom* one, the user needs to know their chosen name
is taken. Watch for the same shape anywhere a unique key is auto-suggested from user text.

Related: [[feedback_silent_fallbacks_hide_dead_features]] (the `utm_campaign` field on the same
page is captured everywhere and reported nowhere).

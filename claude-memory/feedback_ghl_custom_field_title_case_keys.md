---
name: ghl-custom-field-title-case-keys
description: "GHL custom fields sometimes land in raw as human Title Case with spaces (\"Converted Page\"), not the snake_case the mapping doc used; verify against a real lead before trusting a guessed key name"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3f6cf303-cf2e-4e5a-80c8-15b817c493fb
  modified: 2026-08-19T12:50:11.657Z
---

When a new n8n → GHL custom-field mapping is added and no real lead has come through it yet, the actual JSON key it lands under in `raw` cannot be assumed from the field's snake_case doc name. Wired `converted_page` into marketing-agent's Journeys view (`sources.js`) the same day the mapping was added; the first real lead (Oliver Wilson Property Ltd, 2026-08-19) showed the key as `"Converted Page"` (title case, with a literal space), matching the pattern of GHL's OTHER auto-generated custom fields already visible in the same payload (`"UTM Medium"`, `"UTM Content"`, `"Job Type "`). The code read `t.converted_page` and got nothing until corrected to check `t['Converted Page']` first.

**Why:** GHL auto-generates a field's storage key from its display label unless the workflow explicitly overrides it. Established fields like `ih_channel`/`utm_source` are snake_case because those were deliberately named that way at creation; a newly-added ad hoc field (like this one) inherited GHL's default title-case-with-spaces behavior instead.

**How to apply:** After wiring any brand-new GHL custom-field mapping into a reader, do not trust the assumed key name until at least one real lead has landed. Query `raw` on the first real row and read the literal key back before shipping the display code, or ship the reader checking both the assumed snake_case key AND a title-case-with-space fallback from day one. See [[feedback_hardcoded_raw_whitelists_drop_payloads]] for the related (but distinct) failure mode of a webhook dropping fields entirely rather than just misreading their name.

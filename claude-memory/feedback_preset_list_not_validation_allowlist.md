---
name: feedback-preset-list-not-validation-allowlist
description: "A UI's quick-pick preset list (e.g. RETAINER_MONTHS=[3,6]) is not automatically a validation allowlist — check whether an out-of-list value should be rejected/passed through or silently coerced"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 696dfa91-015b-4c1c-8308-6a8e631cf4a2
  modified: 2026-09-18T08:24:16.320Z
---

Found in `marketing-agent/src/lib/onboardingPackages.js` (2026-09-18): `RETAINER_MONTHS = [3, 6]`
was defined as the two quick-pick buttons a package-picker UI shows, but `normaliseOffer()` also
used `RETAINER_MONTHS.includes(raw?.retainerMonths)` as a validation gate — any retainer length
outside 3/6 (e.g. a sales-declared 9-month deal) silently fell back to 3, with no error anywhere.
This had been live since the 2026-09-17 offer model shipped, undetected until Charlotte asked for
custom-length support and the gap was traced.

**Why:** a constant that looks like "the allowed values" often started life as "the values a picker
button offers", and the two purposes get conflated in one `.includes()` check. The bug is invisible
in normal testing because the fallback is a plausible-looking real value (3 months), not an error.

**How to apply:** when validating a field against a list of presets, ask explicitly: should a value
outside the list be REJECTED (throw/reject), PASSED THROUGH (any positive number is fine, the list
is just UI convenience), or genuinely CLAMPED (business rule says only these values are valid)?
Don't assume the third case by default just because a list already exists in scope. The fix here:
`RETAINER_MONTHS` stays as the UI preset pair, but the actual normaliser now accepts any positive
integer, falling back to 3 only on a genuinely missing/non-numeric value.

---
name: feedback_source_scan_test_string_match_fragile
description: "ClientOnboarding.test.js scans raw source text for literal `step.key === '<key>'` / `data.xxx:` patterns — a same-string comment or unrelated code line breaks it silently"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 133aee38-d26f-41b1-bb4d-e755eef68c17
  modified: 2026-08-25T15:18:15.892Z
---

`marketing-agent/src/pages/public/ClientOnboarding.test.js` has two source-scanning tests (`rendersErrorProp`, and the "every collected field is submitted" test) that do `SRC.indexOf(\`step.key === '${key}'\`)` or regex-match `data.xxx` / `xxx:` across raw file text, not AST parsing. They find the FIRST textual occurrence.

**Why it bites:** adding an unrelated line that happens to contain the same literal substring earlier in the file (a JSX className conditional, a comment explaining the pattern, even a second `const isX = step.key === 'x'` helper) makes the scanner latch onto the wrong occurrence and the test fails with a confusing message pointing at the real render block, which is untouched. Hit this twice in one session: once adding `step.key === 'coverage'` inside a className ternary, once writing a comment that explained the scanner using the exact literal it searches for.

**How to apply:** before adding ANY new line containing `step.key === '<existing-step-key>'` or `data.<fieldname>` to `ClientOnboarding.jsx` or a file under `components/hub/onboarding/`, check whether it's earlier in the file than the real render/field-write line. Prefer a named constant/variable (`const isCoverageStep = step.key === COVERAGE_STEP_KEY`) over repeating the literal, and when writing an explanatory comment about the scanner, don't reproduce the exact search string, describe it structurally instead (as this memory itself does).

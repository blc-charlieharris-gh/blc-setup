---
name: feedback_template_literal_backtick_crash
description: A backtick inside a JS template-literal string (even in a CSS/HTML comment) crashes the whole module; how the InstallrHub blog went down
metadata: 
  node_type: memory
  type: feedback
  originSessionId: abb305e4-98ac-4641-82a4-26eb4e794ede
---

2026-07-24: the public InsightsHub blog (`site-installrhub/installrhub-static/api/blog.js`, a Vercel
serverless fn) returned HTTP 500 `FUNCTION_INVOCATION_FAILED` on EVERY `/insightshub` request. Main site
was fine, so it looked data-related, it was not.

**Root cause:** PR #43 added a CSS comment `/* ... Quill \`video\` blot ... */` INSIDE a giant backtick
template literal that builds the HTML page. The backticks around `video` closed the template string early,
so `video` parsed as code and the module failed to PARSE. A parse error = the function never loads = 500
on every call.

**Fix:** removed the backticks from the comment. `node -e "require('./api/blog.js')"` then parsed clean.

**How to diagnose fast:** for `FUNCTION_INVOCATION_FAILED`, reproduce locally: `vercel env pull` (dir was
linked, project `installrhub-site`), then `node -e "require('<fn>')"` to get the real stack. A module-load
SyntaxError points at the offending line. **Why:** template literals are parsed for `${}` and backticks
regardless of being "inside a comment", comments only exist after successful tokenising.

**How to apply:** never put a raw backtick inside a `` `...` `` template literal, including in CSS/HTML
comment text. Use single quotes in comments. Watch for this in any file that builds HTML via template
strings. See [[feedback_commit_via_temp_index_on_main]] for the site-installrhub deploy (push to `main`,
Vercel auto-deploys).

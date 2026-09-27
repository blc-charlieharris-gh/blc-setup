---
name: reference_supabase_log_sources
description: "Supabase's query_logs 'source' field is easy to pick wrong: edge_logs is PostgREST/REST table traffic, function_edge_logs is actual edge Function HTTP requests, function_logs is console.log/warn output"
metadata:
  type: reference
  originSessionId: 73927149-6fd2-4589-a2cc-2836113068a6
  modified: 2026-09-03T16:26:59.829Z
---

`mcp__supabase__query_logs` (or the dashboard's Logs explorer) exposes several `source` values that sound interchangeable but hold completely different data:

- **`edge_logs`** — despite the name, this is the **PostgREST/REST API gateway** log: every direct `GET/PATCH/POST .../rest/v1/<table>` call, i.e. the browser talking to Supabase tables directly. It has NOTHING to do with Edge Functions. Querying it for `%my-function-name%` will reliably return zero rows even when that function is being hit constantly.
- **`function_edge_logs`** — this is the actual **Edge Function** request log: one row per invocation, `event_message` formatted as `METHOD | STATUS | full-url`. This is what shows the real HTTP status a caller (e.g. GHL, n8n, a browser fetch) actually received back from a function, independent of whether the function's own code logged anything.
- **`function_logs`** — the function's own `console.log`/`console.warn` output plus Deno runtime lifecycle noise (`booted (time: Nms)`, `shutdown`). If a function doesn't `console.log` much, this mostly shows boot/shutdown spam and nothing useful for tracing a specific request.

**Why this bit us (2026-09-03):** diagnosing a nurture-engine GHL webhook that seemed to vanish with no trace, first tried `function_edge_logs` searching for the wrong text (an app-level string, not a URL-shaped one) → false empty. Then tried `edge_logs` searching for the function name → false empty again, because that source only carries `/rest/v1/*` traffic. Only got real signal by re-querying `function_edge_logs` with a URL-shaped filter (`%functions/v1/<name>%`), which immediately showed the true response status codes (including a same-second sanity-check request fired deliberately, confirming the query actually worked).

**How to apply:** when tracing what a specific edge function actually received/returned, always use `source = 'function_edge_logs'`, filtering `event_message` on the function's full URL path (`functions/v1/<name>`), not a bare function-name substring or an application-level string. Use `function_logs` only for the function's own explicit log statements. Never trust `edge_logs` for anything Edge-Function-related — confirm with a throwaway request to the function first (should appear within a query issued shortly after) if a "zero results" finding needs to be trusted as a true negative rather than a wrong-source query.

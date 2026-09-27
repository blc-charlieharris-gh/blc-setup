---
name: clients-list-cache-excludes-jsonb
description: "hub_clients' HUB_CLIENT_COLUMNS deliberately omits heavy jsonb columns (info_requests, audit, crawl_data, form_data) from the list-view fetch; any read-modify-write mutation that merges against the `clients` context state instead of a fresh DB read will silently data-loss that column on the first write after a page refresh"
metadata:
  type: feedback
  originSessionId: c3b34899-d0f2-4b1c-b54f-61452cead0eb
  modified: 2026-08-18T07:26:38.787Z
---

`src/context/clients/_helpers.js`'s `HUB_CLIENT_COLUMNS` intentionally excludes heavy jsonb columns (`info_requests`, `audit`, `crawl_data`, `generated_copy`, `form_data`, etc.) from the list-view SELECT that populates `ClientsContext`'s `clients` state. `SiteDetail.jsx` re-fetches the single row with `select('*')` to render the real value, so the UI always looks correct.

But `clientCrudSlice.js`'s `addInfoRequest(id, ask)` used to do `row = clients.find(c => c.id === id)` then append to `row.info_requests` and write the merged array back. After ANY page refresh, `clients` never had `info_requests` populated at all (not stale, genuinely absent by design), so `list` was always `[]` on the first call post-refresh, and the write overwrote the DB column with just the one new item, silently deleting every prior request/reply. Confirmed live: 2026-08-18, Gas Worx's info-requests thread. This has nothing to do with React stale-closure timing (crudSlice IS memoised on `[clients, user]` and gets fresh state); the list state itself is missing the column.

**Why:** the column exclusion is correct and intentional (`SiteDetail re-fetches the row with *`, per the file's own doc comment), but any *mutation* slice that does read-modify-write on one of those excluded columns inherits the bug unless it sources its merge base from somewhere else.

**How to apply:** before writing a read-modify-write mutation against `clients` state for any column NOT in `HUB_CLIENT_COLUMNS`, do a fresh single-column DB read as the merge base (see `currentInfoRequests()` in `clientCrudSlice.js` for the pattern) instead of trusting local context state. Same risk applies to `audit`, `crawl_data`, `form_data`, `generated_copy` if a future method ever needs to append/merge into them rather than overwrite wholesale.

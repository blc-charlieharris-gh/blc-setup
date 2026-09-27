---
name: postgrest-column-select-gate
description: "Adding a column to an explicit PostgREST SELECT list before its migration applies 400s the whole fetch, so read-list changes must ship WITH the migration"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: abb305e4-98ac-4641-82a4-26eb4e794ede
---

A PostgREST `select=` that names a column which does not exist yet returns a 400 and the ENTIRE fetch
fails (not just that field). So when a new column is added behind a Tier-2 migration Serafim hasn't
applied, you must NOT merge the frontend change that adds it to an explicit column list ahead of the
migration, or the whole table read breaks in prod.

**Concrete case (2026-07-25):** `crew_clients.intake_status` was added to `CREW_CLIENT_COLUMNS` (the
roster SELECT in `src/context/crew/_helpers.js`). If that merged before migration
`20260725120000_crew_intake_status_and_storage`, the crew_clients roster fetch would 400 and the whole
CREW workspace would fail to load.

**How to apply:** bundle any explicit-column-list read change onto the SAME Tier-2 branch as the
migration that adds the column (they land atomically). WRITES degrade more gently (a PATCH to a missing
column errors but is `console.warn`'d, not thrown, per context invariants), but READS that name the
column are hard failures. See [[feedback_rls_needs_table_grant]] for the sibling GRANT gotcha.

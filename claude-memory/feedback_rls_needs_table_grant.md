---
name: feedback_rls_needs_table_grant
description: "clients writes fail 'permission denied' NOT from a missing table grant but a COLUMN-allowlist by design; has_table_privilege reads false against a working allowlist and misleads. Fix = add the column to the allowlist, never GRANT UPDATE on the whole table."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: abb305e4-98ac-4641-82a4-26eb4e794ede
---

**CORRECTED 2026-07-28 (Serafim).** My earlier read of this was WRONG and it disguised the diagnosis for four days. The `public.clients` write bug ("permission denied for table clients" on a Save) was NEVER a missing table-level UPDATE grant.

**Real root cause:** migration `20260603000000` deliberately REVOKES table-wide UPDATE and grants a **column allowlist** (clients is shared with the InstallrHub app, so a table-wide grant would expose every column). The Save failed because `target_cplb` + `meta_ad_account_id` were simply never added to the allowlist. Serafim fixed it additively (`clients_column_grants`, 2026-07-28): added those columns (+ later `company_id`) to the allowlist. `tier` is deliberately still not writable.

**The trap:** `has_table_privilege('authenticated','public.clients','UPDATE')` reads **false** even against a working column allowlist (it only sees table-level grants). I probed with it repeatedly and kept "confirming" the grant was missing. Use `has_column_privilege(role, table, column, 'UPDATE')` per column instead.

**How to apply:** for a client-side write that 403s, the fix is to ADD the specific column to the allowlist grant, NOT `GRANT UPDATE ON public.clients TO authenticated` (that would over-expose a shared table). When adding a new editable client field, add its column to the allowlist. Related: [[reference_marketing_rpc_guards]], [[feedback_never_starve_shared_prod_db]].

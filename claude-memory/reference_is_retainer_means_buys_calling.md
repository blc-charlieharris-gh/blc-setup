---
name: reference_is_retainer_means_buys_calling
description: "companies.is_retainer does NOT mean 'pays a retainer', it is written as core==='leadcall' so it records 'buys the CALLING service'; lead-only clients like National Eco are retainers with the flag false"
metadata: 
  node_type: memory
  type: reference
  originSessionId: c91c1782-3fca-4ce8-a167-29b62433e2ae
  modified: 2026-08-07T14:41:18.400Z
---

`companies.is_retainer` is a misnomer. `packagesToFlags` writes it as exactly
`core === 'leadcall'`, so it records **"buys the calling service"**, not "pays us monthly".

A retainer client is one who pays monthly for us to run their ads, whether or not we also call
their leads. **National Eco is lead-only, pays monthly, and is absolutely a retainer**, yet the
column reads false. Charlotte corrected me on this on 2026-08-07 after I first derived the badge
from `packages.calling` and hid National Eco's badge.

**The reliable test for "is this a retainer":** do they buy leads from us at all, i.e.
`packages.leads || packages.calling`. That is what the hub's Clients page uses
(`isRetainer` in `src/lib/clientWorkspace.js`). `clients.tier === 'retainer'` agrees.
Website-only clients are not, because we run no ads for them.

**The column and the packages also drift.** Gas Worx and LJP Plumbing both carry
`packages.calling = true` with `is_retainer = false`. The Clients page raises a
`retainer_mismatch` chip where the two disagree, deliberately rather than papering over it,
because the COLUMN is what billing and app.installrhub read. The hub showing the truth while the
app reads the misnamed column means the two surfaces disagree ON PURPOSE until Serafim renames
or redefines it (on his 2026-08-07 list).

See [[project_serafim_outstanding_2026_07_29]], [[project_client_onboarding_engine]].

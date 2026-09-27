---
name: reference_retainer_client_coding_inconsistent
description: "companies.is_active means MARKETPLACE OFFER-ELIGIBLE (register-installer sets it as isMarketplaceClient), not 'is this client live'. Setting it to unarchive a company enrols them in offers."
metadata: 
  node_type: memory
  type: reference
  originSessionId: 8e34c854-5fd9-4b1b-8804-640c2307575b
  modified: 2026-08-12T14:12:52.769Z
---

**`companies.is_active` = can be offered marketplace surveys.** Settled 2026-08-12 by reading the
deployed `register-installer`, which writes it on both the new-company and prospect-stitch paths as:

```
is_active: isMarketplaceClient, // offer-eligible only if they buy marketplace leads
```

So it is NOT a general "is this a live client" flag, and a retainer-only client reading `false` is
correct, not drift. **Setting it true to unarchive a company also enrols them in marketplace offers.**
That is exactly what happened to SWH Electrical when Serafim unarchived them in August.

Ground truth from Charlotte 2026-08-12: of the five live/onboarding clients, **only Gas Worx is both
marketplace and retainer**.

| Company | `is_active` | `packages.pps` | offers | verdict |
|---|---|---|---|---|
| Arktek | false | false | n/a | correct |
| Gas Worx | true | true | 92 | correct |
| HQ Group | false | false | n/a | correct |
| LJP Plumbing | true | true | 43, last 08-04 | WRONG, converted to retainer |
| SWH Electrical | true | false | 0 | WRONG, unarchiving side effect |

LJP **converted** marketplace -> retainer: offers stop 08-04, retainer flag lands 08-07. Their
`pps: true` is a true fact about their past. Handed to Serafim, not fixed by us, because `is_active`
drives his marketplace.

**I nearly flipped Arktek's `is_active` to true before finding this**, on the theory it was backfill
drift. It was correct all along. The lesson that generalises: find the WRITER of a flag before
reasoning about what its values ought to be.

Six targeting RPCs filter on `c.is_active` (`targeting_installer_locations`,
`targeting_claims_by_installer`, `targeting_postcode_flow`, `targeting_postcode_flow_weekly`,
`targeting_lead_locations`, `targeting_booked_locations`), so retainer-only clients are invisible to
targeting intelligence. Separate decision about those functions.

See [[reference_is_retainer_means_buys_calling]], [[reference_client_billing_models]].

**Update 2026-09-25:** the Hub's own code reads `companies.is_marketplace` (not `is_active`) for "marketplace", and BOTH flags can disagree with what was sold: National Eco is `is_marketplace=true, is_retainer=false` but `packages.offer='retainer'`. For anything the Hub decides (e.g. `clients.tier` 'marketplace', migration 20260925140000), derive from `companies.packages` (offer / surveysIncluded / surveysCount), not the flags.

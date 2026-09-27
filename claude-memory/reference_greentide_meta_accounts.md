---
name: reference_greentide_meta_accounts
description: Green Tide runs TWO Meta ad accounts (main + Back Up); the PPL backup campaigns live in the separate account
metadata: 
  node_type: memory
  type: reference
  originSessionId: 9bf7dbbe-2310-49f1-b143-d5e3b701c8b8
---

Green Tide's Meta ads are split across **two** ad accounts, both readable via the `meta-access` token (which can see 7 accounts total incl BLC Promotions, National Eco, My Energy Care, Retrofit Group):

- **Green Tide Energy** (main) = `act_419073311249744`. Hardcoded as `META_AD_ACCOUNT_ID` in `meta-access/.env`. Holds the `2026 Solar`/`2026 Heat Pumps` Instant Form + Landing page campaigns.
- **Green Tide Back Up** = `act_1278923346535596`. Holds the `Back Up 2026 Solar – PPL` and `Back Up 2026 Heat Pumps – PPL` campaigns (adset `England - Instant Form <tech>`). This is the "backup" the team refers to. NOT in the main account, so a search of the main account for "back up" returns nothing.

When asked to check/edit "the backup" campaign, point queries at `act_1278923346535596`, not the default account. The `meta_api.py` helpers are hardcoded to the main account, so hit the backup account with direct `requests` to the Graph API.

The meta-access token can READ and EDIT adset targeting, but CANNOT create saved audiences (Graph error #3, "application does not have the capability"). Saving an audience is a manual Ads Manager step. See [[reference_resend_installer_sends]] for the other GT tooling token.

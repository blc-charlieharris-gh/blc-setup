---
name: installrhub-meta-account-not-in-env
description: "InstallrHub's Meta ad account ID and the fact meta-access/.env doesn't map it — must override META_AD_ACCOUNT_ID explicitly"
metadata: 
  node_type: memory
  type: reference
  originSessionId: e4509f95-55ae-41a5-b43e-99fb0f626b02
  modified: 2026-09-04T12:14:55.972Z
---

InstallrHub's Meta ad account is `act_7095438517245067` (confirmed via `marketing-agent` CHANGELOG.md and `clients.meta_ad_account_id`; ~£76k lifetime spend). The `meta-access/.env` `ACCOUNT_*` map only lists Green Tide, My Eco Move, My Energy Care, Renerji, Retrofit Group, Eco Green Upgrades — **InstallrHub is missing**, and the file's `META_AD_ACCOUNT_ID` default is Green Tide (`act_419073311249744`).

**Why:** `meta_api.py` reads `META_AD_ACCOUNT_ID` from the environment at import time (`os.environ["META_AD_ACCOUNT_ID"]`), and `load_dotenv()` defaults to not overriding an already-set env var. Any script/query touching InstallrHub campaigns must set `os.environ["META_AD_ACCOUNT_ID"] = "act_7095438517245067"` *before* `import meta_api`, or it silently queries Green Tide instead.

**How to apply:** Before any meta-access script run for InstallrHub, override the env var explicitly (or pass the account id directly if a function supports it). Consider adding `ACCOUNT_INSTALLRHUB=act_7095438517245067` to `meta-access/.env`'s account map to close this gap. See also [[project_meta_access_installrhub_mof_tof_campaigns]].

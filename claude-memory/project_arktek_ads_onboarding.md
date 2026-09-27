---
name: project_arktek_ads_onboarding
description: "Arktek onboarded as ads retainer client 2026-07-16; data now syncing after a single-client meta-sync; access was fine (shared token), earlier \"needs a grant\" theory was wrong"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1a8ed7c6-2687-4a83-9559-79fb3caafd7b
---

Arktek added to the `clients` table 2026-07-16 (id `3fd208fd-5b23-4215-b8ba-7b415d4929e7`, `meta_ad_account_id=act_1356131912961185`, tier retainer, is_active+is_tracked). **lead_only should be FALSE**: Arktek is a retainer we run/call for, so leads AND surveys go into our DB (GHL → lead_intake_events), same as Greentide/Retrofit. (It came in via the Parameters Add-Client card as lead_only=false, which is correct.)

**Resolved: data is syncing.** First manual full meta-sync missed Arktek only because its `clients` row was created (06:44) right as the sync snapshotted the client list, so it had no sync_runs row (not started, not failed — simply not reached). A targeted single-client run fixed it: `POST /functions/v1/meta-sync {client_id, wait:true}` returned campaigns:1, adsets:1, ads:5, insights:5. Now that the row exists, the nightly 03:04 UTC cron keeps it fresh automatically.

**Correction to an earlier wrong theory:** I initially thought BLC's Meta system user lacked access because Arktek's ad account is owned by a client business ("Arktek Group Ltd New", business 1342201060670600). That was wrong. `meta-sync` uses ONE shared `META_ACCESS_TOKEN` (function secret), not per-client system users, and client-owned accounts sync fine on it (HQ Group's account is client-owned too and syncs). Access was never the blocker.

Account facts: GBP, Europe/London, one ACTIVE campaign "BLC Solar Leads" (objective OUTCOME_LEADS), ~£39.96 spent as of 2026-07-16, brand new (few/no lead conversions yet). Arktek also exists as a website-only CREW client (`crew_clients.arktek`). To force a manual per-client refresh in future: single-client meta-sync as above. See [[feedback_meta_lead_counting]], [[project_crew_workspace]].

2026-09-21: Arktek website delivered and transferred (Charlotte). Untracked duplicate logo folder website-factory/clients/arktek/arktek-new-logos/ deleted; the same 11 accreditation logos stay committed on main at website-factory/arktek-new-logos/.

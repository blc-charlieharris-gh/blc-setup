---
name: reference-arktek-mcs-status
description: "Arktek's verified accreditations — MCS NAP-64364 + HIES (solar/battery only), TrustMark 1386144 (insulation/boilers, NOT solar), Google 3.8/62; NO manufacturer approvals, NO Boiler Upgrade Scheme"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 2dd84bf0-a7a8-4a8b-8294-f653f238673d
---

Verified 2026-07-14 against public registers. Arktek Group Limited, CH 09877542, Unit JC9 Jupiter Centre, SR5 2TA, info@arktek.co.uk, 0191 516 6911.

## Safe to publish
| Credential | Detail | Scope — this differs per scheme and MATTERS |
|---|---|---|
| **MCS** | **NAP-64364**, via NAPIT (installer_id 15255) | Solar PV + battery **only** |
| **HIES** | On the public member register | Solar PV + battery |
| **TrustMark** | Licence **1386144**, British Assessment Bureau, active | Insulation + gas boilers + heating controls. **NOT solar** |
| **Google** | **3.8 stars, 62 reviews** | Profile is **unclaimed** by Arktek |

## Must NOT publish
- **Boiler Upgrade Scheme / £7,500 grant** — they are NOT registered. Not MCS for heat pumps either. A heat pump customer of theirs gets NO grant. Say so plainly rather than imply otherwise.
- **"TrustMark registered for solar"** — false. TrustMark covers their insulation/boiler work.
- **Manufacturer approvals** (Tesla/GivEnergy/SolarEdge etc) — NOT FOUND, they hold none.
- **Install count / "XX+ homes upgraded"** — no public figure exists. Do not invent.
- **Gas Safe licence number** — could NOT be verified (gassaferegister.co.uk sits behind Imperva and 403s all automated requests, even its homepage). They claim Gas Safe on their own site and their TrustMark gas-boiler licence corroborates it, so an unnumbered badge stands, but a number needs a human 30-second check.
- **Which? / Checkatrade / Trustpilot ratings** — all delisted or non-existent. Their own site still implies Which?/Checkatrade; that's stale.
- **"Green Deal approved"** — their own site says this. Green Deal is a **defunct scheme**. Don't repeat it.

## The commercial point
MCS is not legally required to *fit* solar. It gates the **money**: no MCS = no Smart Export Guarantee (customer never gets paid for exported power). Arktek's own website mentions **neither MCS nor HIES**, so they are sitting on the single strongest solar credential and not using it. That's the lead argument on the new homepage.

## Decisions taken (Charlotte, 2026-07-14)
- **Google rating stays OFF the site.** 3.8/62 is below what a solar buyer expects and would cost more than it earns. Arktek to claim the profile and run a review drive; revisit above 4.5. No `aggregateRating` in schema until then.
- **Do not raise their stale claims** ("Green Deal approved", Which?, Checkatrade) with Arktek. Just build the new site correctly.

- **Heat-pump grant callout: PARKED (Charlotte checking, 14 Jul).** Charlotte believes they hold heat-pump MCS. Re-verified live against the register on 14 Jul: still ONE record, NAP-64364 (NAPIT), `technology_solar_pv=1`, `technology_battery=1`, `technology_ashp=0`, `boiler_upgrade_scheme=0`. Do NOT add a grant callout until Arktek produce (a) an MCS certificate listing ASHP, and (b) proof of Ofgem **Boiler Upgrade Scheme registration**, which is a SEPARATE registration on top of MCS-for-heat-pumps. Ofgem pays the grant TO the installer, so without BUS registration they cannot claim it for a customer at all. Note the BUS grant is **£7,500 flat**; there is no £9,000 tier, so query that figure's source. Adding ASHP is an EXTENSION to their existing NAPIT certificate, not a cold application, so it is a realistic unlock worth £7,500/customer.

## Re-checking the registers
- **MCS**: client-rendered; curl sees only a shell and every `/find-an-installer/<slug>/` soft-404s with a 200. Use the AJAX endpoint behind the Quick Search box: `/wp-admin/admin-ajax.php?action=filter_installers&nonce=<per-session>&form_type=installers&search=<name>`. Grab the nonce from a live page via Puppeteer.
- **HIES**: the `/search/name/` API is **broken** and returns `[]` even for real members. **Do not trust a negative from it.** Paginate the full register (~802 members) and match by name.
- **Gas Safe**: blocked by Imperva. Human check only.

Related: [[project_arktek_site]], [[project_client_landers]]

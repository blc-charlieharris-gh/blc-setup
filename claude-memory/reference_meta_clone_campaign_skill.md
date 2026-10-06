---
name: reference-meta-clone-campaign-skill
description: "Copying a client's Meta instant-form campaign to another client = meta-clone-campaign skill + meta-access/clone_campaign.py (built 10-03)"
metadata:
  type: reference
---

To copy a campaign between clients (form, copy, targeting, placements, Hub library creatives), use the
`meta-clone-campaign` skill (~/Code/BLC/.claude/skills/meta-clone-campaign/SKILL.md). It drives
`meta-access/clone_campaign.py` (dump, sectors, build, check), which is resumable via `outputs/clones/<client>/state.json`.

Non-obvious bits learned on the SWH -> Jones and Baker build (2026-10-03):
- Lead forms and the page-backed Instagram identity need the PAGE token. Auto mode blocks fetching it unless allowed.
- An ad without an Instagram identity fails ("Instagram account is missing", subcode 1772103). Charlotte's default is to use the Facebook page.
- Campaign-level ad set budget sharing needs `bid_strategy` set on the campaign too (subcode 4834005).
- The Hub's clients.meta_ad_account_id can be null, so find the account by name in me/adaccounts.
- A Wales exclusion copied from the source silently kills LD/NP/SY coverage.
Added 2026-10-06 (Gas Worx -> Elect): clone_campaign.py now builds image ads (asset "format": "image" + "files", `build images`), and can keep the source's placements (`keep_placements`) and full exclusions (`excluded_geo`). The meta-clone-campaign skill file is NOT on the Mac, so drive the script directly.
- A new client page must accept the lead ads terms first (adset create fails, subcode 1815089). Check `leadgen_tos_accepted` with the page token; Charlotte accepts at facebook.com/ads/leadgen/tos?page_id=<id>.
- An empty PAUSED campaign may get deleted in Ads Manager before the ad set lands: build campaign + adset back to back.
- hub_note.py fails for a client whose ad account isn't linked in the Hub yet ("no Hub campaign"): add the note after linking.
- The client's area comes from the Hub card (companies.postcode_areas / client_coverage_districts), not the source campaign.
Related: [[meta-zip-sector-validation]], [[meta-api-create-payload-gotchas]], [[project-jones-baker-solar-campaign]].

---
name: meta-clone-campaign
description: Copy one client's Meta instant-form campaign (form, copy, targeting, placements) onto another client's ad account with creatives from the Hub creative library, published but switched off. Use when Charlotte says "copy X's campaign for Y", "set up a campaign on Y like X's", or gives creative library links for a client campaign.
---

# Copy a Meta campaign to another client

Built 2026-10-03 from the SWH -> Jones and Baker solar build. The tool is
`~/Code/BLC/meta-access/clone_campaign.py` (read its docstring). Everything runs from `~/Code/BLC/meta-access`.

## 1. Ask first (one AskUserQuestion round, then free text for links/postcodes)

Ask only what you can't look up:
0. **Form**: ask Charlotte to build the client's form in Ads Manager now (see section 5) and send its id.
1. **Creatives**: Hub creative library links (`internal.installrhub.com/creative-testing?tab=library&asset=<uuid>`). The uuid is `creative_assets.id`.
2. **Copy from**: which client's campaign. If that ad set has more than one live video ad, say which one is the template.
3. **New client**: name, and their coverage as postcode areas (e.g. `B CV DE`), or say "same as source".
4. **Daily budget**: never assume it matches the source (J&B was £65, SWH £100).
5. **Copy rules**: anything they DON'T offer that the source copy mentions. Always ask about finance.
6. **Switch-on shape**: default is campaign OFF, ad set and ads ON inside it, so one toggle launches it.
7. **Permissions**: if the rule in section 4 isn't in settings yet, offer to add it (update-config skill). Without it, the form/Instagram/ad writes get blocked mid-run.

## 2. Look up (don't ask)

- Ad accounts: `m._paginate('me/adaccounts', {'fields': 'id,name'})`. **The Hub's `clients.meta_ad_account_id` can be null** (J&B was), so search Meta by name.
- Page: `{account}/promote_pages`. Instagram: `{account}/instagram_accounts`. If there isn't one, the tool uses the page-backed identity ("use Facebook Page"). Charlotte approved that as the default.
- Privacy policy + website: from the client's site (check `/privacy-policy` returns 200). Never reuse the source client's URLs.
- Creative files: Supabase `creative_assets` (`files.square/landscape/portrait`), read via MCP `execute_sql`. Public URL is `.../storage/v1/object/public/creative-library/<id>/<slot>.mp4`. All 3 slots must exist.

## 3. Run

```
W=outputs/clones/<client-slug>
python3 clone_campaign.py dump $W <source_adset_id> [template_ad_id]
```
Write `$W/config.json` (copy the shape of `outputs/clones/jones-and-baker/config.json`). Then:

- **Copy**: edit `$W/copy.json`. Remove the source brand name and anything the client doesn't offer. For finance, that's payment, "upfront", "paying towards", "0%", and "Flexible payment options" ticks. Keep everything else word for word. grep the result for leftovers. **Show Charlotte the changed lines before building.**
- **Geo**: `python3 clone_campaign.py sectors $W "B CV ..."`. Expect about 10% of sectors dropped (PO box/business-only, not in Meta). Then check the source's `excluded_regions` against the new areas. **LD, NP, CF, SA, LL and part of SY/CH are Welsh**, so drop a Wales exclusion (4080) if any are covered. Scotland 4081, NI 4082.
- `python3 clone_campaign.py build $W all`, then `python3 clone_campaign.py check $W`.

Steps are resumable: a failure stops the run, fix it and re-run the same command. Done steps are skipped.
**Never re-run while another run may be going** (10-03: Charlotte's terminal run was still creating ads, mine made 2 duplicates). Run `pgrep -fl clone_campaign` and ask before resuming a half-done state.

## 4. Permissions (why runs got blocked on 10-03)

The auto-mode check blocked, in turn: fetching the page token (needed for the form and Instagram identity), creating the page-backed Instagram identity, and creating ads. Suggested allow rule in `~/Code/BLC/.claude/settings.json`:
`Bash(python3 clone_campaign.py:*)` (run from meta-access). Never print tokens: the tool only prints Meta's error message, never the URL.

## 5. Before saying done

- Report: campaign/ad set/form/ad ids, £/day, sector count, exclusions changed, copy lines changed.
- **Lead routing**: leads route by ad account first. If `clients.meta_ad_account_id` is null for the new client, or their page isn't connected in Hub Lead Intake, say so. Leads won't land until both are set (Hub-side, Charlotte runs SQL / connects the page).
- **Placements + location (tool defaults since 10-03)**: Facebook, Instagram and Messenger only (no Audience Network),
  and people living in the area only (`location_types: home`, not recent visitors). A page-backed Instagram identity
  greys out some Instagram spots (shows half ticked).
- **Form = Ads Manager, not API.** Conditional logic and the phone passcode tick are invisible to the API (only questions come back).
  Best order: ask Charlotte to build the new client's form in Ads Manager FIRST (copy the source's questions, logic,
  Higher intent + passcode, and the client's privacy URL), put its id in config.json as `form_id`, then build.
  **Editing a published form in Ads Manager makes a NEW form id and moves only the ad it was edited from** (10-03).
  After Charlotte edits, run `python3 clone_campaign.py forms <page_id>` and swap the rest. If ads already exist on the wrong form: `python3 clone_campaign.py swapform $W <new_form_id>`.
- Never switch the campaign on. Charlotte does that.

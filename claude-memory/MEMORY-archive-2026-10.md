# Memory archive, moved from MEMORY.md 2026-10-13 (older index lines; the fact files are unchanged)

- [No duplicate solutions or rules (09-30, 10-06, 10-13)](feedback_no_duplicate_solutions.md): one way per thing, one function per question, one clear next step per screen for Erin
- [Audit fixes must not break things (09-30)](feedback_audit_changes_must_not_break.md): IH Dashboard regression from #1164 A16 + #1169…
- [Peer session asks = reply, not handoff (10-01)](feedback_peer_session_coordination_not_handoff.md): SendMessage the state, no mid-session handoff PR
- [Heatrite + Heat Wise Not paid yet (10-01)](project_not_paid_flag_heatrite_heatwise.md): set by SQL, will NOT clear on payment (Close…
- [OpenRouter key location](reference_openrouter_key_location.md): ~/code/BLC/.env.local, dead 09-30 (401)…
- [Hooks = video labels, ingredients = analysis (10-01)](feedback_hooks_videos_only_ingredients_for_analysis.md): statics never need a hook; analyse on…
- [IH n8n payload fields (10-01)](reference_installrhub_n8n_payload_fields.md): per-form field names, GHL key mcsstatus, add…
- [Old-tab guard (10-02)](reference_old_tab_guard_client_info.md): NEVER now(), use live version.json build time; X-Client-Info hub-web build/<id>, trigger…
- [Bounce pause = hard only (10-02)](feedback_bounce_pause_hard_bounces_only.md): Transient bounces never pause a broadcast…


## Moved 2026-10-14

- [Prebuilt deploy overrides git-main](feedback_prebuilt_deploy_overrides_main.md): merged but not live = manual vercel --prod took…
- [RLS empty read looks like an empty table](feedback_rls_empty_read_looks_like_empty_table.md): unauthenticated read returns 0 rows with NO…
- [Design Performance data durability](feedback_design_performance_data_durability.md): is_tracked-gated, vanishes on untrack; Ended…
- [Paste-ready code must be own text](feedback_paste_ready_code_must_be_own_text.md): Read/Bash tool results break copy-paste, write…
- [Emailish source forces email channel](feedback_emailish_source_forces_email_channel.md): bare nurture/resend/ghl/email src wins…
- [Meta targeting write rate limit](feedback_meta_targeting_write_rate_limit.md): 1 write/30s per ad set incl validate_only…
- **Vercel gotchas:** [cleanUrls breaks "/" rewrite](feedback_vercel_cleanurls_breaks_custom_rewrite.md) · [marketing-agent domains](reference_marketing_agent_vercel_domains.md) · [account mixup](feedback_vercel_github_account_mixup.md)
- [InstallrHub Meta account not in .env](reference_installrhub_meta_account_not_in_env.md): act_7095438517245067, must override…
- **GHL:** [send credential pattern](feedback_ghl_send_credential_pattern.md) · [funnel_key clone gotcha](feedback_nurture_funnel_key_clone_gotcha.md) · [custom fields title-case](feedback_ghl_custom_field_title_case_keys.md)
- **Supabase:** [log sources](reference_supabase_log_sources.md) · [dashboard deploy silent no-op](feedback_supabase_dashboard_deploy_silent_noop.md) · [MCP is read-only](feedback_supabase_mcp_read_only.md) · [row cap silent truncation](feedback_supabase_row_cap_silent_truncation.md)
- [Gmail MCP wrong account + thread break](feedback_gmail_mcp_wrong_account_and_thread_break.md): verify via get_draft first
- [Onboarding is ours end to end](feedback_onboarding_is_ours_end_to_end.md): invites, form, register-installer, emails are…
- **Onboarding rules/bugs:** [no admin-fill](feedback_onboarding_wizard_no_admin_fill.md) · [dead controls](feedback_onboarding_form_dead_controls.md) · [consumed_at ground truth](reference_onboarding_invite_consumed_at_ground_truth.md) · [drag-back bug](feedback_onboarding_drag_back_website_bug.md)
- **Git/PR gotchas:** [no Co-Authored-By, no gh CLI](feedback_marketing_agent_no_coauthor_no_gh.md) · [squash-merge hides commit match](feedback_squash_merge_hides_from_commit_match.md) · [bulk branch delete limit](feedback_bulk_branch_delete_classifier_limit.md) · [commit via temp-index on main](feedback_commit_via_temp_index_on_main.md)
- [Diagnose stated symptom, don't substitute](feedback_diagnose_stated_symptom_not_substitute.md): don't reframe the named issue
- [website-factory manual deploy gap](feedback_website_factory_manual_deploy_gap.md): no redeploy on merge or alias follow
- [Audit crawl asset-extension exclusion](feedback_audit_crawl_asset_extension_filter.md): page-ext check breaks clean-URL sites
- [Hub-only migrations skip Serafim review](feedback_hub_only_migrations_no_serafim_review.md): gate is cross-repo blast radius, crew_* is…
- [Charlotte prefers plain explanations](feedback_charlotte_plain_explanations.md): 2-4 sentence result first, detail if asked…
- **Shared worktree:** [stale agent reads](feedback_shared_worktree_stale_agent_reads.md) · [scratch docs get clobbered](feedback_shared_scratch_docs_get_clobbered.md) · [workdir corruption](project_blc_workdir_corruption.md)
- [Public-by-link pages rule (10-04)](feedback_public_by_link_pages_rule.md): event slides OK public (Hub public/present/)…
- [Public client links need cross-host routing](feedback_public_client_link_needs_crosshost_route.md): /preview/:token pattern or 404
- [placed_with_company_id is survey truth](reference_placed_with_company_id_survey_truth.md): "who holds this survey" field
- **InstallrHub Meta tracking:** [CPL undercounts](project_installrhub_cpl_meta_sync_aggregation.md) · [LPV break](project_installrhub_lpv_attribution_break.md) · [breakdown tracking](project_installrhub_meta_tracking.md)
- [hub_clients list cache excludes jsonb](feedback_clients_list_cache_excludes_jsonb.md): audit/crawl_data missing, read fresh; [slots…

## Moved from MEMORY.md 2026-10-15 (site deploys, Meta/GHL/n8n references, artifact quirks)
- [Resend installer sends](reference_resend_installer_sends.md): key in .env.local, empty = regen Sensitive var
- [Meta postcode sectors via API](reference_meta_zip_sector_validation.md): GB:AL1 1 keys, validate with delivery_estimate…
- [Artifact publish auto-opens](feedback_artifact_publish_auto_opens.md): interrupts Charlotte, edit locally, publish…
- [Artifact confirm/alert blocked](feedback_artifact_confirm_alert_blocked.md): silently no-op in artifact pages, use two-click…
- [Client site Vercel deploy](reference_client_site_vercel_deploy.md): per-folder CLI link + deploy --prod in…
- ["Find on Meta" discovery button](project_meta_assets_discovery.md): crawl+assign built, meta-sync never discovers
- [IH previews behind Vercel SSO](reference_installrhub_preview_sso.md): branch preview 302s to SSO, share via toolbar…
- [IH sign-up vs lead rule (10-03)](feedback_installrhub_signup_vs_lead_rule.md): lead magnets=sign-ups, offer forms=leads…
- [meta-sync CC fallback (10-03)](reference_meta_sync_custom_conversion_fallback.md): no-Lead ads sum all custom conversions; IH…
- [n8n paste rules (10-03)](feedback_n8n_paste_expressions.md): ask webhook node name + node type…
- [Client MOT link (10-03)](reference_client_mot_link.md): installrhub.com/client-mot?cid={{contact_id}}…
- [Site cid recognition (10-04)](project_site_contact_id_recognition.md): ?cid= prefill site-wide, Existing contact flag…
- [GHL token can't list custom fields (10-04)](reference_ghl_booking_token_custom_fields.md): write by key works, reading needs id…
- [installrhub.com deploy + verify (10-03)](reference_installrhub_site_deploy_and_verify.md): check vercel ls after merge (#108 never…
- [Vercel logs confirm site bookings](reference_vercel_logs_confirm_site_bookings.md): POST /api/book 200 = GHL booked…
- [Headless Chrome can't verify YouTube](feedback_headless_chrome_cant_verify_youtube.md): blank/Error 153 in screenshots, check DOM + ask Charlotte
- [IH search indexing (10-05)](reference_installrhub_search_indexing.md): which pages rank, meta + vercel.json X-Robots-Tag, Hub noindex all hosts

## Moved from MEMORY.md 2026-10-15 (10-03 pointers)
- [Meta campaign copy skill (10-03)](reference_meta_clone_campaign_skill.md): meta-clone-campaign skill + clone_campaign.py…
- [Coordinate other sessions automatically (10-03)](feedback_coordinate_other_sessions_automatically.md): at prime + handoff ListAgents, message each…
- [Vercel runs eslint (10-03)](feedback_vercel_runs_eslint_lint_changed_files.md): vite build green isn't enough; eslint the…
- [Handoff brief = just start (10-03)](feedback_handoff_next_steps_just_start.md): job briefed + she expects it done -> branch+PR…
- [PR frozen once 'ready to merge' (10-03)](feedback_no_commits_after_ready_to_merge.md): never push more to a PR she's told to merge…


## Moved 2026-10-16 (10-05/10-06 project + reference pointers)
- [Webinar page runs itself (10-05)](project_webinar_page_automation.md): Hub event drives /webinar states incl. replay (hours count from END), calendar beside replay video; new webinar = event + tick only
- [Edge fn bundle + boot check (10-05)](reference_edge_fn_bundle_and_boot_check.md): bundle-edge-fn.mjs direct, npx -y deno to boot, pkill leftovers
- [Client booking pages (10-06)](project_client_booking_pages.md): /catch-up + /access-call live, open without link, untagged so not leads
- [New marketplace AS codes (10-06)](project_new_marketplace_as_codes.md): ad set per tech+region on GT, one AS code in name; AS01 NW (paused), AS02 Sussex HP, AS03 South Coast solar; next AS04; Hub issues codes
- [Meta lead form API limits (10-06)](reference_meta_lead_form_api_limits.md): logic/DQ page + rename UI-only, archived names reserved, pixel via tracking_specs, CRM events not in API
- [GT lead to installer chain (10-06)](reference_greentide_lead_to_installer_chain.md): Meta -> GT GHL -> utm_content ad id -> AS code -> installer; bookings copy every 30 min

## Moved 2026-10-20: 10-13 and 10-14 pointers
- [Heat pump grant amounts (10-13)](project_heat_pump_grant_amounts.md): up to £9,000 for oil/LPG homes until March 2027, else up to £7,500; src/lib/grantFacts.js
- [B-roll sound RESOLVED (10-13)](project_broll_audio_not_stripped.md): always remux picture-only, clip-silent names, 16/16 cleaned; client footage keeps sound
- [Webinar booking stats by SQL (10-13)](reference_webinar_booking_stats_sql.md): on-webinar = booking_attribution event utm; outside = tag pool, Discovery=triage; no screen yet
- [IH brand from site tokens (10-13)](feedback_installrhub_brand_from_site_tokens.md): prospect pages use installrhub.com css tokens; check logos vs backgrounds; no invented palette, no fake-looking cards
- [Seedance garbles UI text (10-13)](feedback_seedance_garbles_ui_text.md): HTML-animated screens for how-tos, Seedance only word-free, text as overlays
- [Higgsfield/OpenRouter media quirks (10-13)](reference_higgsfield_openrouter_media_quirks.md): CLI foreground only + workspace set, voice ids, Gemini text-only, Lyria stream
- [Access how-to videos (10-13)](project_access_videos.md): FB + Google videos live in marketing-agent; source meta-access/access-videos, v3 brief there
- [Client asks after site ready; DNS handover (10-13)](feedback_client_asks_after_site_ready_dns_handover.md): gaps go with the preview, never ask Wix/domain logins, live = DNS instructions
- [Crew deliverables -> skills -> Hub buttons (10-14)](project_crew_deliverables_to_skills_to_hub.md): nail each deliverable, then Claude skills per deliverable, then one-button Hub features from them
- [Onboarding preview = real picker (10-14)](feedback_onboarding_preview_matches_picker.md): every picker card shared + on both pages; parity test guards it
- [Never swap client Web3Forms keys (10-14)](feedback_never_swap_client_web3forms_keys.md): handed-over sites keep the client key; grep access_key before/after every change
- [Sales add-ons intake page (10-14)](project_sales_addons_intake.md): temp /sales-addons, waiting on sales feedback, then build into onboarding+portal and remove
- [Solar marketplace route drops re-enquiries (10-14)](project_solar_marketplace_route_drops_reenquiries.md): GHL phone match = re-enquiry, n8n solar route never passes it to the app; fix when leaving n8n
- [Build all that was approved, never re-ask (10-14)](feedback_build_everything_approved_dont_reask.md): list every approved point incl mid-turn asks, build in one go
- [Hub test lead = real lead shape (10-14)](reference_hub_test_lead_keys_and_phone.md): option keys + unique 07700 900xxx phone (meta-lead-webhook v47); trace path
- [Hub-managed = Hub code (10-14)](feedback_hub_managed_lives_in_hub_code.md): any fn the Hub runs gets its source moved into marketing-agent first; Serafim refuse-list note
- [Website rule book (10-14, all 7 stages 10-15)](project_website_rulebook.md): premium NEW sites, SWH+Arktek benchmark; stages done, rollout J&B done, Gas Worx next
- [Vercel bot challenge on rapid polling (10-14)](feedback_vercel_bot_challenge_rapid_polling.md): 15s curl loop -> 403 challenge; one delayed check instead
- [Elect site from scratch (10-14)](project_elect_site_from_scratch.md): no template for Elect; rule book design rules cover spacing, layout, colour, gradients, texture
- [Check `date` before dating files (10-14)](feedback_check_date_before_dating_files.md): migrations, What's new, comments; pass real date to subagents


## Moved from MEMORY.md 2026-10-21 (10-05 to 10-07 pointers)
- [Nothing device-linked (10-05)](feedback_nothing_device_linked.md): no Mac- or laptop-only keys/state; use shared auth or git
- [Log client Meta changes in Hub (10-05)](feedback_log_client_meta_changes_in_hub.md): every client-account change -> python3 meta-access/hub_note.py (notes-only fn), SQL fallback
- [Build check every PR (10-06)](feedback_build_check_every_pr.md): audit checklist scoped to the PR, live data, walk the job as Erin; retros never partial
- [Handoff = commit + merge (10-05)](feedback_handoff_includes_commit_and_merge.md): PR and merge the handoff file before closing, don't ask
- [Rules, not one-off fixes (10-05)](feedback_rules_not_one_off_fixes.md): anything that would need redoing next time goes in code, SQL only for backfill
- [One answer, not two (10-05)](feedback_one_answer_not_two.md): one sentence holding both facts; name which similar thing you mean
- [CREW audit build gotchas (10-05)](feedback_crew_audit_build_gotchas.md): page not JSON, helix build-report for raster logos, verify HTML text renders
- [One step at a time, clipboard (10-05)](feedback_one_step_at_a_time_clipboard.md): pbcopy each SQL/deploy, verify live before next
- [whatsNew conflicts: one PR (10-05)](feedback_whatsnew_conflicts_one_pr.md): same-day Hub PRs combined, else every merge conflicts
- [No peer PR links to Charlotte (10-06)](feedback_no_peer_pr_links.md): never relay another session's PR links; peers send them to the repo owner, tell her in plain words only
- [Messages self-contained, chat resets (10-06)](feedback_messages_self_contained_chat_resets.md): her view loses earlier messages; every ask restates its context, answer every point
- [No pbcopy while a peer deploys (10-06)](feedback_no_pbcopy_while_peer_deploying.md): my script got pasted as the broadcasts edge fn; file paths only when other sessions run
- [Timed reminders capped 100/5min (10-06)](feedback_timed_reminders_batch_cap.md): nurture-run before_date must send all due at once; no-mobile = skip
- [Ads Manager "unpublished" = drafts (10-07)](feedback_ads_manager_unpublished_drafts.md): API-live objects show unpublished; snapshot, discard drafts, recheck; addrafts unreadable
- [Check every home before saying "missing" (10-07)](feedback_check_all_homes_before_saying_missing.md): grep code + all JSON columns (criteria etc.) before "we don't ask/store X"
- [Elect: say grant + "up to" (10-07)](project_elect_grant_wording_rule.md): never "discount", up to £X everywhere incl forms/designs; new form needs Hub lead route
- [Living in only = API only (10-07)](feedback_living_in_only_api_only.md): Ads Manager #1870194 on home-only; keep A via API, edits through Claude; Elect home-only too since 10-09


## Moved from MEMORY.md 2026-10-21 (10-05 to 10-08 pointers)
- [Client Drive build (10-08)](project_client_drive_build.md): parent folder 1y5f6W6D..., page upload -> client Drive folder, staff pick into client footage, Cloud steps pending
- [GPT writes all content (10-08)](feedback_gpt_writes_all_content.md): copy GPT, pictures GPT Image 2 (10-21); FB page changes by hand for now
- [Social set-up area (10-08)](project_social_setup_area.md): Crew social job live, photos first then GPT Image 2, FB page edits by hand until Full control; CREW audit with Hub session
- [Meta "Phone number required" fix (10-08)](reference_meta_phone_number_required_fix.md): Ad account settings > Contact info mobile, partner login works, clears on switch-on; use a company number
- [Tell Serafim when his ask is fixed (10-08)](feedback_tell_serafim_when_his_ask_fixed.md): cross_agent_notes SQL same day it's live, not at handoff
- [Confirm understanding before fixing (10-08)](feedback_confirm_understanding_before_fixing.md): play back her issue + planned fix, get OK, then build

## Moved 10-26 (10-15 pointers)
- [Archive, Oct 2026](MEMORY-archive-2026-10.md): older pointers: 09-30 to 10-02, site deploys, Meta/GHL/n8n refs (10-15), plus Vercel/GHL/Supabase/Git/onboarding gotchas, RLS, survey truth, IH tracking (moved 10-14); 10-03 pointers moved 10-15; 10-05/06 project+reference pointers moved 10-16; 10-13/10-14 pointers moved 10-20; 10-05 to 10-08 pointers moved 10-21
- [Client gets own approvals (10-15)](feedback_client_gets_own_approvals.md): finance/compliance sign-offs are the client's job; approved wording only, never offer to chase
- [Client-facing = portal, full sweep first (10-15)](feedback_client_facing_means_portal_full_sweep.md): inventory every client page/link in all repos before saying sorted; one complete list
- [Portal MOT with upsells, very end (10-15)](project_portal_mot_with_upsells.md): Client MOT moves into portal for all clients, upsells for what they lack; at the end of the WHOLE audit with Serafim's batch
- [API edit = false design swap (10-15)](feedback_meta_api_edit_false_design_swap.md): form/copy edit re-uploads videos, links close; use Same design, keep its link
- [Marketplace: Paused is the switch (10-15)](project_marketplace_pause_is_the_switch.md): Hub Paused/Live only, unlink doesn't stop leads, pacing tasks, Live needs ad set on
- [Explain as who-does-what table (10-15)](feedback_explain_process_as_who_does_what_table.md): stage table Hub/you/telesales; never swap her mechanism silently
- [Client preview Vercel address (10-15)](reference_client_preview_vercel_address.md): vercel domains add <name>.vercel.app from the linked folder is public; alias set lands behind SSO
- [Always give the merge link (10-15)](feedback_always_give_merge_link.md): PR + preview links every time; if she says merged and it's open, merge it
- [IH KPIs journey page (10-15)](project_ih_kpis_journey_page.md): one row per person by first entry, funnel rates, source tabs, Awareness Feeds, /kpis share link; frozen CEO snapshot offered
- [Rule book roadmap (10-15)](project_rulebook_rollout_then_hub_design.md): all in-build sites to standard, no exemptions, transferred = done; J&B done, Gas Worx next; then Hub site design for Erin
- [Test a brand-new first sign-in before "accounts work" (10-15)](feedback_test_brand_new_signin_before_saying_accounts_work.md): first magic link failed for new clients after her email; test day-one paths live first
- [Client status = client_onboarding.status (10-15)](reference_client_status_lives_in_client_onboarding.md): Live/Onboarding/Paused lives there, not companies.paused_at; leave paused out of every list
- [Hub visual polish in the audit (10-15)](project_hub_visual_polish.md): sidebar stays, portal look, wider one width, one spacing/type scale; after portal retro, before Funnels
- [Say what the audit already covers (10-15)](feedback_say_what_audit_already_covers.md): inventory api/_audit check keys before calling a rule/check new; report existing vs new
- [Paste deploy: hand over, then verify live (10-15, 10-22)](feedback_paste_deploy_open_the_file.md): open -e fresh file; after Deploy diff live fn vs bundle + logs after a real visit; stray key broke the portal
- [Select list must cover filter columns (10-15)](feedback_select_list_must_cover_filter_columns.md): missing client_id dropped every campaign; check DB rows before blaming sync
- [New bank question needs SQL (10-15)](feedback_new_bank_question_needs_sql.md): saved Parameters list hides new code defaults; ship an append SQL with each
- [IH KPIs test questions (10-15)](project_ih_kpis_test_questions.md): 9 questions to check the pick-your-view page; ask which she ran, SQL-check surprises; Feeds + CEO report open
- [New-services questions go by Email client (10-15)](reference_new_services_questions_email_route.md): auto welcome skips not-needed clients; add-on No form ticked by default; card Send onboarding questions
- [Don't relay other sessions' steps (10-15)](feedback_dont_relay_other_sessions_steps.md): just say "<session> has instructions for you"; tell peers the same
- [Other session's steps: just point (10-15)](feedback_other_session_instructions_just_point.md): say "<session> has instructions for you", only my own steps
- [Client area plan (10-06, 10-11)](project_client_area_plan.md): one page per client by link; 10-11 one key, products under /<slug>/website etc, one Crew frame, one Add media pop-up: next batch after B3b
- [Marketplace client model (10-08, 10-13)](project_marketplace_client_model.md): surveys|leads x fixed|ongoing x brand or not; portal shows leads (per-lead, retainer lead-only) or surveys (per-survey, retainer calling); no Leads tab yet
- [Stock-take queue (10-09)](project_stocktake_1009.md): drafts box (video draft required), Status walk-through, Goals card, build follow-ups, before Creative Testing audit
- [InstallrScore -> installrhub.com homepage (10-11)](project_installrscore_on_installrhub_homepage.md): tell site-installrhub session; crew. is internal, its public pages redirect
- [Prospect audits rules (10-11)](project_prospect_audits_rules.md): prospects only, 30-day did-this-close flag, name-match + merge into client; clients only from the app; build in crew B6
- [SWH go-live ranking (10-11)](project_swh_golive_ranking_2026_10_11.md): redirects one list, blog+towns kept, 99-100 speed, strict CSP, blc-vercel deploy; business details settled 10-12, nothing waiting
- [Client portal is ours (10-12)](project_client_portal_ours.md): magic link on crew., Serafim's leads fns are the engine via Hub client-portal fn, his /leads pages retire; plan in repo
- [Sales kit (10-12)](project_sales_kit.md): INSTALLRHUB page, reviews bank + ONE portfolio (absorbs installrhub.com/portfolio) + Crew features guide; GHL-contact packs; guide + reviews bank + quote graphic LIVE 10-12; next Portfolio + /p/ links

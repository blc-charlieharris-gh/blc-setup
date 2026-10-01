# Memory archive, September 2026

Finished or resolved items moved out of MEMORY.md on 2026-09-24 to keep the index under its size limit. The fact files are unchanged; read them if a topic comes back.

- [Offer remap reconciliation (DONE 09-23)](project_offer_remap_reconciliation.md): all 12 answered AND applied to companies.packages, verified; Vercel project safe to delete
- [SWH transfer handover (09-18)](project_swh_transfer_handover_2026_09_18.md): transfer client, build host-proofed, audit 29/29, files NOT sent, Web3Forms key still ours
- [Serafim package-picker handoff (09-18, RESOLVED 09-19)](project_serafim_package_picker_handoff_2026_09_18.md): his side confirmed routing to /onboarding-picker correctly
- [InstallrHub cost per appointment (09-18)](project_installrhub_cost_per_appointment.md): triage-calendar bookings credited to Meta ads, £49.55/30d, stage_events under-records
- [meta-sync nightly skips tail clients (09-17)](project_meta_sync_nightly_skips_tail_clients.md): #753 dispatchAll finally LIVE v56 on 09-17, targeted client_id POST workaround, worktree holds OLD copy
- [marketing-agent branch cleanup backlog (09-17)](project_marketing_agent_branch_cleanup_2026_09_17.md): 13 branches from PRs #769-783 confirmed safe, ~110 pre-existing stale, use GitHub Branches page
- [Performance reconciliation gotchas (09-14)](feedback_performance_reconciliation_gotchas.md): 5 reasons leads/booked disagree, 3 fixed here, #5 is an InstallrHub Dashboard bug (flagged, not fixed here)
- **SWH site (09-03/04):** [legal/compliance cleanup](project_swh_legal_compliance_cleanup.md) RECC removed, address+VAT fixed, PR #750/#751 · [imagery pass](project_swh_website_imagery_pass.md) solar page split into 3, PR #743-745 · [solar-page split mechanics](feedback_swh_solar_split_mechanics.md) splice HTML via Python, nav/footer sync gotcha
- **Retrofit Group:** [project](project_retrofit_group.md) Scotland Central Belt solar, true CPL ~£80 · [deploy is zip not git](reference_retrofit_group_deploy_is_zip_not_git.md) gitignored · [Trustpilot C&D](project_retrofit_site_trustpilot_cd.md) TP branding stripped · [booked-attribution](project_retrofit_booked_attribution.md) "0 booked" is display artifact, DB total right
- [Survey-count fix locations (08-24)](feedback_survey_count_root_cause_2026_08_24.md): 4 surfaces fixed, commit gotcha
- [website-factory breaks npm build](feedback_website_factory_breaks_build.md): vendored GSAP failed eslint, globalIgnores fix
- [Status ignores onboarding + client emails (09-19)](project_status_onboarding_and_client_emails.md): #831/#832 live, edge fn v30 dashboard-deployed, National Eco email pending
- [Web3Forms preview question (09-21)](project_web3forms_preview_question.md): client registers own Web3Forms + pastes key on preview page, blocks sign-off, merged #859
- [Crew status alignment (09-21)](project_crew_status_alignment.md): deliverable status drives board, access gates + merged access card, #847-#852 live

## Moved 2026-09-24 (index size)
- [Logo light/dark keep colour](feedback_logo_light_dark_keep_colour.md): only flip elements that vanish, mono is single-colour print only
- [Preset list ≠ validation allowlist](feedback_preset_list_not_validation_allowlist.md): retainerMonths silently clamped custom lengths to 3, check reject/pass-through/clamp intent explicitly
- [Manage Clients sub-card styling (09-17)](feedback_manage_clients_subcard_styling.md): all branding-track cards yellow + condensed/mini, always, not just alongside an ads card
- [Sales Model page (09-17)](project_sales_model_page.md): /model in the hub, board.js is plain-DOM source of truth, data in public.pipeline_board, migrations run page-side
- [Client Reports eligibility gate (09-14)](project_client_reports_eligibility_gate.md): reports_enabled + isLive + clientState + 7-day gate, PRs #769/#770
- [Instagram scope](project_instagram_scope.md): posting yes, audit/setup/access no, keep access copy Facebook-only
- [Headless Chrome window-size floor](feedback_headless_chrome_window_size_floor.md): CLI <500px floors, use puppeteer instead
- [Blank video box = removed YouTube video](feedback_blank_youtube_embed_check_oembed.md): oEmbed 404 finds the dead embed, check before asking which one

Moved 2026-09-25:
- [Email channel read zero](feedback_email_channel_exact_match.md): track.js matched utm_medium==='email' exactly, see also Emailish source above
- [CREW Google profile checklist (09-22)](project_crew_google_profile_checklist.md): 19-item scored checklist, audit/set up, questions+photos, re-score, crew host link, Core 42→72, verification step built
- [Broadcasts + Mailing list (09-22)](project_broadcasts_mailing_list.md): ALL LIVE (#885-#926), fn broadcasts v10, email editor + events + nurture fixes, handoff PR docs/handoff-2026-09-22-broadcasts; + Overview performance #928, worktree removed
- [Handoff rule for CREW Google session (09-22)](project_handoff_rule_2026_09_22.md): own files only, tree clean on main, prepend to current-handoff.md + CHANGELOG.md, keep 09-22 audit entry
- [installrhub.com audit clean-up (09-24)](project_installrhub_site_audit_cleanup.md): PRs #72-#75 live, apex now canonical, forecast tracking consent-gated, Green Tide sync = PR #2, leftovers expected
- [Hub batch 09-24 (blc-79)](project_hub_batch_2026_09_24.md): Ideas/Inspo, action emails, status crawl, Goals all LIVE (#960-#977); Goals units + conversion-rate %, all merged, 2 items parked
- [coverage postcode gate](project_onboarding_coverage_postcode_gate.md) fixed PR #766/#767
- [handoff pattern](project_worktree_handoff_tagmodal_thumbnails.md) tree shared, fetch first, own files only
- [location picker silent](project_onboarding_location_picker_silent.md) live, no notification

## Moved from index 2026-09-26
- [Renerji re-audit (09-22)](project_renerji_reaudit.md): client edited LIVE site, build from live mirror not our source, own Web3Forms key
- [InstallrHub webinar page (09-21)](project_installrhub_webinar_oct6.md): speakers + Installer MOT live, bios need speaker sign-off, bump webinar.css ?v= every edit
- [NIBE Green Heat Pumps (09-21)](project_nibe_green_heat_pumps.md): act_930515099667077, Heat Pump Leads LIVE, 4,228 sectors across 56 areas verified
- [InstallrHub webinar Meta tracking (09-21)](project_installrhub_webinar_meta_tracking.md): webinar in MOF audience, Webinar Registration CC 2258431381610266 waits on IH_TRACK_LEAD site change
- [Erin onboarding plan](project_erin_onboarding_plan.md): Artifact ENJBH2aU5xTtmfd5miqq7e, 30-day plan + log + admin checklist, empty as of 09-22
- [SWH final updates (09-25)](project_swh_final_updates_2026_09_25.md): all merged; fonts + inline-script CSP deferred to just before final handover; waiting on Web3Forms key + ICO/MCS/NICEIC/Gas Safe numbers

Moved 2026-09-30 (index near 24 KB):
- [Creative workflow (live 09-28)](project_creative_workflow_preview.md): shipped in full through #1099 (approval, Library, Bank, Why it works by tech); backfill DONE and tool removed
- [Creative backfill (DONE 09-28)](project_creative_backfill_handoff.md): finished, tool removed #1096; history only
- **CREW (09-18/19):** [roster + retainer pill](project_crew_roster_and_retainer_pill.md) #823/#824/#825 live · [logo studio](project_crew_logo_studio.md) full package done, LIVE #815-#830, open: disclaimer wording + guideline extras · [workspace](project_crew_workspace.md) AI organic-marketing, console = /crew · [socials engine](project_crew_socials_engine.md) shipped (#470), never run, needs sign-off · [audit-engine learnings](project_crew_audit_engine_learnings.md) Heatzen = quality bar · [intake retired](project_intake_forms_retired.md) legacy /intake/:token still live
- [Harvard site (09-28)](project_harvard_site.md): Renerji design, live harvard-renewables.vercel.app, merged 09-28 (#1097 logo tool, #1098 site), Kent-first, air con in

Moved 2026-09-30 (index near 24KB). Audit memories stay in MEMORY.md.

- [Marketplace campaigns + parked items (09-25)](project_session_2026_09_25_parked.md): stages 1-4 live, count-on-Take-live #1025 (09-26); stage 5 import waits on list; Serafim only retainer_sop; onboarding gap low; Serafim reminders
- [Status page needs reorganizing](project_status_page_needs_reorganizing.md): 4 unrelated checks stacked, nav badge only counts 1 of them, not urgent (DONE: page 6 audit 09-28)
- [OnboardingPicker doesn't prefill services](project_onboarding_picker_doesnt_prefill_services.md): blank services on load risks wiping existing package, flag to Serafim (FIXED 09-30: picker prefills whole package, #1185)
- [Site audit system (09-21/22)](project_site_audit_upgrade.md): v1 LIVE + set up 09-22, zip only on final send after approval, Gas Worx blog sync fixed to main, LW noindex fixed; waiting on client keys/domains, Layers B/C need Serafim
- [Audit security-headers blame (09-18)](feedback_audit_security_headers_attribution.md): fail is usually OUR missing config, check server + shipped config before blaming host
- [Gas Worx + LJP ads residents-only (09-23)](project_gasworx_ads_location_targeting.md): API-set home-only, don't edit locations in UI, coverage answer from client pending
- **Gas Worx:** [website](project_gasworx_website.md) SEO audit + AI blog shipped, MCS heat-pump-ONLY, servicing prices, Haier aircon page, savings funnel wired, all live 09-21 (#854/#860) · [energy-savings landing](project_gasworx_energy_savings_landing.md) funnel wired 09-21: Web3Forms + Calendly + thank-you, Calendly redirect not set yet · [template.html slice overlap](feedback_gasworx_mobile_slice_overlap.md) byte-range slices can duplicate everywhere
- **SiteScore:** [audits](project_sitescore_audits.md) co-branded audit → £1.5k rebuild upsell · [scoring principles](feedback_sitescore_score_what_the_customer_sees.md) score what customer sees, sell don't fix · [method + CREW gap](project_sitescore_method_and_crew_gap.md) hand-built method in METHOD.md
- **BLC misc:** [Creative Library](project_creative_library.md) single-HTML pitch deck at portfolio.installrhub.com · [Offboarding Plan](project_offboarding.md) Charlotte may leave, flag personal-account entanglements · [ClientSiteGenerator](project_clientsitegenerator.md) BLC internal site generator · [Client Landers](project_client_landers.md) tokenized GT-mirror ad funnel per client
- [Core Electrics site (09-25)](project_core_electrics_site.md): round 3 live (North headline, one area list, Oldham map), waiting on FCA wording, HP photos, domain, Web3Forms key; SWH updates then Harvard next
- [forecast.css is shared (09-25)](feedback_forecast_css_shared_by_other_pages.md): webinar/breakdown pages + a marketing-hub prototype load it from live, grep all + pixel-diff before removing rules
- [Preview question upload feature (queued 09-22)](project_preview_question_upload.md): "Allow upload" tickbox on preview questions, reuse CREW Google photos #884, after audit project
- [BUS grant £9k for oil/LPG till March (09-25)](reference_bus_grant_oil_lpg_9k.md): £7,500 standard, £9,000 replacing oil/LPG, don't flag it; recheck SWH copy after March
- [Hotlinked partner images set cookies](feedback_hotlinked_third_party_images_set_cookies.md): curl -I for Set-Cookie first (Phoenix banner did), self-host + link out
- [IntersectionObserver tall elements](feedback_intersection_observer_tall_elements.md): % threshold never fires if taller than screen, use threshold 0 + rootMargin

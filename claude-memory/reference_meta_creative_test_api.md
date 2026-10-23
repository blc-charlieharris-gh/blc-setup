---
name: reference_meta_creative_test_api
description: "Meta creative tests CAN be made by API (10-23, Arktek): POST /<business>/ad_studies SPLIT_TEST_V2 + creative_test_config; finance category bans postcode/address form questions"
metadata:
  node_type: memory
  type: reference
  originSessionId: b9af5e93-5474-41c1-9cea-c58f8d14b3c6
  modified: 2026-10-23T13:00:10.117Z
---

2026-10-23, first creative test created by API on Arktek (study `1628772425566933`, business `1342201060670600`):
`POST /<BUSINESS_ID>/ad_studies` with `type=SPLIT_TEST_V2`, `start_time`=`cooldown_start_time`, `end_time`=`observation_end_time`, `creative_test_config={"daily_budget":1000}` (pence), `cells=[{name, treatment_percentage (sum 100), ads:[one ad id]}, ...]` (2-5 cells). Test ads made first, PAUSED, in the original ad set. Returned an id; reading back `creative_test_config` or cell `ads` errors (#100), so confirm in Ads Manager. Results: study `objectives{results}`, use `high_performer_ids`. Docs: developers.facebook.com/docs/marketing-api/guides/split-testing/. LJP's Ads Manager test (Erin, 21/10) shows no visible study to our token; test ads carry `source_ad_id`.

Also 10-23: under FINANCIAL_PRODUCTS_SERVICES Meta refuses any lead form asking street address OR post code (#2909057), also no location exclusions (#2909046), and "Electric power" interest refused. Charlotte chose no category for Arktek. Related: [[reference_meta_finance_special_category_rules]] [[project_hub_publish_to_meta_button]]

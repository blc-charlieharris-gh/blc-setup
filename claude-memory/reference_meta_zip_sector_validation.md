---
name: meta-zip-sector-validation
description: How to build, validate and apply UK postcode sectors in Meta (bulk paste limits, API keys, draft/cluster gotchas)
metadata:
  type: reference
---
- Meta takes UK postcode SECTORS as zip keys `GB:AL1 1`.
- Sector source: https://www.doogal.co.uk/PostcodeSectorsCSV (filter Active postcodes > 0). About 12% of active sectors (PO box / business-only / post-census) are NOT in Meta.
- Validate exactly with `{act}/delivery_estimate` + `targeting_spec={"geo_locations":{"zips":[...]}}` (POST with method=get for big lists): a 400 names every invalid key ("Invalid zip code: GB:WR1 9, ..."). Matched Meta's UI error count exactly (620). Do NOT use `/search adgeolocation`, it misses valid sectors.
- Ads Manager "Add locations in bulk" hangs at ~4.8k lines; ~850-line chunks of pre-validated sectors worked.
- Unpublished ad sets are DRAFTS, invisible to the API (edge returns []). Our app also can't create saved_audiences (#3 capability error). So for a draft, paste in chunks or have the user publish paused first.
- Bulk-pasted locations are stored as `location_cluster_ids` (opaque, can't list members). Verify via `{adset}/targetingsentencelines` ("4,228 ZIP codes") + delivery_estimate of cluster vs our zip list.
- Applied example: [[project-nibe-green-heat-pumps]].

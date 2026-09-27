---
name: feedback_meta_targeting_write_rate_limit
description: Meta rejects a second ad set targeting write within 30s (error 613), validate_only counts too
metadata:
  type: feedback
---

Ad set targeting POSTs are rate limited to 1 per 30 seconds per ad set (error #613, subcode 4841018), and a `validate_only` call counts toward it. Seen 2026-09-23 on Gas Worx: validate then immediate apply failed with nothing changed.

**Why:** a failed apply looks like success if the script doesn't check the response, and the ad set stays on old targeting.

**How to apply:** after a validate_only, wait 31s before applying, or retry on 613 with a 31s back-off, then read the targeting back to confirm. Also: Meta requires `explore` in `instagram_positions` whenever `explore_home` is present, or any targeting write 400s. See [[project_gasworx_ads_location_targeting]].

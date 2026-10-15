---
name: project_marketplace_pause_is_the_switch
description: New marketplace on/off = Hub client status Paused/Live (not AS code unlink); full order never blocks; pacing tasks + Live needs linked ad set (2026-10-15)
metadata:
  type: project
---

Decided 2026-10-15 with Charlotte and Serafim: the only switch that stops a new marketplace installer being offered (InstallrHub Pass to X, telesales) is **Paused on their Hub client card**; Live offers them again, even at a full order (no block, no warning). Unlinking an AS code keeps its routing/spend meaning only and does NOT stop leads (except pay-per-lead). Hub tasks (lib/adsetPacing, lib/pacingTasks): nearly full; pause the ad set only when nobody Live on it needs leads; pause them once they've had their fill; set back to Live when they buy more. Going Live needs the AS code linked and a second click confirming the ad set is on. Telesales view = Clients > Manage > Telesales view. Waiting on Serafim's reply, ref pause-stops-offers-2026-10-15.

**Why:** Charlotte got lost when unlink vs pause kept changing; Serafim said "the way we tell telesales should just be a button".
**How to apply:** never suggest unlinking to stop an installer; explain marketplace stages as a Hub does / you do / telesales see table. Related: [[project_new_marketplace_as_codes]].

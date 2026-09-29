-- 1. Two tasks pointing at deleted creatives (repairs the "Gas prices rising x 3" card)
update hub_tasks t
set asset_id = (select d.asset_id from hub_task_designs d join creative_assets a on a.id = d.asset_id
                where d.task_id = t.id order by d.sort limit 1),
    updated_at = now()
where t.id in ('1ef9d778-bff7-4922-b8a0-8ce186cc5a2f', '35d6475c-a216-4e2f-81a2-953570549a0c')
  and not exists (select 1 from creative_assets a where a.id = t.asset_id);

-- 2. Remove the leftover setting from the old backfill tool (run when nobody has the Hub open)
update marketing_parameters set params = params #- '{creativeProduction,olderUploadsReplaced}', updated_at = now() where scope = 'global';

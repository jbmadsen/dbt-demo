drop table if exists Source.dbo.retail_crm_stores;
with vals as (
	select 1 as store_id, 'Lombard Street 1' as store_address, 'San Francisco' as store_city, 'USA' as store_country, GETDATE() as loaded_at
    union all 
    select 2 as store_id, 'Great Ocean Road 41' as store_address, 'Apollo Bay' as store_city, 'Australia' as store_country, GETDATE() as loaded_at
    union all 
    select 3 as store_id, 'Orchard Road 132' as store_address, 'Singapore' as store_city, 'Singapore' as store_country, GETDATE() as loaded_at
    union all 
    select 4 as store_id, 'Las Vegas Boulevard South 2' as store_address, 'Las Vegas' as store_city, 'USA' as store_country, GETDATE() as loaded_at
    union all 
    select 5 as store_id, 'Abbey Road 1121' as store_address, 'London' as store_city, 'UK' as store_country, GETDATE() as loaded_at
)
select *
into Source.dbo.retail_crm_stores
from vals
;


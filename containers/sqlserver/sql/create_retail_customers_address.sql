drop table if exists Source.dbo.retail_crm_customers_address;
with vals as (
	select 1 as address_id, 'Lombard Road 341' as store_address, 'San Francisco' as store_city, 'USA' as store_country, GETDATE() as loaded_at
    union all 
	select 2 as address_id, 'Great Ocean Street 41' as store_address, 'Apollo Bay' as store_city, 'Australia' as store_country, GETDATE() as loaded_at
    union all 
	select 3 as address_id, 'Orchard Boulevard 132' as store_address, 'Singapore' as store_city, 'Singapore' as store_country, GETDATE() as loaded_at
    union all 
	select 4 as address_id, 'Las Vegas Street North 25' as store_address, 'Las Vegas' as store_city, 'USA' as store_country, GETDATE() as loaded_at
    union all 
	select 5 as address_id, 'Abbey Street 23' as store_address, 'London' as store_city, 'UK' as store_country, GETDATE() as loaded_at
    union all 
	select 6 as address_id, 'Lombard Ocean Road 143' as store_address, 'San Francisco' as store_city, 'USA' as store_country, GETDATE() as loaded_at
)
select *
into Source.dbo.retail_crm_customers_address
from vals
;

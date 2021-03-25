use Import;

if not exists (select * from sysobjects where name='retail_crm_customers_address' and xtype='U')
begin

	drop table if exists dbo.retail_crm_customers_address;
	with vals as (
		select 1 as address_id, 'Lombard Road 341' as address_name, 'San Francisco' as city, 'USA' as country, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 2 as address_id, 'Great Ocean Street 41' as address_name, 'Apollo Bay' as city, 'Australia' as country, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 3 as address_id, 'Orchard Boulevard 132' as address_name, 'Singapore' as city, 'Singapore' as country, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 4 as address_id, 'Las Vegas Street North 25' as address_name, 'Las Vegas' as city, 'USA' as country, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 5 as address_id, 'Abbey Street 23' as address_name, 'London' as city, 'UK' as country, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 6 as address_id, 'Lombard Ocean Road 143' as address_name, 'San Francisco' as city, 'USA' as country, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
	)
	select *
	into dbo.retail_crm_customers_address
	from vals

end
;
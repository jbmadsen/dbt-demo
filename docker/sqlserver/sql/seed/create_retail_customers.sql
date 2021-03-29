use Import;

if not exists (select * from sysobjects where name='retail_crm_customers' and xtype='U')
begin

	drop table if exists dbo.retail_crm_customers;
	with vals as (
		select 1 as cust_id, 1 as address_id, 'James' as first_name, 'Steph' as last_name, 'M' as gender, '1999-01-01' as customer_since, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 2 as cust_id, 1 as address_id, 'Mary' as first_name, 'Steph' as last_name, 'F' as gender, '1995-02-16' as customer_since, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 3 as cust_id, 3 as address_id, 'John' as first_name, 'Raymond' as last_name, 'M' as gender, '1980-12-08' as customer_since, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 4 as cust_id, 5 as address_id, 'Jennifer' as first_name, 'Patricks' as last_name, 'F' as gender, '2001-03-15' as customer_since, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 5 as cust_id, 4 as address_id, 'Patricia' as first_name, 'Tyler' as last_name, 'F' as gender, '2005-01-07' as customer_since, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
		union all 
		select 6 as cust_id, 2 as address_id, 'Richard' as first_name, 'Tyler' as last_name, 'M' as gender, '2005-05-04' as customer_since, GETDATE() as updated_at, GETDATE() as dwh_loaded_at
	)
	select *
	into dbo.retail_crm_customers
	from vals

end
;
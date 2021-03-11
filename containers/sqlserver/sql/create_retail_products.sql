drop table if exists Source.dbo.retail_crm_products;
with vals as (
	select 1 as product_id, 'Almonds' as product_name, 'Food Product' as product_type, 'Bla bla' as product_description, 40 as product_list_price, GETDATE() as loaded_at
    union all 
	select 2 as product_id, 'Apples' as product_name, 'Food Product' as product_type, 'Bla bla bla' as product_description, 2 as product_list_price, GETDATE() as loaded_at
    union all 
	select 3 as product_id, 'Beer' as product_name, 'Essentials' as product_type, 'Bla bla bla bla' as product_description, 20 as product_list_price, GETDATE() as loaded_at
    union all 
	select 4 as product_id, 'Butter' as product_name, 'Food Product' as product_type, 'Bla bla bla bla bla' as product_description, 21 as product_list_price, GETDATE() as loaded_at
    union all 
	select 5 as product_id, 'Carrots' as product_name, 'Food Product' as product_type, 'Bla bla bla' as product_description, 10 as product_list_price, GETDATE() as loaded_at
    union all 
	select 6 as product_id, 'Chilled meat' as product_name, 'Food Product' as product_type, 'Bla bla bla' as product_description, 25 as product_list_price, GETDATE() as loaded_at
    union all 
	select 7 as product_id, 'Dates, dried' as product_name, 'Food Product' as product_type, 'Bla bla' as product_description, 35 as product_list_price, GETDATE() as loaded_at
    union all 
	select 8 as product_id, 'Figs, dried' as product_name, 'Food Product' as product_type, 'Bla bla' as product_description, 35 as product_list_price, GETDATE() as loaded_at
    union all 
	select 9 as product_id, 'Garlic' as product_name, 'Food Product' as product_type, 'Bla bla' as product_description, 12 as product_list_price, GETDATE() as loaded_at
	union all 
	select 10 as product_id, 'Delivery' as product_name, 'Logistics' as product_type, 'Same Day Delivery' as product_description, 50 as product_list_price, GETDATE() as loaded_at
	union all 
	select 11 as product_id, 'Discount' as product_name, 'Discount' as product_type, 'Discount' as product_description, -2 as product_list_price, GETDATE() as loaded_at
)
select *
into Source.dbo.retail_crm_products
from vals
;
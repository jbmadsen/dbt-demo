drop table if exists Source.dbo.retail_crm_orders_lines;
with vals as (
	select 1 as orders_line_id, 1 as orders_id, 1 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all 
	select 2 as orders_line_id, 1 as orders_id, 1 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all 
	select 3 as orders_line_id, 3 as orders_id, 4 as product_id, 2 as quantity, GETDATE() as loaded_at
    union all 
	select 4 as orders_line_id, 5 as orders_id, 5 as product_id, 3 as quantity, GETDATE() as loaded_at
    union all 
	select 5 as orders_line_id, 4 as orders_id, 3 as product_id, 4 as quantity, GETDATE() as loaded_at
    union all 
	select 6 as orders_line_id, 1 as orders_id, 2 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all
    select 7 as orders_line_id, 1 as orders_id, 11 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all 
	select 8 as orders_line_id, 1 as orders_id, 1 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all 
	select 9 as orders_line_id, 3 as orders_id, 4 as product_id, 2 as quantity, GETDATE() as loaded_at
    union all 
	select 10 as orders_line_id, 5 as orders_id, 5 as product_id, 3 as quantity, GETDATE() as loaded_at
    union all 
	select 11 as orders_line_id, 4 as orders_id, 3 as product_id, 4 as quantity, GETDATE() as loaded_at
    union all 
	select 12 as orders_line_id, 1 as orders_id, 2 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all 
	select 13 as orders_line_id, 5 as orders_id, 11 as product_id, 3 as quantity, GETDATE() as loaded_at
    union all 
	select 14 as orders_line_id, 4 as orders_id, 3 as product_id, 4 as quantity, GETDATE() as loaded_at
    union all 
	select 15 as orders_line_id, 1 as orders_id, 2 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all
    select 16 as orders_line_id, 1 as orders_id, 1 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all 
	select 17 as orders_line_id, 1 as orders_id, 1 as product_id, 1 as quantity, GETDATE() as loaded_at
    union all 
	select 18 as orders_line_id, 3 as orders_id, 4 as product_id, 2 as quantity, GETDATE() as loaded_at
    union all 
	select 19 as orders_line_id, 5 as orders_id, 5 as product_id, 3 as quantity, GETDATE() as loaded_at
    union all 
	select 20 as orders_line_id, 4 as orders_id, 3 as product_id, 4 as quantity, GETDATE() as loaded_at
    union all 
	select 21 as orders_line_id, 1 as orders_id, 11 as product_id, 10 as quantity, GETDATE() as loaded_at
)
select *
into Source.dbo.retail_crm_orders_lines
from vals
;
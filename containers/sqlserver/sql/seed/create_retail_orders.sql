use Import;

drop table if exists dbo.retail_crm_orders;
with vals as (
	select 1 as orders_id, 1 as store_id, 1 as customer_id, 1 as employee_id, '2021-02-05' as orders_date, 125 as orders_total, 5 as orders_discount, 'completed' as orders_state, 'Cash' as payment_type, 1 as requsts_delivery, GETDATE() as loaded_at
    union all 
	select 2 as orders_id, 1 as store_id, 1 as customer_id, 1 as employee_id, '2021-02-06' as orders_date, 20 as orders_total, 10 as orders_discount, 'processing' as orders_state, 'Debit' as payment_type, 0 as requsts_delivery, GETDATE() as loaded_at
    union all 
	select 3 as orders_id, 3 as store_id, 4 as customer_id, 2 as employee_id, '2021-02-08' as orders_date, 20 as orders_total, 0 as orders_discount, 'completed' as orders_state, 'Unknown' as payment_type, 0 as requsts_delivery, GETDATE() as loaded_at
    union all 
	select 4 as orders_id, 5 as store_id, 5 as customer_id, 3 as employee_id, '2021-03-05' as orders_date, 200 as orders_total, 0 as orders_discount, 'completed' as orders_state, 'Cash' as payment_type, 0 as requsts_delivery, GETDATE() as loaded_at
    union all 
	select 5 as orders_id, 4 as store_id, 3 as customer_id, 4 as employee_id, '2021-01-05' as orders_date, 40 as orders_total, 0 as orders_discount, 'cancelled' as orders_state, 'Debit' as payment_type, 0 as requsts_delivery, GETDATE() as loaded_at
    union all 
	select 6 as orders_id, 1 as store_id, 2 as customer_id, 1 as employee_id, '2021-02-05' as orders_date, 12 as orders_total, 0 as orders_discount, 'rejected' as orders_state, 'VISA' as payment_type, 1 as requsts_delivery, GETDATE() as loaded_at
)
select *
into dbo.retail_crm_orders
from vals
;
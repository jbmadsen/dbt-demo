{% snapshot retail_orders_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='order_id',
          updated_at='loaded_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      orders_id as order_id,
      store_id,
      customer_id,
      employee_id,
      orders_date,
      orders_total as orders_total_price,
      orders_discount,
      orders_state, 
      payment_type, 
      requsts_delivery,
      loaded_at
    from {{ source('source', 'retail_crm_orders') }}

{% endsnapshot %}

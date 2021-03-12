{% snapshot retail_orders_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',

          unique_key='order_id',

          strategy='check',
          check_cols=[
            'store_id', 
            'customer_id',
            'employee_id',
            'orders_state',
            ],
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
      loaded_at as dwh_loaded_at
    from {{ source('source', 'retail_crm_orders') }}

{% endsnapshot %}

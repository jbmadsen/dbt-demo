{% snapshot retail_orders_lines_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',

          unique_key='order_line_id',

          strategy='check',
          check_cols=[
            'order_id', 
            'product_id',
            'quantity',
            ],
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      orders_line_id as order_line_id,
      orders_id as order_id,
      product_id,
      quantity,
      dwh_loaded_at
    from {{ source('import', 'retail_crm_orders_lines') }}

{% endsnapshot %}

{% snapshot retail_orders_lines_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='order_line_id',
          updated_at='loaded_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      orders_line_id as order_line_id,
      orders_id as order_id,
      product_id,
      quantity,
      loaded_at
    from {{ source('source', 'retail_crm_orders_lines') }}

{% endsnapshot %}

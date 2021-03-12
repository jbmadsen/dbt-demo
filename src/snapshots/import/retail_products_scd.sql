{% snapshot retail_products_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='product_id',
          updated_at='loaded_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      product_id,
      product_name,
      product_type,
      product_description,
      product_list_price,
      loaded_at
    from {{ source('source', 'retail_crm_products') }}

{% endsnapshot %}

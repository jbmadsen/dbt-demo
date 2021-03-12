{% snapshot retail_products_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',

          unique_key='product_id',

          strategy='check',
          check_cols=[
            'product_name', 
            'product_type',
            'product_description',
            'product_list_price',
            ],
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      product_id,
      product_name,
      product_type,
      product_description,
      product_list_price,
      loaded_at as dwh_loaded_at
    from {{ source('import', 'retail_crm_products') }}

{% endsnapshot %}

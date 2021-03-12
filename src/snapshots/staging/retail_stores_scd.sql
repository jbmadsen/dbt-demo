{% snapshot retail_stores_scd %}

    {{
        config(
          target_database='Staging',
          target_schema='dbo',
          
          unique_key='store_id',
          
          strategy='check',
          check_cols=[
            'store_address', 
            'store_city',
            ],
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      store_id,
      store_address,
      store_city,
      store_country,
      loaded_at as dwh_loaded_at
    from {{ source('import', 'retail_crm_stores') }}

{% endsnapshot %}

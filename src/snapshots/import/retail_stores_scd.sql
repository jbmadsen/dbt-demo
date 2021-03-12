{% snapshot retail_stores_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='store_id',
          updated_at='loaded_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      store_id,
      store_address,
      store_city,
      store_country
      loaded_at
    from {{ source('source', 'retail_crm_stores') }}

{% endsnapshot %}

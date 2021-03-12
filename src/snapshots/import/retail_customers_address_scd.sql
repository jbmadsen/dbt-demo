{% snapshot retail_customers_address_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          
          unique_key='address_id',
          
          strategy='timestamp',
          updated_at='updated_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      address_id,
      address_name,
      city,
      country,
      updated_at,
      dwh_loaded_at
    from {{ source('source', 'retail_crm_customers_address') }}

{% endsnapshot %}

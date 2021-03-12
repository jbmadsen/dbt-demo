{% snapshot retail_customers_address_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='address_id',
          updated_at='loaded_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      address_id,
      address_name,
      city,
      country,
      loaded_at
    from {{ source('source', 'retail_crm_customers_address') }}

{% endsnapshot %}

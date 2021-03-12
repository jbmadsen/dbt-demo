{% snapshot retail_customers_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          
          unique_key='customer_id',
          
          strategy='timestamp',
          updated_at='updated_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      cust_id as customer_id,
      address_id,
      first_name,
      last_name,
      gender,
      customer_since,
      updated_at,
      dwh_loaded_at
    from {{ source('import', 'retail_crm_customers') }}

{% endsnapshot %}

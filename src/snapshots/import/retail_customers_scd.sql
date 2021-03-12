{% snapshot retail_customers_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='customer_id',
          updated_at='loaded_at',
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
      loaded_at
    from {{ source('source', 'retail_crm_customers') }}

{% endsnapshot %}

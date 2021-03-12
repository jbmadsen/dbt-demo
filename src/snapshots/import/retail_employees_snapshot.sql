{% snapshot retail_employees_snapshot %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='employees_id',
          updated_at='loaded_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select * 
    from {{ source('source', 'retail_crm_employees') }}

{% endsnapshot %}

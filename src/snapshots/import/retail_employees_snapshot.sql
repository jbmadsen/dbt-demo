{% snapshot retail_employees_snapshot %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='UserID',
          updated_at='Loaded_At',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select * 
    from {{ source('source', 'retail_crm_employees') }}

{% endsnapshot %}
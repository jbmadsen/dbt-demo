{% snapshot retail_employees_scd %}

    {{
        config(
          target_database='Import',
          target_schema='dbo',
          strategy='timestamp',
          unique_key='employee_id',
          updated_at='loaded_at',
        )
    }}

    -- Snapshot materialization defaults to Table, as otherwise it wouldn't make sense

    select 
      employees_id as employee_id,
      workplace_id as store_id,
      first_name,
      last_name,
      birthdate,
      gender,
      hired_date,
      title,
      salary, -- Consider anonymising this - sensitive data!
      loaded_at
    from {{ source('source', 'retail_crm_employees') }}

{% endsnapshot %}

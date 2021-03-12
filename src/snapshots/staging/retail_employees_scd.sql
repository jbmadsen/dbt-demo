{% snapshot retail_employees_scd %}

    {{
        config(
          target_database='Staging',
          target_schema='dbo',
          
          unique_key='employee_id',
          
          strategy='check',
          check_cols=[
            'store_id', 
            'first_name',
            'last_name',
            'title',
            'salary',
            ],
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
      dwh_loaded_at
    from {{ source('import', 'retail_crm_employees') }}

{% endsnapshot %}

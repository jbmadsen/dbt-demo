
{{ 
    config({
      "pre-hook": "{{ drop_all_indexes_on_table() }}",
      "post-hook": [
         "{{ create_nonclustered_index(columns = ['orders_id', 'store_id']) }}",
         "{{ create_nonclustered_index(columns = ['orders_id'], includes = ['Loaded_At']) }}"
	      ]
    }) 
}}

-- No need for a clustered index, as dbt by default auto-creates a clustered columnstore index on materialized tables

select 
  *, 
  'Final' as LastColumn
from {{ ref('orders_source_to_import_demo') }}

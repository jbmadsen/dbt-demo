
-- Use the `ref` function to select from other models

select *
from {{ ref('first_import_model') }}
where id = 1

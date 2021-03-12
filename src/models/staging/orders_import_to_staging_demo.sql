select
  *
from {{ source('import', 'retail_crm_orders') }}
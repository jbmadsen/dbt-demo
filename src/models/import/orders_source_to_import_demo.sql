select
  *
from {{ source('source', 'retail_crm_orders') }}
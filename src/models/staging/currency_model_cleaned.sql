
-- Use the `ref` function to select from other models

select 
    id as currency_id, 
    currency
from {{ ref('currency_model_manual') }}
where currency is not null

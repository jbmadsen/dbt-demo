select
  *
from {{ source('source', 'DemoTable') }}
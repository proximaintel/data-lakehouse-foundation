-- staging/stg_source_a.sql
-- 1:1 with source, light transformations only

select
    id,
    name,
    cast(amount as decimal(18, 2)) as amount,
    cast(created_date as date) as created_date,
    category,
    _ingestion_timestamp
from {{ source('bronze', 'source_a') }}
where id is not null

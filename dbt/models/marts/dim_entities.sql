-- marts/dim_entities.sql
-- Dimension table: unique entities

select distinct
    id,
    name,
    category,
    min(created_date) as first_seen,
    max(created_date) as last_seen
from {{ ref('int_cleaned') }}
group by 1, 2, 3

-- intermediate/int_cleaned.sql
-- Business logic: joins, filters, derived columns

select
    s.id,
    s.name,
    s.amount,
    s.created_date,
    s.category,
    case
        when s.amount > 10000 then 'high'
        when s.amount > 1000 then 'medium'
        else 'low'
    end as amount_tier
from {{ ref('stg_source_a') }} s
where s.created_date >= dateadd(year, -2, current_date())

-- marts/fct_metrics.sql
-- Fact table: daily metrics by category

select
    date_trunc('day', created_date) as metric_date,
    category,
    amount_tier,
    count(*) as record_count,
    sum(amount) as total_amount,
    avg(amount) as avg_amount
from {{ ref('int_cleaned') }}
group by 1, 2, 3

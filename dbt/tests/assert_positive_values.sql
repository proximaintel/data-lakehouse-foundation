-- tests/assert_positive_values.sql
-- Custom test: ensure all amounts are positive in the metrics table

select *
from {{ ref('fct_metrics') }}
where total_amount < 0

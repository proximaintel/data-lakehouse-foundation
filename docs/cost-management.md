# Cost Management

## Optimization Strategies

| Strategy | Savings | How |
|----------|---------|-----|
| Auto-termination | 20-40% | Clusters terminate after 15-30 min idle |
| Spot instances | 60-80% | Use for non-critical batch jobs |
| Cluster policies | Prevents runaway | Max workers, max DBU/hour |
| Delta optimization | 30-50% query cost | ZORDER, VACUUM, file compaction |
| Serverless SQL | Variable | Pay per query, no idle clusters |

## Cluster Policies

The `cost_optimized` policy enforces:
- Auto-termination: max 30 minutes
- Max workers: 10
- Spot instances for user pools

## Monitoring

Track in Databricks Account Console:
- DBU consumption by workspace/cluster/user
- Storage costs by container
- Query performance and cost per query

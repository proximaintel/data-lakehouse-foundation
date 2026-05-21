# Migration Patterns

## From SQL Server

| Source | Target | Pattern |
|--------|--------|---------|
| Tables | Bronze (Delta) | Full extract via ADF, then CDC for incremental |
| Stored procedures | dbt models | Rewrite logic in SQL, test with dbt |
| SSIS packages | Databricks Workflows | Orchestrate with jobs, transform with Spark |
| SSRS reports | Power BI | Rebuild on gold layer tables |

## From Oracle/Teradata

| Source | Target | Pattern |
|--------|--------|---------|
| Tables | Bronze (Delta) | JDBC extract via Spark, partition by date |
| ETL (Informatica) | dbt + Spark | Rewrite in dbt SQL or PySpark |
| Data marts | Gold layer | Rebuild as Delta tables with proper modeling |

## Migration Sequence

1. Set up lakehouse infrastructure (this repo)
2. Identify quick-win workloads (low complexity, high value)
3. Migrate bronze layer first (raw data landing)
4. Build silver transformations (dbt or notebooks)
5. Create gold serving tables
6. Redirect consumers (Power BI, APIs) to new platform
7. Decommission legacy source after validation period

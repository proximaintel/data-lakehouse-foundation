# Architecture

## Medallion Pattern

```
Sources --> Bronze (Raw) --> Silver (Cleaned) --> Gold (Business) --> Consumers
              |                  |                    |
         Append-only       Deduplicated         Aggregated        Power BI
         Schema-on-read    Type-enforced        Feature tables    ML/AI
         Full history      Quality checked      Serving views     APIs
```

## Storage Layout (ADLS Gen2)

```
storage-account/
├── bronze/          # Raw ingested data (append-only)
│   ├── source_a/
│   └── source_b/
├── silver/          # Cleaned and conformed
│   ├── source_a/
│   └── source_b/
├── gold/            # Business aggregates
│   ├── metrics/
│   └── features/
└── checkpoints/     # Streaming checkpoints
```

## Governance (Unity Catalog)

```
Metastore
├── bronze (catalog)
│   └── default (schema)
│       └── source_a (table)
├── silver (catalog)
│   └── default (schema)
│       └── source_a (table)
└── gold (catalog)
    └── default (schema)
        ├── fct_metrics (table)
        └── dim_entities (table)
```

## Networking

- Databricks workspace VNet-injected (no public access)
- ADLS Gen2 with private endpoints
- NSGs on all subnets
- Service endpoints for Azure services

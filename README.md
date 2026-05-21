# Data Lakehouse Foundation

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5-purple.svg)](https://www.terraform.io/)
[![dbt](https://img.shields.io/badge/dbt-Ready-orange.svg)](dbt/)

**Production-ready lakehouse deployment on Databricks or Microsoft Fabric — medallion architecture, Unity Catalog governance, dbt transformations, and data quality.**

Built by [Proxima Intelligence](https://proximaintel.com) — Enterprise Cloud & AI Consulting.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    Data Lakehouse                                 │
│                                                                   │
│  Sources        Bronze          Silver          Gold             │
│  ┌────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐      │
│  │Database│──>│ Raw      │──>│ Cleaned  │──>│ Business │      │
│  │API     │   │ Append   │   │ Conformed│   │ Metrics  │      │
│  │Files   │   │ As-is    │   │ Typed    │   │ Features │      │
│  │Stream  │   │          │   │ Deduped  │   │ Serving  │      │
│  └────────┘   └──────────┘   └──────────┘   └──────────┘      │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ Governance: Unity Catalog / Purview                          ││
│  │ Lineage | Access Control | Classification | Quality         ││
│  └─────────────────────────────────────────────────────────────┘│
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │ Consumption: Power BI | ML/AI | APIs | Data Sharing         ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

## Choose Your Platform

| | Databricks | Microsoft Fabric |
|---|---|---|
| Path | [databricks/](databricks/) | [fabric/](fabric/) |
| IaC | Terraform | Bicep |
| Governance | Unity Catalog | Purview |
| Best for | AI/ML + advanced engineering | Microsoft ecosystem + low-code |

## Repository Structure

```
├── databricks/         # Terraform + sample notebooks
├── fabric/             # Bicep + sample notebooks
├── dbt/                # Transformation project (works with both)
├── data-quality/       # Great Expectations + Databricks DQ
├── docs/               # Architecture, deployment, governance, cost
└── examples/           # Basic deployment example
```

## Quick Start (Databricks)

```bash
cd databricks/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

## Quick Start (dbt)

```bash
cd dbt
cp profiles.yml.example profiles.yml
dbt deps
dbt run
dbt test
```

## Documentation

- [Architecture](docs/architecture.md) — medallion pattern and data flow
- [Deployment Guide](docs/deployment-guide.md) — step-by-step
- [Governance](docs/governance.md) — Unity Catalog setup
- [Cost Management](docs/cost-management.md) — cluster policies, optimization
- [Migration Patterns](docs/migration-patterns.md) — from legacy warehouses

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## About Proxima Intelligence

[Proxima Intelligence](https://proximaintel.com) delivers the Data Lakehouse Foundation as a [fixed-scope accelerator](https://proximaintel.com/accelerators/data-lakehouse) — production lakehouse in 4 weeks.

Senior architects on every engagement. No bait-and-switch.

---

*© Proxima Intelligence LLC. Licensed under Apache 2.0.*

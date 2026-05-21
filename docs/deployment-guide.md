# Deployment Guide

## Databricks

```bash
cd databricks/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

## dbt

```bash
cd dbt
cp profiles.yml.example profiles.yml
# Edit profiles.yml with your workspace URL and token
dbt deps
dbt run
dbt test
```

## Fabric

```bash
cd fabric/bicep
az deployment sub create --location eastus2 --template-file main.bicep
```

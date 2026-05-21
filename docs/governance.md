# Governance

## Unity Catalog Setup

1. Create metastore (account-level, one per region)
2. Assign metastore to workspace
3. Create catalogs: bronze, silver, gold
4. Create schemas within each catalog
5. Configure access: data engineers get all catalogs, analysts get gold only

## Access Patterns

| Role | Bronze | Silver | Gold |
|------|--------|--------|------|
| Data Engineer | Read/Write | Read/Write | Read/Write |
| Analytics Engineer | Read | Read/Write | Read/Write |
| Analyst | — | — | Read |
| Data Scientist | — | Read | Read |

## Data Classification

Tag sensitive columns in Unity Catalog:
- PII: name, email, phone, address
- PHI: diagnosis, treatment, patient_id
- PCI: card_number, cvv, expiry

Apply column masking for restricted access.

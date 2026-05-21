resource "databricks_catalog" "bronze" {
  name    = "bronze"
  comment = "Raw ingested data - append only"
}

resource "databricks_catalog" "silver" {
  name    = "silver"
  comment = "Cleaned and conformed data"
}

resource "databricks_catalog" "gold" {
  name    = "gold"
  comment = "Business-level aggregates and serving tables"
}

resource "databricks_schema" "bronze_default" {
  catalog_name = databricks_catalog.bronze.name
  name         = "default"
}

resource "databricks_schema" "silver_default" {
  catalog_name = databricks_catalog.silver.name
  name         = "default"
}

resource "databricks_schema" "gold_default" {
  catalog_name = databricks_catalog.gold.name
  name         = "default"
}

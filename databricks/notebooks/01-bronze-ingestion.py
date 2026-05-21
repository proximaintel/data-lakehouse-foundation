# Databricks notebook source
# Bronze Layer: Raw Ingestion
# Pattern: Append-only, schema-on-read, preserve source data as-is

from pyspark.sql import functions as F

# Configuration
source_path = "abfss://raw@<storage_account>.dfs.core.windows.net/source_a/"
bronze_path = "abfss://bronze@<storage_account>.dfs.core.windows.net/source_a/"

# Read from source (CSV example - adapt for JSON, Parquet, etc.)
df = (
    spark.read
    .option("header", "true")
    .option("inferSchema", "true")
    .csv(source_path)
)

# Add ingestion metadata
df_with_metadata = df.withColumns({
    "_ingestion_timestamp": F.current_timestamp(),
    "_source_file": F.input_file_name(),
    "_batch_id": F.lit(spark.conf.get("spark.databricks.workflow.runId", "manual")),
})

# Write as Delta - append only
(
    df_with_metadata.write
    .format("delta")
    .mode("append")
    .option("mergeSchema", "true")
    .save(bronze_path)
)

print(f"Ingested {df_with_metadata.count()} rows to bronze layer")

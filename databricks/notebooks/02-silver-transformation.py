# Databricks notebook source
# Silver Layer: Cleaned and Conformed
# Pattern: Deduplicate, type cast, null handling, schema enforcement

from pyspark.sql import functions as F
from pyspark.sql.window import Window

# Configuration
bronze_path = "abfss://bronze@<storage_account>.dfs.core.windows.net/source_a/"
silver_path = "abfss://silver@<storage_account>.dfs.core.windows.net/source_a/"

# Read from bronze
df_bronze = spark.read.format("delta").load(bronze_path)

# Deduplicate (keep latest by ingestion timestamp)
window = Window.partitionBy("id").orderBy(F.desc("_ingestion_timestamp"))
df_deduped = (
    df_bronze
    .withColumn("_row_num", F.row_number().over(window))
    .filter(F.col("_row_num") == 1)
    .drop("_row_num")
)

# Type casting and null handling
df_cleaned = (
    df_deduped
    .withColumn("amount", F.col("amount").cast("decimal(18,2)"))
    .withColumn("created_date", F.to_date("created_date", "yyyy-MM-dd"))
    .filter(F.col("id").isNotNull())
    .withColumn("name", F.coalesce(F.col("name"), F.lit("Unknown")))
)

# Add silver metadata
df_silver = df_cleaned.withColumns({
    "_processed_timestamp": F.current_timestamp(),
    "_silver_version": F.lit(1),
})

# Write as Delta - merge/upsert
(
    df_silver.write
    .format("delta")
    .mode("overwrite")
    .option("overwriteSchema", "true")
    .save(silver_path)
)

print(f"Processed {df_silver.count()} rows to silver layer")

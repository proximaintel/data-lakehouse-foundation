# Databricks notebook source
# Gold Layer: Business Aggregates
# Pattern: Join dimensions, aggregate metrics, serve to consumers

from pyspark.sql import functions as F

# Configuration
silver_path = "abfss://silver@<storage_account>.dfs.core.windows.net/source_a/"
gold_path = "abfss://gold@<storage_account>.dfs.core.windows.net/metrics/"

# Read from silver
df_silver = spark.read.format("delta").load(silver_path)

# Business aggregation example: daily metrics
df_gold = (
    df_silver
    .groupBy(
        F.date_trunc("day", "created_date").alias("date"),
        "category",
    )
    .agg(
        F.count("*").alias("record_count"),
        F.sum("amount").alias("total_amount"),
        F.avg("amount").alias("avg_amount"),
        F.min("amount").alias("min_amount"),
        F.max("amount").alias("max_amount"),
    )
    .withColumn("_generated_timestamp", F.current_timestamp())
)

# Write as Delta
(
    df_gold.write
    .format("delta")
    .mode("overwrite")
    .save(gold_path)
)

print(f"Generated {df_gold.count()} metric rows in gold layer")

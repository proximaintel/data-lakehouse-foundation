# Fabric Notebook: Gold Aggregation
from pyspark.sql import functions as F

df_silver = spark.read.format("delta").table("silver_source_a")

df_gold = (
    df_silver
    .groupBy(F.date_trunc("day", "created_date").alias("date"), "category")
    .agg(
        F.count("*").alias("record_count"),
        F.sum("amount").alias("total_amount"),
        F.avg("amount").alias("avg_amount"),
    )
)

df_gold.write.format("delta").mode("overwrite").saveAsTable("gold_daily_metrics")

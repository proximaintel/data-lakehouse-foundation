# Fabric Notebook: Silver Transformation
from pyspark.sql import functions as F
from pyspark.sql.window import Window

df_bronze = spark.read.format("delta").table("bronze_source_a")

window = Window.partitionBy("id").orderBy(F.desc("_ingestion_timestamp"))
df_deduped = df_bronze.withColumn("_rn", F.row_number().over(window)).filter("_rn = 1").drop("_rn")

df_silver = (
    df_deduped
    .withColumn("amount", F.col("amount").cast("decimal(18,2)"))
    .filter(F.col("id").isNotNull())
    .withColumn("_processed_timestamp", F.current_timestamp())
)

df_silver.write.format("delta").mode("overwrite").saveAsTable("silver_source_a")

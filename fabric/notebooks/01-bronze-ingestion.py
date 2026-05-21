# Fabric Notebook: Bronze Ingestion
# Same medallion pattern adapted for Microsoft Fabric Spark

from pyspark.sql import functions as F

# In Fabric, use lakehouse paths
source_path = "Files/raw/source_a/"
bronze_path = "Tables/bronze_source_a"

df = spark.read.option("header", "true").option("inferSchema", "true").csv(source_path)

df_with_metadata = df.withColumns({
    "_ingestion_timestamp": F.current_timestamp(),
    "_source_file": F.input_file_name(),
})

df_with_metadata.write.format("delta").mode("append").saveAsTable(bronze_path)

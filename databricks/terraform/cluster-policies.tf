resource "databricks_cluster_policy" "cost_optimized" {
  name = "Cost Optimized"
  definition = jsonencode({
    "autotermination_minutes" : { "type" : "range", "maxValue" : 30, "defaultValue" : 15 },
    "num_workers" : { "type" : "range", "maxValue" : 10 },
    "spark_conf.spark.databricks.cluster.profile" : { "type" : "fixed", "value" : "serverless" }
  })
}

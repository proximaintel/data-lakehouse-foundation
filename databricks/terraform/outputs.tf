output "workspace_url" {
  value = azurerm_databricks_workspace.main.workspace_url
}

output "storage_account_name" {
  value = azurerm_storage_account.lakehouse.name
}

resource "azurerm_resource_group" "lakehouse" {
  name     = "rg-lakehouse-${var.environment}-${var.location}"
  location = var.location
  tags     = var.tags
}

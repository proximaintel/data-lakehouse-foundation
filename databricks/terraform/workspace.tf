resource "azurerm_databricks_workspace" "main" {
  name                        = var.workspace_name
  resource_group_name         = azurerm_resource_group.lakehouse.name
  location                    = azurerm_resource_group.lakehouse.location
  sku                         = "premium"
  managed_resource_group_name = "rg-dbw-managed-${var.environment}"
  tags                        = var.tags

  custom_parameters {
    virtual_network_id                                   = azurerm_virtual_network.lakehouse.id
    private_subnet_name                                  = azurerm_subnet.private.name
    public_subnet_name                                   = azurerm_subnet.public.name
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
  }
}

resource "azurerm_virtual_network" "lakehouse" {
  name                = "vnet-lakehouse-${var.environment}"
  location            = azurerm_resource_group.lakehouse.location
  resource_group_name = azurerm_resource_group.lakehouse.name
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

resource "azurerm_subnet" "private" {
  name                 = "snet-dbw-private"
  resource_group_name  = azurerm_resource_group.lakehouse.name
  virtual_network_name = azurerm_virtual_network.lakehouse.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 8, 0)]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "public" {
  name                 = "snet-dbw-public"
  resource_group_name  = azurerm_resource_group.lakehouse.name
  virtual_network_name = azurerm_virtual_network.lakehouse.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 8, 1)]

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_network_security_group" "dbw" {
  name                = "nsg-dbw-${var.environment}"
  location            = azurerm_resource_group.lakehouse.location
  resource_group_name = azurerm_resource_group.lakehouse.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.dbw.id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.dbw.id
}

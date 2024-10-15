terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
}
provider "azurerm" {
  skip_provider_registration = true
  features {

  }
  subscription_id = "your-subscription-id"
  tenant_id       = "your-tenant-id"
  client_id       = "your-client-id"
  client_secret   = "your-client-secret"
}

resource "azurerm_resource_group" "dev" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "dev-vnet" {
  name = "dev-vnet"
  resource_group_name = var.resource_group_name
  location = var.location
  address_space = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name = "dev-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dev-vnet.name
  address_prefixes = var.subnet
}

resource "azurerm_network_security_group" "dev-nsg" {
  name = "dev-nsg"
  resource_group_name = var.resource_group_name
  location = var.location
  security_rule {
    name                       = "Inbound-3389"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "dev-nsg-ass" {
  subnet_id = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.dev-nsg.id
}

resource "azurerm_network_interface" "dev-nic" {
  name = "dev-nic"
  resource_group_name = var.resource_group_name
  location = var.location
  ip_configuration {
    name = "Internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.dev-vm-pubip.id
  }
 }

resource "azurerm_public_ip" "dev-vm-pubip" {
  name = "dev-vm-pubip"
  resource_group_name = var.resource_group_name
  location = var.location
  allocation_method = "Static"
  
}

resource "azurerm_windows_virtual_machine" "dev-vm" {
  name = "dev-vm1"
  resource_group_name = var.resource_group_name
  location = var.location
  network_interface_ids = [azurerm_network_interface.dev-nic.id]
  admin_username = "azureadmin"
  admin_password = "H@mdan123456"
  size = "Standard_F2"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.dev-uai.id]
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  } 
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "dev-kv123hhh" {
  name = "dev-kv123hhh"
  resource_group_name = var.resource_group_name
  location = var.location
  tenant_id = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled = true
  enable_rbac_authorization = true
  public_network_access_enabled = false
  sku_name = "standard"

}

resource "azurerm_private_dns_zone" "dev-prvdnszone" {
  name = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "dev-kv-prvep" {
  name = "dev-kv-prvep"
  location = var.location
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_key_vault.dev-kv123hhh]
  subnet_id = azurerm_subnet.subnet.id
  
  private_service_connection {
    is_manual_connection = "false"
    private_connection_resource_id = azurerm_key_vault.dev-kv123hhh.id
    name = "dev-kv-prvep1"
    subresource_names = ["Vault"]
  }
  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.dev-prvdnszone.id]
  }
}

resource "azurerm_user_assigned_identity" "dev-uai" {
  name = "dev-uai"
  resource_group_name = var.resource_group_name
  location = var.location
}

resource "azurerm_role_assignment" "dev-uai-kvrole" {
  scope = azurerm_resource_group.dev.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id = azurerm_user_assigned_identity.dev-uai.principal_id
}


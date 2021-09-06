#add provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.46.0"
    }
  }
}

#initialize provider
provider "azurerm" {
  features {

  }
}

#create resource group for sampleapi
resource "azurerm_resource_group" "tf_rg_sampleapi" {
  name     = "souravkartfrg"
  location = "eastus"
}

#create container group
resource "azurerm_container_group" "tf_cg_sampleapi" {
  name                = "cg_sampleapi"
  location            = azurerm_resource_group.tf_rg_sampleapi.location
  resource_group_name = azurerm_resource_group.tf_rg_sampleapi.name

  ip_address_type = "public"
  dns_name_label  = "sampleapitf"
  os_type         = "Linux"

  container {
    name   = "sampleapi"
    image  = "souravkar/sampleapi:v1.0.0"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}













# ARM_CLIENT_ID:a46fc178-ae2e-48b9-af7f-f3bb8bbce222
# ARM_CLIENT_SECRET:v38cN.yg0fq1osc4T~FXSy2_XybAlWH.6W
# ARM_TENANT_ID:e0aca919-c1f3-4216-bdf0-109be504f5d5
# ARM_SUBSCRIPTION_ID:e3852888-b6bb-4048-ac92-1439dd471cd7
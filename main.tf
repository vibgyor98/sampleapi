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

terraform {
  backend "azurerm" {
    resource_group_name  = "rg_storage_tf_state"
    storage_account_name = "tfstoragestate"
    container_name       = "tfdata"
    key                  = "terraform.tfstate"
  }
}

# use this varibale for tagging docker image
variable "imagebuild" {
  type        = string
  description = "the latest build version"
}

#create resource group for sampleapi
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

#create container group
# resource "azurerm_container_group" "tf_cg_sampleapi" {
#   name                = "cg_sampleapi"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_address_type = "public"
#   dns_name_label  = "sampleapitf"
#   os_type         = "Linux"

#   container {
#     name = "souravkar"
#     # image  = "souravkar.azurecr.io/sampleapi:${var.imagebuild}"
#     image  = "souravkar.azurecr.io/sampleapi"
#     cpu    = "1"
#     memory = "1"

#     ports {
#       port     = 80
#       protocol = "TCP"
#     }
#   }
# }


//Creating app service plan
resource "azurerm_app_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

//Creating app service with Container
resource "azurerm_app_service" "webapp" {
  # count = 2
  # name                = "${var.app_service_name}-${count.index}"
  # name                = element(var.app_service_name, count.index)
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id

  //Define conn string for ACR with deployed image
  site_config {
    app_command_line = ""
    # linux_fx_version = "DOCKER|appsvcsample/python-helloworld:latest"
    linux_fx_version         = "souravkar|souravkar.azurecr.io/sampleapi:${var.imagebuild}"
    dotnet_framework_version = "v5.0"
    scm_type                 = "LocalGit"
  }

  //Define ACR Server login url, username, password
  app_settings = {
    # "SOME_KEY" = "some-value"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    # "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
    "DOCKER_REGISTRY_SERVER_URL" = "souravkar.azurecr.io"
  }

  # connection_string {
  #   name  = "Database"
  #   type  = "SQLAzure"
  #   value = "Server=tcp:azurerm_sql_server.sqldb.fully_qualified_domain_name Database=azurerm_sql_database.db.name;User ID=azurerm_sql_server.sqldb.administrator_login;Password=azurerm_sql_server.sqldb.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  # }
}




# ARM_CLIENT_ID:a46fc178-ae2e-48b9-af7f-f3bb8bbce222
# ARM_CLIENT_SECRET:v38cN.yg0fq1osc4T~FXSy2_XybAlWH.6W
# ARM_TENANT_ID:e0aca919-c1f3-4216-bdf0-109be504f5d5
# ARM_SUBSCRIPTION_ID:e3852888-b6bb-4048-ac92-1439dd471cd7
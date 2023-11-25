terraform {
  required_providers {
     docker = {
        source = "kreuzwerker/docker"
        version = "3.0.2"
      }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
# data, cuz I am using existing resource group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# ACR
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true
}

# Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = var.service_plan_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# Linux WebApp
resource "azurerm_linux_web_app" "webapp" {
  name                  = var.webapp_name
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = data.azurerm_resource_group.rg.location
  service_plan_id       = azurerm_service_plan.appserviceplan.id
  # https_only            = true
  site_config {
    always_on = false
      application_stack {
      docker_image_name = "webimage:latest"
    }
  }
}



variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "acr_name" {
  type        = string
  description = "ACR name in Azure"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
}

variable "service_plan_name" {
  type        = string
  description = "App Service Plan name"
}

variable "webapp_name" {
  type        = string
  description = "WebApp name"
}


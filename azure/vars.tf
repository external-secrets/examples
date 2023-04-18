variable "demo_namespace" {
  default       = "eso-demo"
  description = "Namespace for the demo"
  sensitive = false
}

variable "azure_region" {
  default       = "westeurope"
  description = "Azure region"
  sensitive = false
}
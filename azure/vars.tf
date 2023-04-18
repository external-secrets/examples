variable "demo_namespace" {
  default     = "eso-demo"
  description = "Namespace for the demo"
  sensitive   = false
}

variable "azure_region" {
  default     = "westeurope"
  description = "Azure region"
  sensitive   = false
}

variable "chart_version" {
  default     = "0.8.1"
  description = "Version of the chart to deploy"
  sensitive   = false
}

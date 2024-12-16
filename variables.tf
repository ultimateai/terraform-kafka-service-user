variable "vault_mount" {
  description = "Vault's path mount"
  type        = string
}

variable "vault_path" {
  description = "Vault's secret path"
  type        = string
}

variable "aiven_project_name" {
  description = "Aiven project name"
  type        = string
}

variable "aiven_kafka_service_name" {
  description = "Aiven kafka service name"
  type        = string
}

variable "aiven_kafka_username" {
  description = "Aiven kafka username"
  type        = string
}

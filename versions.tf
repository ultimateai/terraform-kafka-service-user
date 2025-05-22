terraform {
  required_version = ">=1.0.0"

  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
    aiven = {
      source = "aiven/aiven"
    }
  }
}

# Terraform-kafka-service-user

Terraform module for creating a kafka user and the associated secrets (access key and access cert) in vault

## Provider configuration

In your calling terraform code, add make sure to add the proper vault-provider and aiven configuration: 

```
terraform {
  required_version = ">=1.2.0"

  required_providers {
    ...
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.5"
    }
    aiven = {
      source  = "aiven/aiven"
      version = "~> 4.30"
    }
  }
}

##There are several ways for auth vault-provider -- check https://registry.terraform.io/providers/hashicorp/vault/latest/docs#vault-authentication-configuration-options
provider "vault" {
  address = vault_http_address
  auth_login_userpass {
    username = "your_user"
    password = data.google_secret_manager_secret_version.vault_user.secret_data
  }
}

# Initialize provider. No other config options than api_token
provider "aiven" {
  api_token = data.google_secret_manager_secret_version.token.secret_data
}
```

Plus the data.tf

```
data "google_secret_manager_secret_version" "aiven_api_token" {
  provider = google-beta
  project  = gcp_project
  secret   = api_token_secret_name
}

data "google_secret_manager_secret_version" "vault_terraform_pass" {
  provider = google-beta
  project  = gcp_project
  secret   = vault_user_password
}
```

## How to use

```
module "create_kafka_service_user_test" {
  source = "git@github.com:ultimateai/terraform-kafka-service-user.git?ref=0.1.0"

  vault_mount = var.vault_mount
  vault_path  = "${var.vault_chapter}/${var.vault_environment}/${var.vault_service_name}"

  aiven_project_name       = var.aiven_project_name
  aiven_kafka_service_name = var.aiven_kafka_service_name
  aiven_kafka_username     = var.aiven_kafka_username
}
```

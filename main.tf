resource "aiven_kafka_user" "user" {
  service_name = var.aiven_kafka_service_name
  project      = var.aiven_project_name
  username     = var.aiven_kafka_username
}

resource "vault_kv_secret_v2" "secret" {
  mount               = var.vault_mount
  name                = "${var.vault_path}/kafka"
  delete_all_versions = false
  disable_read        = true

  data_json = jsonencode(
    {
      KAFKA_SSL_ACCESS_KEY  = "${aiven_kafka_user.user.access_key}"
      KAFKA_SSL_ACCESS_CERT = "${aiven_kafka_user.user.access_cert}"
    }
  )

  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

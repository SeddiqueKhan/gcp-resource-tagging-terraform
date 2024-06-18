resource "google_storage_bucket" "default" {
  name     = var.name
  location = var.location

  labels = var.labels

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = var.lifecycle_age
    }
  }
}

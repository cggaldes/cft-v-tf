resource "google_storage_bucket" "asset-landing-bkt" {
  name          = var.landing_bucket_name
  location      = "AUSTRALIA-SOUTHEAST1"
  project       = var.project_id
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket" "asset-processed-bkt" {
  name          = var.processed_bucket_name
  location      = "AUSTRALIA-SOUTHEAST1"
  project       = var.project_id
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}
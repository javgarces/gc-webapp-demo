resource "google_storage_bucket" "frontend_bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "public_read" {
  bucket = google_storage_bucket.frontend_bucket.name

  role = "roles/storage.objectViewer"
  members = [
    "allUsers"
  ]
}

# Service Account for frontend-backend auth
resource "google_service_account" "frontend_svc" {
  account_id   = var.frontend_service_account
  display_name = "Frontend Service Account"
}

# API Key for frontend to call backend
resource "google_api_key" "frontend_key" {
  display_name = "frontend-key"
}

output "bucket_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.frontend_bucket.name}/index.html"
}

output "frontend_api_key" {
  value = google_api_key.frontend_key.key_string
  sensitive = true
}

output "frontend_service_account_email" {
  value = google_service_account.frontend_svc.email
}

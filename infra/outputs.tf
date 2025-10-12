output "project_id" {
  value = var.project_id
}

output "bucket_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.frontend_bucket.name}/index.html"
}

output "frontend_api_key" {
  value     = google_api_key.frontend_key.key_string
  sensitive = true
}

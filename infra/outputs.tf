output "cloud_run_url" {
  description = "URL of the deployed Cloud Run backend"
  value       = google_cloud_run_service.backend.status[0].url
}

output "iap_client_id" {
  description = "OAuth client ID for IAP"
  value       = google_iap_client.iap_client.client_id
}

output "iap_client_secret" {
  description = "OAuth client secret for IAP"
  value       = google_iap_client.iap_client.client_secret
  sensitive   = true
}

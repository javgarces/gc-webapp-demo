output "cloud_run_url" {
  value = google_cloud_run_service.backend.status[0].url
}

output "iap_client_id" {
  value = google_iap_client.iap_client.client_id
}

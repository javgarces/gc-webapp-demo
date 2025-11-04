# outputs.tf

# Cloud Run service URL
output "cloud_run_url" {
  description = "The URL of the deployed Cloud Run backend service"
  value       = google_cloud_run_service.backend.status[0].url
}

# Artifact Registry repository name
output "artifact_registry_repo" {
  description = "Artifact Registry repository for backend images"
  value       = google_artifact_registry_repository.backend_repo.repository_id
}

# Cloud Run service name
output "cloud_run_service_name" {
  description = "The name of the Cloud Run service"
  value       = google_cloud_run_service.backend.name
}

# Cloud Run IAM member for deployer service account
output "deployer_iam_member" {
  description = "IAM member allowing deployer SA to invoke Cloud Run"
  value       = google_cloud_run_service_iam_member.noauth.member
}

# Allowed user for IAP access
output "allowed_user_iap_member" {
  description = "User allowed to access the Cloud Run service via IAP"
  value       = google_iap_web_backend_service_iam_member.access.member
}

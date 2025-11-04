# outputs.tf

output "cloud_run_url" {
  description = "The URL of the deployed Cloud Run backend service"
  value       = google_cloud_run_service.backend.status[0].url
}

output "artifact_registry_repo" {
  description = "Artifact Registry repository for backend images"
  value       = google_artifact_registry_repository.backend_repo.repository_id
}

output "cloud_run_service_name" {
  description = "The name of the Cloud Run service"
  value       = google_cloud_run_service.backend.name
}

output "deployer_iam_member" {
  description = "IAM member allowing deployer SA to invoke Cloud Run"
  value       = google_cloud_run_service_iam_member.noauth.member
}

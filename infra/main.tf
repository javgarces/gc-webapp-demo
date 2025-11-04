# Artifact Registry for Docker images
resource "google_artifact_registry_repository" "backend_repo" {
  project     = var.project_id
  location    = var.region
  repository_id = var.repo_name
  description = "Docker repository for backend images"
  format      = "DOCKER"
  mode        = "STANDARD_REPOSITORY"
}

# Cloud Run backend service
resource "google_cloud_run_service" "backend" {
  name     = "gc-demo-backend"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repo_name}/demo-backend:latest"
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow deployer SA to invoke Cloud Run
resource "google_cloud_run_service_iam_member" "noauth" {
  service    = google_cloud_run_service.backend.name
  location   = var.region
  project    = var.project_id
  role       = "roles/run.invoker"
  member     = "serviceAccount:${var.deployer_sa_email}"
}

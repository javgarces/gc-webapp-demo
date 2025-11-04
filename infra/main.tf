# IAP Brand (OAuth consent screen)
resource "google_iap_brand" "brand" {
  project           = var.project_id
  application_title = "Demo IAP App"
  support_email     = var.support_email
}

# IAP OAuth Client
resource "google_iap_client" "iap_client" {
  brand        = google_iap_brand.brand.name
  display_name = "Demo IAP Client"
}

# Cloud Run service pointing to Artifact Registry
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

  traffics {
    percent         = 100
    latest_revision = true
  }
}

# Allow deployer SA to invoke service
resource "google_cloud_run_service_iam_member" "noauth" {
  service    = google_cloud_run_service.backend.name
  location   = var.region
  project    = var.project_id
  role       = "roles/run.invoker"
  member     = "serviceAccount:${var.deployer_sa_email}"
}

# Allow allowed user to access via IAP
resource "google_iap_web_backend_service_iam_member" "access" {
  project = var.project_id
  role    = "roles/iap.httpsResourceAccessor"
  member  = "user:${var.allowed_user_email}"

  web_backend_service = google_cloud_run_service.backend.id
}

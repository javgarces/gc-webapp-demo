terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs
resource "google_project_service" "services" {
  for_each = toset([
    "run.googleapis.com",
    "iap.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ])
  project = var.project_id
  service = each.key
}

# Create a Cloud Run service
resource "google_cloud_run_service" "backend" {
  name     = "demo-backend"
  location = var.region

  template {
    spec {
      containers {
        image = var.container_image
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

  autogenerate_revision_name = true
}

# Allow only IAP to access Cloud Run
resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.backend.name
  location = google_cloud_run_service.backend.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Backend service for IAP
resource "google_iap_web_backend_service" "iap_backend" {
  name             = "iap-backend"
  project          = var.project_id
  backend_service  = google_cloud_run_service.backend.status[0].url
  access_settings {
    gcip_settings {}
  }
}

# IAP brand (OAuth consent screen)
resource "google_iap_brand" "brand" {
  support_email = var.support_email
  application_title = "Demo IAP App"
  project = var.project_id
}

# OAuth client for IAP
resource "google_iap_client" "iap_client" {
  brand         = google_iap_brand.brand.name
  display_name  = "Demo IAP Client"
}

# Allow specific user(s)
resource "google_iap_web_backend_service_iam_member" "access" {
  web_backend_service = google_iap_web_backend_service.iap_backend.name
  role                = "roles/iap.httpsResourceAccessor"
  member              = "user:${var.allowed_user_email}"
}

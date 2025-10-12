variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "Region to deploy resources in"
  type        = string
  default     = "australia-southeast1"
}

variable "container_image" {
  description = "Docker image to deploy to Cloud Run"
  type        = string
}

variable "support_email" {
  description = "Email for OAuth consent screen"
  type        = string
}

variable "allowed_user_email" {
  description = "Email allowed to access IAP"
  type        = string
}

variable "deployer_sa_email" {
  description = "Service account email for GitHub Actions deployments"
  type        = string
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "australia-southeast1"
}

variable "deployer_sa_email" {
  type        = string
  description = "Service account email for deployment"
}

variable "allowed_user_email" {
  type        = string
  description = "User allowed to access IAP"
}

variable "support_email" {
  type        = string
  description = "Support email for IAP brand"
}

variable "repo_name" {
  type        = string
  description = "Artifact Registry repository name"
  default     = "demo-backend-repo"
}

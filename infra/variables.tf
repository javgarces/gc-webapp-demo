variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "deployer_sa_email" {
  description = "Service account email for GitHub Actions deployments"
  type        = string
}

variable "wif_provider" {
  description = "Workload Identity Federation provider full path"
  type        = string
}

variable "allowed_user_email" {
  description = "Email allowed to access IAP-protected backend"
  type        = string
}

variable "support_email" {
  description = "Email used for OAuth consent screen (IAP brand)"
  type        = string
}

variable "region" {
  description = "GCP region for Cloud Run"
  type        = string
  default     = "australia-southeast1"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Default region"
  default     = "australia-southeast1"
}

variable "bucket_name" {
  type        = string
  description = "Name of the static hosting bucket"
}

variable "frontend_service_account" {
  type        = string
  description = "Name of the service account for frontend to backend auth"
  default     = "frontend-svc"
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to deploy resources"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "Environment label"
  type        = string
  default     = "dev"
}

variable "team" {
  description = "Team label"
  type        = string
  default     = "example-team"
}

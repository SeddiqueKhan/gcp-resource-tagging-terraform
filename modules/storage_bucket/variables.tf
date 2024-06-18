variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "name" {
  description = "Name of the storage bucket"
  type        = string
}

variable "location" {
  description = "Location of the bucket"
  type        = string
}

variable "labels" {
  description = "Labels for the bucket"
  type        = map(string)
}

variable "lifecycle_age" {
  description = "Lifecycle rule age"
  type        = number
  default     = 30
}

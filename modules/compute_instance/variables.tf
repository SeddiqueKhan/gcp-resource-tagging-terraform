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
  description = "Name of the instance"
  type        = string
}

variable "machine_type" {
  description = "Type of the machine"
  type        = string
}

variable "zone" {
  description = "Zone where the instance will be created"
  type        = string
}

variable "labels" {
  description = "Labels for the instance"
  type        = map(string)
}

variable "boot_image" {
  description = "Boot disk image"
  type        = string
}
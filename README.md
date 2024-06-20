# GCP Resource tagging using Terraform

[![Mikaeel Khalid](https://badgen.now.sh/badge/by/mikaeelkhalid/purple)](https://github.com/mikaeelkhalid)

This repository provides examples and modules for tagging/labeling Google Cloud Platform (GCP) resources using Terraform. The goal is to demonstrate best practices for managing tags/labels in GCP to help with organization, billing, and resource management.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Usage](#usage)
  - [Step 1: Clone the Repository](#step-1-clone-the-repository)
  - [Step 2: Initialize and Apply Terraform Configuration](#step-2-initialize-and-apply-terraform-configuration)
  - [Step 3: Modify Variables as Needed](#step-3-modify-variables-as-needed)
- [Modules](#modules)
  - [Compute Instance Module](#compute-instance-module)
  - [Storage Bucket Module](#storage-bucket-module)
- [Contributing](#contributing)

## Introduction

This project demonstrates how to use Terraform to create and manage GCP resources with appropriate tagging/labeling. Tags/labels are essential for managing and organizing resources, especially in large projects or organizations.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and configured
- A GCP account and project

## Project Structure

```
gcp-resource-tagging-terraform/
├── modules/
│   ├── compute_instance/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── storage_bucket/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
├── .gitignore
├── LICENSE
├── main.tf
├── README.md
├── variables.tf
└── versions.tf
```

## Usage

### Step 1: Clone the Repository

```sh
git clone https://github.com/mikaeelkhalid/gcp-resource-tagging-terraform.git
cd gcp-resource-tagging-terraform
```

### Step 2: Initialize and Apply Terraform Configuration

```sh
terraform init
terraform apply
```

### Step 3: Modify Variables as Needed

Update `variables.tf` or provide a `terraform.tfvars` file with your own values.

## Modules

### Compute Instance Module

The Compute Instance module allows you to create and manage GCP compute instances with specific labels.

#### `modules/compute_instance/main.tf`
```hcl
resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  labels = var.labels

  boot_disk {
    initialize_params {
      image = var.boot_image
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }
}
```

#### `modules/compute_instance/variables.tf`
```hcl
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
```

#### `modules/compute_instance/outputs.tf`
```hcl
output "instance_name" {
  description = "The name of the compute instance"
  value       = google_compute_instance.default.name
}

output "instance_self_link" {
  description = "The self-link of the compute instance"
  value       = google_compute_instance.default.self_link
}
```

#### `modules/compute_instance/versions.tf`
```hcl
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
```

### Storage Bucket Module

The Storage Bucket module allows you to create and manage GCP storage buckets with specific labels and lifecycle rules.

#### `modules/storage_bucket/main.tf`
```hcl
resource "google_storage_bucket" "default" {
  name     = var.name
  location = var.location

  labels = var.labels

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = var.lifecycle_age
    }
  }
}
```

#### `modules/storage_bucket/variables.tf`
```hcl
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
```

#### `modules/storage_bucket/outputs.tf`
```hcl
output "bucket_name" {
  description = "The name of the storage bucket"
  value       = google_storage_bucket.default.name
}

output "bucket_self_link" {
  description = "The self-link of the storage bucket"
  value       = google_storage_bucket.default.self_link
}
```

#### `modules/storage_bucket/versions.tf`
```hcl
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
```

## Root Configuration

### `main.tf`
```hcl
module "compute_instance" {
  source = "./modules/compute_instance"

  project_id = var.project_id
  region     = var.region

  name         = "devops-compute-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  labels = {
    environment = "dev"
    team        = "devops-team"
  }

  boot_image = "debian-cloud/debian-11"
}

module "storage_bucket" {
  source = "./modules/storage_bucket"

  project_id = var.project_id
  region     = var.region

  name     = "devops-storage-bucket"
  location = "EU"

  labels = {
    environment = "dev"
    team        = "devops-team"
  }

  lifecycle_age = 30
}
```

### `variables.tf`
```hcl
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
```

### `versions.tf`
```hcl
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature-name`).
3. Make your changes.
4. Commit your changes (`git commit -m 'add some feature'`).
5. Push to the branch (`git push origin feature/your-feature-name`).
6. Open a pull request.

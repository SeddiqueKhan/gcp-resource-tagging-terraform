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

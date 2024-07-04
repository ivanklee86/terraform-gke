terraform {
  backend "gcs" {
    bucket = "hamster-sandbox-terraform"
    prefix = "terraform/state/gke"
  }
}
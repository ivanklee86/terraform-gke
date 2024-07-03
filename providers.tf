terraform {
  required_version = ">= 1.8"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.0.0"
    }
  }
}
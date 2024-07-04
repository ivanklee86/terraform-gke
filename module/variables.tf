# General
variable "name" {
  type        = string
  description = "Terraform stack name."
}

variable "project" {
  type        = string
  description = "GCP Project to create resources in."
}

# VPC
variable "cidr_range" {
  type = string
  description = "CIDR range for VPC."
  default = "10.2.0.0/16"
}

variable "services_range" {
  type = string
  description = "CIDR range for VPC."
  default = "192.168.0.0/24"
}

variable "pods_range" {
  type = string
  description = "CIDR range for VPC."
  default = "192.168.64.0/22"
}

variable "subnets" {
  type = list(object({
    name = string
    cidr_range = string
  }))
  description = "Additional subnets for VPC."
  default = []
}

# EKS
variable "region" {
  type        = string
  description = "Region to launch resources in"
}

variable "node_pool" {
  type = list(object({
    name                  = string
    service_account_email = optional(string)
    machine_type          = string
    min_nodes             = number
    max_nodes             = number
  }))
  description = "Configuration for subnetworks.  Note: name var should match subnet name"
}
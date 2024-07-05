# - VPC network
resource "google_compute_network" "network" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

# - Subnet for Kubernetes with service/pod IP ranges
resource "google_compute_subnetwork" "k8s_subnet" {
  name                     = var.name
  ip_cidr_range            = var.cidr_range
  network                  = google_compute_network.network.id
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = "service-ranges"
    ip_cidr_range = var.services_range
  }

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = var.pods_range
  }
}

# - Additional subnetworks
resource "google_compute_subnetwork" "additional_subnetworks" {
  for_each = { for each in var.subnets : each.name => each }

  name                     = each.value.name
  ip_cidr_range            = each.value.cidr_range
  network                  = google_compute_network.network.id
  private_ip_google_access = true
}

# - Firewall Rules
# Only simple rule for troubleshooting, otherwise no access.
resource "google_compute_firewall" "firewall" {
  name    = "${var.name}-firewall"
  network = google_compute_network.network.name

  source_ranges = [
    "35.235.240.0/20", # GCP console access
  ]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion"]
}
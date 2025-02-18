# - Default Service Account
# This is used by node pools if no service account is specified.
# TODO: Add default permissions like internal Docker registry pull permissions.
resource "google_service_account" "cluster_default" {
  account_id   = "${var.name}-service-account"
  display_name = "${var.name} - Service Account"
}

# - K8s cluster
resource "google_container_cluster" "cluster" {
  name     = var.name
  location = var.region

  # Start with 0 nodes and delete in favor of node pools.
  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = var.deletion_protection

  network    = google_compute_network.network.id
  subnetwork = google_compute_subnetwork.k8s_subnet.id

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.k8s_subnet.secondary_ip_range[1].range_name
    services_secondary_range_name = google_compute_subnetwork.k8s_subnet.secondary_ip_range[0].range_name
  }
}

# - K8s Node Pools
resource "google_container_node_pool" "node_pool" {
  for_each = { for each in var.node_pool : each.name => each }

  name    = each.value.name
  cluster = google_container_cluster.cluster.id

  node_config {
    machine_type = each.value.machine_type

    service_account = each.value.service_account_email != null ? each.value.service_account_email : google_service_account.cluster_default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  autoscaling {
    min_node_count = each.value.min_nodes
    max_node_count = each.value.max_nodes
  }
}
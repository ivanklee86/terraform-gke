module "cluster" {
  source = "../module"

  name    = "test"
  project = "hamster-sandbox-428309"
  region  = "us-central1"

  cidr_range     = "10.2.0.0/16"
  services_range = "192.168.0.0/24"
  pods_range     = "192.168.64.0/20"

  deletion_protection = false

  subnets = [
    {
      name       = "subnet1"
      cidr_range = "10.4.0.0/16"
    }
  ]

  node_pool = [
    {
      name         = "group1"
      machine_type = "e2-medium"
      min_nodes    = 1
      max_nodes    = 3
    },
    {
      name         = "group2"
      machine_type = "e2-medium"
      min_nodes    = 1
      max_nodes    = 3
    },
  ]
}
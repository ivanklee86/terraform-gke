module "cluster" {
  source = "../module"

  name    = "test"
  project = "hamster-sandbox-428309"
  region  = "us-central1"

  node_pool = [
    {
      name         = "group1"
      machine_type = "e2-micro"
      min_nodes    = 1
      max_nodes    = 2
    },
    {
      name         = "group2"
      machine_type = "e2-micro"
      min_nodes    = 1
      max_nodes    = 2
    },
  ]
}
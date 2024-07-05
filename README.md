# **terraform-gke** module

This repository contains...
- ...a Terraform module to create a GCP Kubernetes Engine cluster and accoutrement in the `modules` folder.
- ...an example usage in the `examples` folder.
- ...a [`devcontainer`](https://containers.dev/) with necessary (or just helpful) tooling.
- ...a [Taskfile](https://taskfile.dev/) that automates common tasks.

## Pre-requisites

1. Clone the repository.
2. Start the devcontainer in VSCode or your favorite IDE.
    - Alternatively, run the following commands to run things in a vanilla Docker container.
    ```
    docker build -t devcontainer -f ./.devcontainer/Dockerfile .
    docker run -it --entrypoint bash -v `pwd`:/code devcontainer:latest
    ```
3. Run `task auth` to authenticate to GCP. 
    - **[SHOULD]** You should update the PROJECT_ID env variable (either via shell, CLI or by eiting the file).

## Plaing around with the module.
1. Go to the `examples` folder and update the example configuration.
    - **[SHOULD]** Update where or how you're storing your Terraform remote state.
    - [CAN] Update default variables
2. Run `tofu plan -out=plan.tfplan` to generate plan.
3. Run `tofu apply plan.tfplan` to apply.
4. Run `task kubeconfig` to set up kubeconfig.

## Cleaning up
1. Set the `deletion_protection` variable to `false` and apply changes.
2. Run `tofu destroy`.

## Testing out the k8s cluster
- `kubectl apply -f manifests/hamsterwheel.yaml` will create a silly simple pod.
- [k9s](https://k9scli.io/) is included in the image for troubleshooting.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_range"></a> [cidr\_range](#input\_cidr\_range) | CIDR range for VPC. | `string` | `"10.2.0.0/16"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Set to false before deleting cluster | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Terraform stack name. | `string` | n/a | yes |
| <a name="input_node_pool"></a> [node\_pool](#input\_node\_pool) | Configuration for subnetworks.  Note: name var should match subnet name | <pre>list(object({<br>    name                  = string<br>    service_account_email = optional(string)<br>    machine_type          = string<br>    min_nodes             = number<br>    max_nodes             = number<br>  }))</pre> | n/a | yes |
| <a name="input_pods_range"></a> [pods\_range](#input\_pods\_range) | CIDR range for VPC. Should contain (2 x max # of pods (110) x max # of nodes) IPs. | `string` | `"192.168.64.0/22"` | no |
| <a name="input_project"></a> [project](#input\_project) | GCP Project to create resources in. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to launch resources in | `string` | n/a | yes |
| <a name="input_services_range"></a> [services\_range](#input\_services\_range) | CIDR range for VPC. | `string` | `"192.168.0.0/24"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Additional subnets for VPC. | <pre>list(object({<br>    name       = string<br>    cidr_range = string<br>  }))</pre> | n/a | yes |
## Outputs

No outputs.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 5.0.0 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.0.0 |
## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.additional_subnetworks](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.k8s_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_service_account.cluster_default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

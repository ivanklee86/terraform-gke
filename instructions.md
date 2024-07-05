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

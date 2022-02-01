# 

This is an example to show how to use multiple Terraform providers using Terragrunt while also keeping a clean and concise folder structure without losing the flexibility of terraform and terragrunt.

## Requirements

- Minikube
- Terraform (or just TFenv)
- Terragrunt 
- TGenv
- TFenv
- Kubectl/lens/k9s (or an equivalent)

## Quickstart

Start your minikube

```
minikube start
```

Create the namespace on the cluster:

```
cd providers/kubernetes/minikube/namespaces/ci-cd
terragrunt apply --auto-approve
cd -
```

Create the Jenkins instances:

```
cd providers/helm/minikube/release/ci-cd
terragrunt run-all apply --terragrunt-non-interactive --auto-approve
```

## Quick quickstart

Start your minikube

```
minikube start
```

Create the Jenkins instances (Terragrunt will create the namespace as a dependency for you):

```
cd providers/helm/minikube/release/ci-cd
terragrunt run-all apply --terragrunt-non-interactive --auto-approve
```

## Validation

Checking if the resources are running:
```
```

Checking the set resource values:
```
```

Check the kustomization created files:
```
```

## Testing

TBD

## Folder structure

- Modules

    This is where the dragons lives, any resource that you can serve should reside here, accepting and exposing simple values while keeping all the complex logic away from the resources. Always create a `resources` folder for your modules, this will help to keep things organized if you ever need to create a datasource module, like this:

    ```
    .
    └── modules
        └── helm
            ├── datasources
            └── resources
    ```

    Some tips:
    - Add as much custom validations as you can;
    - It's fine to keep complex things on your modules as long as it's removing complexity from the resources.

- Providers

    The top level structure keeps all the current providers in use, inside this folder you will have all the resources created using this provider. You might have folders above your resources if they can be created on multiple places following this pattern `<provider-name>/<location>/<resource-type>/<resource-name>`. For example.:

    - `helm/my-eks-cluster/my-namespace/release/my-release`, where:
        - `helm` - Provider name
        - `my-eks-cluster/my-namespace` - Location
        - `release` - Resource type
        - `my-release` - Resource name

    - `kubernetes/aws/account-123/us-east-1/my-eks-cluster/{namespaces,deployments,servces}/my-resource`, where:
        - `kubernetes` - Provider name
        - `aws/account-123/us-east-1/my-eks-cluster` - Location
        - `{namespaces,deployments,servces}` - Resource type
        - `my-resource` - Resource name

## Drawbacks

- 
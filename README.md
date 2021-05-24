# terraform-infrastructure-template

Terraform template repository for infrastructures projects

## Requirements

### 1. terraform

In order to manage the suitable version of terraform it is strongly recommended to install the following tool:

- [tfenv](https://github.com/tfutils/tfenv): **Terraform** version manager inspired by rbenv.

Once these tools have been installed, install the terraform version shown in:

- .terraform-version

After installation install terraform:

```sh
tfenv install
```

## Terraform modules

Available PagoPA terraform modules:

- [azurerm](https://github.com/pagopa/azurerm): **Azure** terraform modules
- [azuredevops-tf-modules](https://github.com/pagopa/azuredevops-tf-modules): **Azure DevOps** terraform modules

## Apply changes

To apply changes follow the standard terraform lifecycle once the code in this repository has been changed:

```sh
terraform init

terraform plan

terraform apply
```

## Terraform lock.hcl

We have both developers who work with your Terraform configuration on their Linux, macOS or Windows workstations and automated systems that apply the configuration while running on Linux.
https://www.terraform.io/docs/cli/commands/providers/lock.html#specifying-target-platforms

So we need to specify this in terraform lock providers:

```sh
terraform init

rm .terraform.lock.hcl

terraform providers lock \
  -platform=windows_amd64 \
  -platform=darwin_amd64 \
  -platform=linux_amd64
```

## Precommit checks

Check your code before commit.

https://github.com/antonbabenko/pre-commit-terraform#how-to-install

```sh
pre-commit run -a
```

#!/bin/bash

env=$1

rm -rf env/$env/backend.tfvars

cp env/$env/backend_old.tfvars env/$env/backend.tfvars

bash terraform.sh init $env

terraform state pull > .terraform/tfstate.json

rm -rf env/$env/backend.tfvars

cp env/$env/backend_new.tfvars env/$env/backend.tfvars

bash terraform.sh init $env

terraform state push -force .terraform/tfstate.json

rm -rf .terraform/tfstate.json

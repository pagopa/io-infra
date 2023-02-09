#!/bin/bash

set -e

action=$1
env=$2
shift 2
other=$@

if [ -z "$action" ]; then
  echo "Missed action: init, apply, plan"
  exit 0
fi

if [ -z "$env" ]; then
  echo "env should be: dev, uat or prod."
  exit 0
fi

source "./env/$env/backend.ini"
az account set -s "${subscription}"

if [ "$action" = "force-unlock" ]; then
  echo "🧭 terraform INIT in env: ${env}"
  terraform init -reconfigure -backend-config="./env/$env/backend.tfvars" $other
  warn_message="You are about to unlock Terraform's remote state.
  This is a dangerous task you want to be aware of before going on.
  This operation won't affect your infrastructure directly.
  However, please note that you may lose pieces of information about partially-applied configurations.

  Please refer to the official Terraform documentation about the command:
  https://developer.hashicorp.com/terraform/cli/commands/force-unlock"
  printf "\n\e[33m%s\e[0m\n\n" "$warn_message"

  read -r -p "Please enter the LOCK ID: " lock_id
  terraform force-unlock "$lock_id"

  exit 0 # this line prevents the script to go on
fi

if echo "init plan apply refresh import output state taint destroy" | grep -w $action > /dev/null; then
  if [ $action = "init" ]; then
    terraform $action -reconfigure -backend-config="./env/$env/backend.tfvars" $other
  elif [ $action = "output" ] || [ $action = "state" ] || [ $action = "taint" ]; then
    # init terraform backend
    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
    terraform $action $other
  else
    # init terraform backend
    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
    terraform $action -var-file="./env/$env/terraform.tfvars" $other
  fi
else
    echo "Action not allowed."
    exit 1
fi

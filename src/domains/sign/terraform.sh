#!/bin/bash

set -e

action=$1
env=$2
IFS=" " read -r -a other <<< "${@:3}"

if [ -z "$action" ]; then
  echo "Missed action: init, apply, plan"
  exit 0
fi

if [ -z "$env" ]; then
  echo "env should be: dev, uat or prod."
  exit 0
fi

# shellcheck source=./env/prod/backend.ini
source "./env/$env/backend.ini"
az account set -s "${subscription}"

if echo "init plan apply refresh import output state taint destroy" | grep -w "$action" > /dev/null; then
  if [ "$action" = "init" ]; then
    echo "🧭 terraform INIT in env: ${env}"

    terraform "$action" -reconfigure -backend-config="./env/$env/backend.tfvars" "${other[@]}"
  elif [ "$action" = "output" ] || [ "$action" = "state" ] || [ "$action" = "taint" ]; then
    echo "🧭 terraform (output|state|taint) launched with action: ${action} in env: ${env}"

    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
    terraform "$action" "${other[@]}"
  else
    echo "🧭 terraform launched with action: ${action} in env: ${env} into folder $(pwd)"

    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
    terraform "$action" -var-file="./env/$env/terraform.tfvars" "${other[@]}"
  fi
else
    echo "Action not allowed."
    exit 1
fi

#!/bin/bash

function removeAndImport() {
    ########################################
    # Remove and import a Terraform resource
    ########################################
    local old_resource_name="$1"
    # Square brackets are not processed normally by grep, otherwise
    esc_old_resource_name=$(echo "$old_resource_name" | sed 's/\[/\\[/g; s/\]/\\]/g')

    local new_resource_name="$2"

    local myenv="$3"

    # Check if terraform.sh exists in the current folder
    if ! which ./terraform.sh &> /dev/null; then
        echo "No terraform.sh found!"
        exit 1
    fi

    if [ -z "$old_resource_name" ] || [ -z "$new_resource_name" ] || [ -z "$myenv" ]; then
        echo "You need to define the resources to be removed and imported in order to proceed and the environment to be used!!"
    exit 1
    fi
    if [ "$(terraform show | grep $esc_old_resource_name)" ]; then
        # Get the resource ID
        function_app_id=$(terraform show -json | jq --arg resource "$old_resource_name" '.values.root_module.child_modules[].resources[] | select(.address==$resource).values.id' | tr -d '"')
        echo "function_app_id: ${function_app_id}"
        # Import the resource
        echo "Importing..."
        ./terraform.sh import $myenv $new_resource_name $function_app_id 
        if [ $? -eq 0 ]; then
            echo "Successfully imported the resource with ID: $function_app_id"
            # Remove the resource from the state file
            echo "Removing..."
            terraform state rm "$old_resource_name"
            if [ $? -eq 0 ]; then
                echo "$old_resource_name removed"
            else
                echo "I can't remove the resource $old_resource_name from your Terraform state"
            fi
        else
            echo "I can't import the resource $new_resource_name"
        fi
    else
        echo "I can't find the resource $old_resource_name in your Terraform state"
    fi
}

# Check if the "Terraform" and "jq" commands are available
if ! which terraform &> /dev/null && which jq &> /dev/null; then
  echo "Please install terraform and jq before proceeding."
  exit 1
fi

removeAndImport "module.function_lollipop[0].azurerm_function_app.this" "module.function_lollipop[0].azurerm_linux_function_app.this" weu-prod01

removeAndImport "module.function_lollipop[0].azurerm_app_service_plan.this[0]" "module.function_lollipop[0].azurerm_service_plan.this[0]" weu-prod01

removeAndImport "module.function_lollipop_staging_slot[0].azurerm_function_app_slot.this" "module.function_lollipop_staging_slot[0].azurerm_linux_function_app_slot.this" weu-prod01

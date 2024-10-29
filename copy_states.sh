#!/bin/bash

# Variables - Set your own values here
DEST_STORAGE_ACCOUNT_NAME="iopitntfst001"
DEST_CONTAINER_NAME="terraform-state"

# Array of state files with corresponding source storage account and container
# Format: "source_storage_account_name:source_container_name:state_file_name"
STATE_FILES=(
"tfinfprodio:terraform-state:io-infra.aks-platform-weu-beta.tfstate"
# "tfinfprodio:terraform-state:io-infra.aks-platform-weu-prod01.tfstate"
# "tfinfprodio:terraform-state:io-infra.aks-platform-weu-prod02.tfstate"
# "tfinfprodio:terraform-state:io-infra.cgn.tfstate"
# "tfinfprodio:terraform-state:io-infra.citizen-auth-app-weu-prod01.tfstate"
# "tfinfprodio:terraform-state:io-infra.citizen-auth-common-prod.tfstate"
# "tfinfprodio:terraform-state:io-infra.continua.tfstate"
# "tfinfprodio:terraform-state:io-infra.elk-weu-beta.tfstate"
# "tfinfprodio:terraform-state:io-infra.elt.tfstate"
# "tfinfprodio:terraform-state:io-infra.eucovidcert.tfstate"
# "tfinfprodio:terraform-state:io-infra.functions.tfstate"
# "tfinfprodio:terraform-state:io-infra.ioweb-app-weu-prod01.tfstate"
# "tfinfprodio:terraform-state:io-infra.ioweb-common-prod.tfstate"
# "tfinfprodio:terraform-state:io-infra.messages-app-weu-beta.tfstate"
# "tfinfprodio:terraform-state:io-infra.messages-app-weu-prod01.tfstate"
# "tfinfprodio:terraform-state:io-infra.messages-app-weu-prod02.tfstate"
# "tfinfprodio:terraform-state:io-infra.messages-common-prod.tfstate"
# "tfinfprodio:terraform-state:io-infra.payments-app-weu-beta.tfstate"
# "tfinfprodio:terraform-state:io-infra.payments-app-weu-prod01.tfstate"
# "tfinfprodio:terraform-state:io-infra.payments-app-weu-prod02.tfstate"
# "tfinfprodio:terraform-state:io-infra.payments-common-prod.tfstate"
# "tfinfprodio:terraform-state:io-infra.profile-app-weu-beta.tfstate"
# "tfinfprodio:terraform-state:io-infra.profile-app-weu-prod01.tfstate"
# "tfinfprodio:terraform-state:io-infra.profile-app-weu-prod02.tfstate"
# "tfinfprodio:terraform-state:io-infra.profile-common-prod.tfstate"
# "tfinfprodio:terraform-state:io-infra.selfcare.tfstate"
# "tfinfprodio:terraform-state:io-infra.github-runner.tfstate"
# "tfappprodio:terraform-state:io-infra.identity.tfstate"
# "tfappprodio:terraform-state:io-infra.load-test.tfstate"
# "tfinfprodio:terraform-state:packer-terraform.tfstate"
# "tfappprodio:terraform-state:io-infra.repository.tfstate"
)

# Install azcopy if not already installed
if ! command -v azcopy &> /dev/null
then
    echo "azcopy could not be found. Installing..."
    brew install azcopy
    echo "azcopy installed."
else
    echo "azcopy is already installed."
fi

# Login to destination storage account
echo "Logging in to destination storage account..."
# azcopy login

# Copy specified files from their respective source storage accounts to the destination
for entry in "${STATE_FILES[@]}"; do
    # Extract source account, container, and file name
    IFS=":" read -r SOURCE_STORAGE_ACCOUNT_NAME SOURCE_CONTAINER_NAME STATE_FILE <<< "$entry"

    # Login to the source storage account
    echo "Logging in to source storage account $SOURCE_STORAGE_ACCOUNT_NAME..."
    # azcopy login

    # Copy the file from source to destination
    echo "Copying $STATE_FILE from $SOURCE_STORAGE_ACCOUNT_NAME to $DEST_STORAGE_ACCOUNT_NAME..."
    azcopy copy "https://$SOURCE_STORAGE_ACCOUNT_NAME.blob.core.windows.net/$SOURCE_CONTAINER_NAME/$STATE_FILE" "https://$DEST_STORAGE_ACCOUNT_NAME.blob.core.windows.net/$DEST_CONTAINER_NAME/$STATE_FILE"
done

echo "Copy completed for selected files."

# List copied files in the destination to verify
echo "Verifying files in the destination storage account..."
azcopy list "https://$DEST_STORAGE_ACCOUNT_NAME.blob.core.windows.net/$DEST_CONTAINER_NAME"

echo "All done."
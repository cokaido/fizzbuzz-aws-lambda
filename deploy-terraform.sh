#!/bin/sh

APP_NAME=$2

ENV=$1
#echo "Environment = $ENV"
printf "Argument env is %s\n" "$ENV"
cd terraform
rm -rf ./.terraform/modules
terraform init -backend-config "key=${APP_NAME}-${ENV}-terraform.tfstate" -migrate-state
terraform apply -var="environment=${ENV}" -var="app_name=${APP_NAME}" -auto-approve

cd ..

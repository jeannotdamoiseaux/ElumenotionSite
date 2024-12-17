#!/bin/bash

echo "LibreChat Azure Deployment Script"
echo "================================="

# Vraag om de benodigde informatie
read -p "Enter the deployment name (e.g., librechat): " deployment_name
read -p "Enter your preferred Azure location for the resource group (e.g., eastus): " location
read -p "Enter the desired resource group name: " resource_group
read -p "Enter the Azure OpenAI service location (e.g., eastus): " openai_location

# Bevestig de ingevoerde gegevens
echo ""
echo "You entered the following details:"
echo "Deployment Name: $deployment_name"
echo "Resource Group Location: $location"
echo "Resource Group Name: $resource_group"
echo "OpenAI Service Location: $openai_location"
echo ""

read -p "Is this information correct? (y/n): " confirm

if [[ $confirm == [Yy]* ]]; then
    # Voer de deployment uit
    echo "Starting deployment..."
    az deployment sub create \
        --name "$deployment_name" \
        --location "$location" \
        --template-file ./rg.bicep \
        --parameters resourcegroup="$resource_group" \
                     location="$location" \
                     openAiService_location="$openai_location"
    
    echo "Deployment initiated. Check the Azure portal for progress and any potential errors."
else
    echo "Deployment cancelled. Please run the script again with the correct information."
fi
#!/bin/bash

# Function to approve private endpoints for a given resource ID
approve_private_endpoint() {
    local resource_id="$1"
    text=$(az network private-endpoint-connection list --id "$resource_id")
    pendingPE=$(echo "$text" | jq -r '.[] | select(.properties.privateLinkServiceConnectionState.status == "Pending") | .id')
    for id in $pendingPE; do
        echo "$id is in a pending state"
        az network private-endpoint-connection approve --id "$id"
    done
}

# Azure login
az login --service-principal -u "$2" -p "$3" --tenant "$4"

# Call the approve_private_endpoint function with the resource ID as a parameter
approve_private_endpoint "$1"

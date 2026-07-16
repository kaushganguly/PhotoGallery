// User-Assigned Managed Identity module
// Used for passwordless authentication to ACR and Azure Blob Storage

@description('Azure region for the Managed Identity')
param location string

@description('Unique resource token derived from subscription/resource group/location')
param resourceToken string

@description('Tags to apply to all resources')
param tags object = {}

var managedIdentityName = 'azmi${resourceToken}'

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
  tags: tags
}

output managedIdentityId string = managedIdentity.id
output managedIdentityName string = managedIdentity.name
output managedIdentityPrincipalId string = managedIdentity.properties.principalId
output managedIdentityClientId string = managedIdentity.properties.clientId

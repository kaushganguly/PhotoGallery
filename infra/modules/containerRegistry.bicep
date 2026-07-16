// Azure Container Registry module (Basic SKU)
// Includes AcrPull role assignment for the User-Assigned Managed Identity

@description('Azure region for the Container Registry')
param location string

@description('Unique resource token derived from subscription/resource group/location')
param resourceToken string

@description('Principal ID of the User-Assigned Managed Identity that needs AcrPull access')
param managedIdentityPrincipalId string

@description('Tags to apply to all resources')
param tags object = {}

var acrName = 'azacr${resourceToken}'

// AcrPull built-in role definition ID
var acrPullRoleDefinitionId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d')

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  tags: tags
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
  }
}

// AcrPull role assignment for Managed Identity - must be defined before container app
resource acrPullRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(containerRegistry.id, managedIdentityPrincipalId, acrPullRoleDefinitionId)
  scope: containerRegistry
  properties: {
    roleDefinitionId: acrPullRoleDefinitionId
    principalId: managedIdentityPrincipalId
    principalType: 'ServicePrincipal'
  }
}

output containerRegistryId string = containerRegistry.id
output containerRegistryName string = containerRegistry.name
output containerRegistryLoginServer string = containerRegistry.properties.loginServer
output acrPullRoleAssignmentId string = acrPullRoleAssignment.id

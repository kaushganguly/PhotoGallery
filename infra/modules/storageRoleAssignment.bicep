// Storage Role Assignment module
// Assigns Storage Blob Data Contributor role to the Managed Identity
// on an existing Azure Storage Account

@description('Name of the existing storage account (must be in the same resource group as this module deployment)')
param storageAccountName string

@description('Principal ID of the User-Assigned Managed Identity')
param managedIdentityPrincipalId string

// Storage Blob Data Contributor built-in role definition ID
var storageBlobDataContributorRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')

// Reference existing storage account in the current module scope
// (main.bicep sets this module's scope to the storage account's resource group)
resource existingStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

resource storageBlobDataContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(existingStorageAccount.id, managedIdentityPrincipalId, storageBlobDataContributorRoleId)
  scope: existingStorageAccount
  properties: {
    roleDefinitionId: storageBlobDataContributorRoleId
    principalId: managedIdentityPrincipalId
    principalType: 'ServicePrincipal'
  }
}

output storageBlobRoleAssignmentId string = storageBlobDataContributorRoleAssignment.id
output storageAccountResourceId string = existingStorageAccount.id

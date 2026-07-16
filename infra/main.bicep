// ============================================================
// PhotoGallery — Azure Infrastructure
// main.bicep — Orchestrates all modules for Azure Container Apps deployment
// ============================================================

targetScope = 'resourceGroup'

// ── Parameters ──────────────────────────────────────────────

@description('Azure region for all resources')
param location string = 'eastus2'

@description('Environment name (used as part of the unique resource token)')
@allowed(['dev', 'test', 'staging', 'prod'])
param environmentName string = 'prod'

@description('Name of the existing Azure Storage Account that holds photo blobs')
param storageAccountName string

@description('Resource group of the existing storage account (defaults to this deployment resource group)')
param storageAccountResourceGroup string = resourceGroup().name

@description('Tags applied to all resources')
param tags object = {
  project: 'photogallery'
  managedBy: 'bicep'
  environment: environmentName
}

// ── Resource Token ───────────────────────────────────────────
// All resource names follow: az{prefix}{resourceToken}
var resourceToken = toLower(uniqueString(subscription().id, resourceGroup().id, location, environmentName))

// ── Log Analytics Workspace ──────────────────────────────────
module logAnalytics 'modules/logAnalytics.bicep' = {
  name: 'deploy-log-analytics'
  params: {
    location: location
    resourceToken: resourceToken
    tags: tags
  }
}

// ── User-Assigned Managed Identity ──────────────────────────
module managedIdentity 'modules/managedIdentity.bicep' = {
  name: 'deploy-managed-identity'
  params: {
    location: location
    resourceToken: resourceToken
    tags: tags
  }
}

// ── Azure Container Registry (Basic) + AcrPull role ─────────
// AcrPull role assignment is defined INSIDE this module, BEFORE any container app
module containerRegistry 'modules/containerRegistry.bicep' = {
  name: 'deploy-container-registry'
  params: {
    location: location
    resourceToken: resourceToken
    managedIdentityPrincipalId: managedIdentity.outputs.managedIdentityPrincipalId
    tags: tags
  }
}

// ── Storage Blob Data Contributor on existing storage account ─
// Module scope is set to the storage account's resource group (handles cross-RG deployments)
module storageRoleAssignment 'modules/storageRoleAssignment.bicep' = {
  name: 'deploy-storage-role-assignment'
  scope: resourceGroup(storageAccountResourceGroup)
  params: {
    storageAccountName: storageAccountName
    managedIdentityPrincipalId: managedIdentity.outputs.managedIdentityPrincipalId
  }
}

// ── Container Apps Environment (connected to Log Analytics) ──
module containerAppsEnvironment 'modules/containerAppsEnvironment.bicep' = {
  name: 'deploy-container-apps-environment'
  params: {
    location: location
    resourceToken: resourceToken
    logAnalyticsCustomerId: logAnalytics.outputs.logAnalyticsCustomerId
    logAnalyticsPrimarySharedKey: logAnalytics.outputs.logAnalyticsPrimarySharedKey
    tags: tags
  }
}

// ── Container App (placeholder image) ────────────────────────
// Depends on containerRegistry (for AcrPull role), managedIdentity, containerAppsEnvironment
module containerApp 'modules/containerApp.bicep' = {
  name: 'deploy-container-app'
  params: {
    location: location
    resourceToken: resourceToken
    containerAppsEnvironmentId: containerAppsEnvironment.outputs.containerAppsEnvironmentId
    managedIdentityId: managedIdentity.outputs.managedIdentityId
    managedIdentityClientId: managedIdentity.outputs.managedIdentityClientId
    acrLoginServer: containerRegistry.outputs.containerRegistryLoginServer
    storageServiceUri: 'https://${storageAccountName}.blob.${environment().suffixes.storage}'
    tags: tags
  }
}

// ── Outputs ──────────────────────────────────────────────────

@description('Resource group name')
output resourceGroupName string = resourceGroup().name

@description('Log Analytics Workspace name')
output logAnalyticsWorkspaceName string = logAnalytics.outputs.logAnalyticsWorkspaceName

@description('Managed Identity name')
output managedIdentityName string = managedIdentity.outputs.managedIdentityName

@description('Managed Identity client ID')
output managedIdentityClientId string = managedIdentity.outputs.managedIdentityClientId

@description('Container Registry name')
output containerRegistryName string = containerRegistry.outputs.containerRegistryName

@description('Container Registry login server')
output containerRegistryLoginServer string = containerRegistry.outputs.containerRegistryLoginServer

@description('Container Apps Environment name')
output containerAppsEnvironmentName string = containerAppsEnvironment.outputs.containerAppsEnvironmentName

@description('Container App name')
output containerAppName string = containerApp.outputs.containerAppName

@description('Container App FQDN')
output containerAppFqdn string = containerApp.outputs.containerAppFqdn

@description('Container App URL')
output containerAppUrl string = containerApp.outputs.containerAppUrl

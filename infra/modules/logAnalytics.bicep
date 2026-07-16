// Log Analytics Workspace module
// Provides log aggregation for Container Apps Environment

@description('Azure region for the Log Analytics Workspace')
param location string

@description('Unique resource token derived from subscription/resource group/location')
param resourceToken string

@description('Tags to apply to all resources')
param tags object = {}

var workspaceName = 'azlaw${resourceToken}'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

// Outputs used by Container Apps Environment
output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
output logAnalyticsWorkspaceName string = logAnalyticsWorkspace.name
output logAnalyticsCustomerId string = logAnalyticsWorkspace.properties.customerId
// Suppress linter warning: the Log Analytics primary key is required for Container Apps
// Environment configuration and is treated as a secure parameter in the consuming module.
#disable-next-line outputs-should-not-contain-secrets
output logAnalyticsPrimarySharedKey string = logAnalyticsWorkspace.listKeys().primarySharedKey

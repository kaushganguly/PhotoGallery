// Container Apps Environment module
// Connects to Log Analytics Workspace for log aggregation

@description('Azure region for the Container Apps Environment')
param location string

@description('Unique resource token derived from subscription/resource group/location')
param resourceToken string

@description('Log Analytics Workspace customer ID (for log aggregation)')
param logAnalyticsCustomerId string

@description('Log Analytics Workspace primary shared key')
@secure()
param logAnalyticsPrimarySharedKey string

@description('Tags to apply to all resources')
param tags object = {}

var containerAppsEnvironmentName = 'azace${resourceToken}'

resource containerAppsEnvironment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: containerAppsEnvironmentName
  location: location
  tags: tags
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsCustomerId
        sharedKey: logAnalyticsPrimarySharedKey
      }
    }
    zoneRedundant: false
  }
}

output containerAppsEnvironmentId string = containerAppsEnvironment.id
output containerAppsEnvironmentName string = containerAppsEnvironment.name

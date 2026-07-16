// Container App module
// Deploys the PhotoGallery application as a Container App
// Initially uses a placeholder image; replaced during Task 006

@description('Azure region for the Container App')
param location string

@description('Unique resource token derived from subscription/resource group/location')
param resourceToken string

@description('Resource ID of the Container Apps Environment')
param containerAppsEnvironmentId string

@description('Resource ID of the User-Assigned Managed Identity')
param managedIdentityId string

@description('Client ID of the User-Assigned Managed Identity')
param managedIdentityClientId string

@description('Login server of the Azure Container Registry')
param acrLoginServer string

@description('Placeholder value for the Storage Service URI (updated in Task 006)')
// Use environment().suffixes.storage to avoid hardcoded cloud-specific URL
param storageServiceUri string = 'https://placeholder.blob.${environment().suffixes.storage}'

@description('Tags to apply to all resources')
param tags object = {}

var containerAppName = 'azca${resourceToken}'

// Placeholder image — replaced with the actual PhotoGallery image in Task 006
var placeholderImage = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'

resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerAppName
  location: location
  tags: tags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentityId}': {}
    }
  }
  properties: {
    managedEnvironmentId: containerAppsEnvironmentId
    configuration: {
      ingress: {
        external: true
        targetPort: 80
        transport: 'auto'
        corsPolicy: {
          allowedOrigins: ['*']
          allowedMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS']
          allowedHeaders: ['*']
          allowCredentials: false
        }
      }
      registries: [
        {
          server: acrLoginServer
          identity: managedIdentityId
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'photogallery'
          image: placeholderImage
          resources: {
            cpu: json('0.25')
            memory: '0.5Gi'
          }
          env: [
            {
              name: 'Storage__ServiceUri'
              value: storageServiceUri
            }
            {
              name: 'AZURE_CLIENT_ID'
              value: managedIdentityClientId
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 3
      }
    }
  }
}

output containerAppId string = containerApp.id
output containerAppName string = containerApp.name
output containerAppFqdn string = containerApp.properties.configuration.ingress.fqdn
output containerAppUrl string = 'https://${containerApp.properties.configuration.ingress.fqdn}'

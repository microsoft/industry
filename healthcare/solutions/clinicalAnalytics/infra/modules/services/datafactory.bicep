// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a DataFactory.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param datafactoryName string
param keyVault001Id string
param machineLearning001Id string
param privateDnsZoneIdDataFactory string = ''
param privateDnsZoneIdDataFactoryPortal string = ''
param purviewId string = ''
param purviewManagedStorageId string = ''
param purviewManagedEventHubId string = ''

// Variables
var keyVault001Name = length(split(keyVault001Id, '/')) >= 9 ? last(split(keyVault001Id, '/')) : 'incorrectSegmentLength'
var machineLearning001SubscriptionId = length(split(machineLearning001Id, '/')) >= 9 ? split(machineLearning001Id, '/')[2] : subscription().subscriptionId
var machineLearning001ResourceGroupName = length(split(machineLearning001Id, '/')) >= 9 ? split(machineLearning001Id, '/')[4] : resourceGroup().name
var machineLearning001Name = length(split(machineLearning001Id, '/')) >= 9 ? last(split(machineLearning001Id, '/')) : 'incorrectSegmentLength'
var datafactoryDefaultManagedVnetIntegrationRuntimeName = 'AutoResolveIntegrationRuntime'
var datafactoryPrivateEndpointNameDatafactory = '${datafactory.name}-datafactory-private-endpoint'
var datafactoryPrivateEndpointNamePortal = '${datafactory.name}-portal-private-endpoint'

// Resources
resource datafactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: datafactoryName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    globalParameters: {}
    publicNetworkAccess: 'Disabled'
    //#disable-next-line BCP037
    purviewConfiguration: {
      purviewResourceId: purviewId
    }
  }
}

resource datafactoryPrivateEndpointDatafactory 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: datafactoryPrivateEndpointNameDatafactory
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: datafactoryPrivateEndpointNameDatafactory
        properties: {
          groupIds: [
            'dataFactory'
          ]
          privateLinkServiceId: datafactory.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource datafactoryPrivateEndpointDatafactoryARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdDataFactory)) {
  parent: datafactoryPrivateEndpointDatafactory
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${datafactoryPrivateEndpointDatafactory.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdDataFactory
        }
      }
    ]
  }
}

resource datafactoryPrivateEndpointPortal 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: datafactoryPrivateEndpointNamePortal
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: datafactoryPrivateEndpointNamePortal
        properties: {
          groupIds: [
            'portal'
          ]
          privateLinkServiceId: datafactory.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource datafactoryPrivateEndpointPortalARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdDataFactoryPortal)) {
  parent: datafactoryPrivateEndpointPortal
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${datafactoryPrivateEndpointPortal.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdDataFactoryPortal
        }
      }
    ]
  }
}

resource datafactoryManagedVirtualNetwork 'Microsoft.DataFactory/factories/managedVirtualNetworks@2018-06-01' = {
  parent: datafactory
  name: 'default'
  properties: {}
}

resource datafactoryManagedIntegrationRuntime001 'Microsoft.DataFactory/factories/integrationRuntimes@2018-06-01' = {
  parent: datafactory
  name: datafactoryDefaultManagedVnetIntegrationRuntimeName
  properties: {
    type: 'Managed'
    managedVirtualNetwork: {
      type: 'ManagedVirtualNetworkReference'
      referenceName: datafactoryManagedVirtualNetwork.name
    }
    typeProperties: {
      computeProperties: {
        location: 'AutoResolve'
      }
    }
  }
}

resource datafactoryPurviewManagedPrivateEndpoint 'Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints@2018-06-01' = if(!empty(purviewId)) {
  parent: datafactoryManagedVirtualNetwork
  name: 'Purview'
  properties: {
    fqdns: []
    groupId: 'account'
    privateLinkResourceId: purviewId
  }
}

resource datafactoryPurviewBlobManagedPrivateEndpoint 'Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints@2018-06-01' = if(!empty(purviewManagedStorageId)) {
  parent: datafactoryManagedVirtualNetwork
  name: 'Purview_blob'
  properties: {
    fqdns: []
    groupId: 'blob'
    privateLinkResourceId: purviewManagedStorageId
  }
}

resource datafactoryPurviewQueueManagedPrivateEndpoint 'Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints@2018-06-01' = if(!empty(purviewManagedStorageId)) {
  parent: datafactoryManagedVirtualNetwork
  name: 'Purview_queue'
  properties: {
    fqdns: []
    groupId: 'queue'
    privateLinkResourceId: purviewManagedStorageId
  }
}

resource datafactoryPurviewNamespaceManagedPrivateEndpoint 'Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints@2018-06-01' = if(!empty(purviewManagedEventHubId)) {
  parent: datafactoryManagedVirtualNetwork
  name: 'Purview_namespace'
  properties: {
    fqdns: []
    groupId: 'namespace'
    privateLinkResourceId: purviewManagedEventHubId
  }
}

resource datafactoryKeyVault001ManagedPrivateEndpoint 'Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints@2018-06-01' = {
  parent: datafactoryManagedVirtualNetwork
  name: replace(keyVault001Name, '-', '')
  properties: {
    fqdns: []
    groupId: 'vault'
    privateLinkResourceId: keyVault001Id
  }
}

resource keyVault001LinkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  parent: datafactory
  name: replace(keyVault001Name, '-', '')
  dependsOn: [
    datafactoryKeyVault001ManagedPrivateEndpoint
  ]
  properties: {
    type: 'AzureKeyVault'
    annotations: []
    connectVia: {
      type: 'IntegrationRuntimeReference'
      referenceName: datafactoryManagedIntegrationRuntime001.name
      parameters: {}
    }
    description: 'Key Vault for storing secrets'
    parameters: {}
    typeProperties: {
      baseUrl: 'https://${keyVault001Name}${environment().suffixes.keyvaultDns}/'
    }
  }
}

resource machineLearning001ManagedPrivateEndpoint 'Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints@2018-06-01' = {  // Not supported yet, as a Machine Learning workspace only supports a single private endpoint today. Will be updated as soon as this is supported.
  parent: datafactoryManagedVirtualNetwork
  name: replace(machineLearning001Name, '-', '')
  properties: {
    fqdns: []
    groupId: 'amlworkspace'
    privateLinkResourceId: machineLearning001Id
  }
}

resource machineLearning001LinkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  parent: datafactory
  name: replace(machineLearning001Name, '-', '')
  dependsOn: [
    machineLearning001ManagedPrivateEndpoint
  ]
  properties: {
    type: 'AzureMLService'
    annotations: []
    connectVia: {
      type: 'IntegrationRuntimeReference'
      referenceName: datafactoryManagedIntegrationRuntime001.name
      parameters: {}
    }
    description: 'Machine Learning for executing Pipelines.'
    parameters: {}
    typeProperties: {
      tenant: subscription().tenantId
      subscriptionId: machineLearning001SubscriptionId
      resourceGroupName: machineLearning001ResourceGroupName
      mlWorkspaceName: machineLearning001Name
//      #disable-next-line BCP037
      authentication: 'MSI'
    }
  }
}

// Outputs
output datafactoryId string = datafactory.id

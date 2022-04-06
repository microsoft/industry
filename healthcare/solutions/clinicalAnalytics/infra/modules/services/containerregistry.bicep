// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Container Registry.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param containerRegistryName string
param privateDnsZoneIdContainerRegistry string = ''

// Variables
var containerRegistryNameCleaned = replace(containerRegistryName, '-', '')
var containerRegistryPrivateEndpointName = '${containerRegistry.name}-private-endpoint'

// Resources
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  name: containerRegistryNameCleaned
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Premium'
  }
  properties: {
    adminUserEnabled: true
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'None'
    networkRuleSet: {
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    policies: {
      quarantinePolicy: {
        status: 'enabled'
      }
      retentionPolicy: {
        status: 'enabled'
        days: 7
      }
      trustPolicy: {
        status: 'disabled'
        type: 'Notary'
      }
    }
    publicNetworkAccess: 'Disabled'
    // zoneRedundancy: 'Enabled'  // Uncomment to allow zone redundancy for your Container Registry
  }
}

resource containerRegistryPrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: containerRegistryPrivateEndpointName
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: containerRegistryPrivateEndpointName
        properties: {
          groupIds: [
            'registry'
          ]
          privateLinkServiceId: containerRegistry.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource containerRegistryPrivateEndpointARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdContainerRegistry)) {
  parent: containerRegistryPrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${containerRegistryPrivateEndpoint.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdContainerRegistry
        }
      }
    ]
  }
}

// Outputs
output containerRegistryId string = containerRegistry.id

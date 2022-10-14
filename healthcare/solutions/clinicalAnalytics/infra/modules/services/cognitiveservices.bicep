// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Cognitive Service.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param cognitiveServiceName string
param cognitiveServiceSkuName string = 'S0'
@allowed([
  'AnomalyDetector'
  'ComputerVision'
  'CognitiveServices'
  'ContentModerator'
  'CustomVision.Training'
  'CustomVision.Prediction'
  'Face'
  'FormRecognizer'
  'ImmersiveReader'
  'LUIS'
  'Personalizer'
  'SpeechServices'
  'TextAnalytics'
  'TextTranslation'
])
param cognitiveServiceKind string
param privateDnsZoneIdCognitiveService string = ''

// Variables
var cognitiveServicePrivateEndpointName = '${cognitiveService.name}-private-endpoint'

// Resources
resource cognitiveService 'Microsoft.CognitiveServices/accounts@2021-04-30' = {
  name: cognitiveServiceName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: cognitiveServiceKind == 'ComputerVision' || cognitiveServiceKind == 'TextTranslation' ? 'S1' : cognitiveServiceKind == 'TextAnalytics' ? 'S' : cognitiveServiceSkuName
  }
  kind: cognitiveServiceKind
  properties: {
    allowedFqdnList: []
    apiProperties: {}
    customSubDomainName: cognitiveServiceName
    disableLocalAuth: true
    networkAcls: {
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Disabled'
    restrictOutboundNetworkAccess: true
    // userOwnedStorage: []  // Uncomment if you want to enable user owned storage. Only available for select set of cognitive service kinds.
  }
}

resource cognitiveServicePrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: cognitiveServicePrivateEndpointName
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: cognitiveServicePrivateEndpointName
        properties: {
          groupIds: [
            'account'
          ]
          privateLinkServiceId: cognitiveService.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource cognitiveServicePrivateEndpointARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdCognitiveService)) {
  parent: cognitiveServicePrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${cognitiveServicePrivateEndpoint.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdCognitiveService
        }
      }
    ]
  }
}

// Outputs

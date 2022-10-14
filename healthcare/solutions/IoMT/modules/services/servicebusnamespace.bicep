// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Service Bus Namespace.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param servicebusnamespaceName string
@allowed([
  1
  2
  4
  8
  16
])
param servicebusnamespaceThroughput int = 1
param privateDnsZoneIdServicebusNamespace string = ''

// Variables
var servicebusQueue001Name = 'eventHub001'
var servicebusQueue001SharedAccessPolicyName = 'fhir-synch-agent'
var servicebusNamespacePrivateEndpointName = '${servicebusNamespace.name}-private-endpoint'

// Resources
resource servicebusNamespace 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: servicebusnamespaceName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Premium'
    tier: 'Premium'
    capacity: servicebusnamespaceThroughput
  }
  properties: {
    disableLocalAuth: true
    zoneRedundant: true
  }
}

resource servicebusNamespaceNetworkRuleSets 'Microsoft.ServiceBus/namespaces/networkRuleSets@2021-11-01' = {
  name: 'default'
  parent: servicebusNamespace
  properties: {
    defaultAction: 'Deny'
    ipRules: []
    publicNetworkAccess: 'Enabled'
    trustedServiceAccessEnabled: true
    virtualNetworkRules: []
  }
}

resource servicebusQueue001 'Microsoft.ServiceBus/namespaces/queues@2021-11-01' = {
  name: servicebusQueue001Name
  parent: servicebusNamespace
  properties: {
    autoDeleteOnIdle: 'P10675199DT2H48M5.4775807S'
    deadLetteringOnMessageExpiration: false
    defaultMessageTimeToLive: 'P14D'
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    enableBatchedOperations: true
    enableExpress: false
    enablePartitioning: false
    lockDuration: 'PT30S'
    maxDeliveryCount: 10
    maxSizeInMegabytes: 1024
    requiresDuplicateDetection: false
    requiresSession: false
  }
}

resource servicebusQueue001SharedAccessPolicy 'Microsoft.ServiceBus/namespaces/queues/authorizationRules@2021-11-01' = {
  name: servicebusQueue001SharedAccessPolicyName
  parent: servicebusQueue001
  properties: {
    rights: [
      'Listen'
    ]
  }
}

resource servicebusNamespacePrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: servicebusNamespacePrivateEndpointName
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: servicebusNamespacePrivateEndpointName
        properties: {
          groupIds: [
            'namespace'
          ]
          privateLinkServiceId: servicebusNamespace.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource servicebusNamespacePrivateEndpointARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdServicebusNamespace)) {
  parent: servicebusNamespacePrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${servicebusNamespacePrivateEndpoint.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdServicebusNamespace
        }
      }
    ]
  }
}

// Outputs
output serviceBusUrl string = servicebusNamespace.properties.serviceBusEndpoint
output serviceBusQueue001Name string = servicebusQueue001.name
output serviceBusQueue001SharedAccessPolicyName string = servicebusQueue001SharedAccessPolicy.name
#disable-next-line outputs-should-not-contain-secrets
output serviceBusQueue001SharedAccessPolicyKey string = listKeys(servicebusQueue001SharedAccessPolicy.id, servicebusQueue001SharedAccessPolicy.apiVersion).primaryKey

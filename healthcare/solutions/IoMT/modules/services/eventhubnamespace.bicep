// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create an EventHub Namespace.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param eventhubnamespaceName string
@minValue(1)
@maxValue(20)
param eventhubnamespaceMinThroughput int
@minValue(1)
@maxValue(20)
param eventhubnamespaceMaxThroughput int
param privateDnsZoneIdEventhubNamespace string = ''

// Variables
var eventhub001Name = '${eventhubnamespaceName}-eh001'
var eventHub001ConsumerGroupName = 'healthcareapiiot'
var eventhubNamespacePrivateEndpointName = '${eventhubNamespace.name}-private-endpoint'

// Resources
resource eventhubNamespace 'Microsoft.EventHub/namespaces@2021-11-01' = {
  name: eventhubnamespaceName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: eventhubnamespaceMinThroughput
  }
  properties: {
    isAutoInflateEnabled: true
    kafkaEnabled: true
    maximumThroughputUnits: eventhubnamespaceMaxThroughput
    zoneRedundant: true
    disableLocalAuth: false
  }
}

resource eventhubNamespaceNetworkRuleSets 'Microsoft.EventHub/namespaces/networkRuleSets@2021-11-01' = {
  name: 'default'
  parent: eventhubNamespace
  properties: {
    defaultAction: 'Deny'
    ipRules: []
    virtualNetworkRules: []
    publicNetworkAccess: 'Enabled'
    trustedServiceAccessEnabled: true
  }
}

resource eventhub001 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  parent: eventhubNamespace
  name: eventhub001Name
  properties: {
    // captureDescription: {  // Uncomment to define capture details
    //   enabled: false
    //   destination: {
    //     name: eventhub001Name
    //     properties: {
    //       archiveNameFormat: ''
    //       blobContainer: ''
    //       storageAccountResourceId: ''
    //     }
    //   }
    //   encoding: 'Avro'
    //   intervalInSeconds: 900
    //   sizeLimitInBytes: 10485760
    //   skipEmptyArchives: true
    // }
    messageRetentionInDays: 3
    partitionCount: 1
    status: 'Active'
  }
}

resource eventHub001ConsumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-11-01' = {
  name: eventHub001ConsumerGroupName
  parent: eventhub001
  properties: {}
}

resource eventhubNamespacePrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: eventhubNamespacePrivateEndpointName
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: eventhubNamespacePrivateEndpointName
        properties: {
          groupIds: [
            'namespace'
          ]
          privateLinkServiceId: eventhubNamespace.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource eventhubNamespacePrivateEndpointARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdEventhubNamespace)) {
  parent: eventhubNamespacePrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${eventhubNamespacePrivateEndpoint.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdEventhubNamespace
        }
      }
    ]
  }
}

// Outputs
output eventhubNamespaceId string = eventhubNamespace.id
output eventhubNamespaceFqdn string = '${eventhubNamespace.name}.servicesbus.windows.net'
output eventhub001Name string = eventhub001.name
output eventhub001ConsumerGroupName string = eventHub001ConsumerGroup.name

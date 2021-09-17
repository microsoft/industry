// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create an IoT Hub.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param iothubName string
param iothubSkuName string = 'S1'
@minValue(1)
param iothubSkuCapacity int = 1
param privateDnsZoneIdIothub string = ''
param privateDnsZoneIdEventhubNamespace string = ''

// Variables
var iothubEventhubEndpointName = 'events'
var iothubEventhubEndpointConsumerGroupName = 'healthcareapiiot'
var iothubPrivateEndpointName = '${iothub.name}-private-endpoint'

// Resources
resource iothub 'Microsoft.Devices/IotHubs@2021-03-31' = {
  name: iothubName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: iothubSkuName
    capacity: iothubSkuCapacity
  }
  properties: {
    authorizationPolicies: []
    cloudToDevice: {
      defaultTtlAsIso8601: 'PT1M'
      feedback: {
        lockDurationAsIso8601: 'PT1M'
        maxDeliveryCount: 10
        ttlAsIso8601: 'PT1H'
      }
      maxDeliveryCount: 10
    }
    comments: ''
    enableFileUploadNotifications: false
    eventHubEndpoints: {
      events: {
        partitionCount: 4
        retentionTimeInDays: 1
      }
    }
    features: 'DeviceManagement'
    ipFilterRules: []
    messagingEndpoints: {
      fileNotifications: {
        lockDurationAsIso8601: 'PT1M'
        maxDeliveryCount: 10
        ttlAsIso8601: 'PT1H'
      }
    }
    // minTlsVersion: '1.2'  // Uncomment to enforce TLS Version 1.2. This is only available in select region (https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-tls-support)
    networkRuleSets: {
      applyToBuiltInEventHubEndpoint: true
      defaultAction: 'Deny'
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
    routing: {
      endpoints: {
        eventHubs: []
        serviceBusQueues: []
        serviceBusTopics: []
        storageContainers: []
      }
      enrichments: []
      fallbackRoute: {
        condition: 'true'
        endpointNames: [
          'events'
        ]
        isEnabled: false
        name: '$fallback'
        source: 'DeviceMessages'
      }
      routes: []
    }
    storageEndpoints: {}
  }
}

resource iothubEvenhubEndpointConsumerGroup 'Microsoft.Devices/IotHubs/eventHubEndpoints/ConsumerGroups@2021-07-01' = {
  name: '${iothub.name}/${iothubEventhubEndpointName}/${iothubEventhubEndpointConsumerGroupName}'
  properties: {
    name: iothubEventhubEndpointConsumerGroupName
  }
}

resource iothubPrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: iothubPrivateEndpointName
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: iothubPrivateEndpointName
        properties: {
          groupIds: [
            'iotHub'
          ]
          privateLinkServiceId: iothub.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource iothubPrivateEndpointIotHubARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdIothub) && !empty(privateDnsZoneIdEventhubNamespace)) {
  parent: iothubPrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${iothubPrivateEndpoint.name}-arecord-iothub'
        properties: {
          privateDnsZoneId: privateDnsZoneIdIothub
        }
      }
      {
        name: '${iothubPrivateEndpoint.name}-arecord-eventhub'
        properties: {
          privateDnsZoneId: privateDnsZoneIdEventhubNamespace
        }
      }
    ]
  }
}

// Outputs
output iothubId string = iothub.id
output iothubEvenhubEndpointFqdn string = first(split(last(split(iothub.properties.eventHubEndpoints[iothubEventhubEndpointName].endpoint, '//')), '/'))
output iothubEvenhubEndpointName string = iothubEventhubEndpointName
output iothubEvenhubEndpointConsumerGroupName string = iothubEvenhubEndpointConsumerGroup.name

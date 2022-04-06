targetScope = 'resourceGroup'

param name string
param myTags object

resource healthEventHubNamespace 'Microsoft.EventHub/namespaces@2021-06-01-preview' = {
  name: '${name}healthEventNs'
  location: resourceGroup().location
  tags: myTags
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
  }  
  resource healthEventHub 'eventhubs@2021-06-01-preview' = {
    name: '${name}healthEventHub'
    properties: {
      messageRetentionInDays: 7
      partitionCount: 1
    }
    resource healthEventConsumer 'consumergroups@2021-01-01-preview' = {
      name: '${name}healthEventConsumer'
    }
  }  

}

var eventhubDetails = {
  eventHubName: healthEventHubNamespace::healthEventHub.name
  consumerGroup: healthEventHubNamespace::healthEventHub::healthEventConsumer.name
  fullyQualifiedEventHubNamespace: '${healthEventHubNamespace::healthEventHub.name}.servicesbus.windows.net'
}

output eventHubName string = healthEventHubNamespace::healthEventHub.name
output consumerGroup string = healthEventHubNamespace::healthEventHub::healthEventConsumer.name
output fullyQualifiedEventHubNamespace string = '${healthEventHubNamespace::healthEventHub.name}.servicesbus.windows.net'
output eventhubdetails object = eventhubDetails

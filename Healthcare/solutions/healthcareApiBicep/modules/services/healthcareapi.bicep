// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Healthcare API.
targetScope = 'resourceGroup'

// General Parameters
param location string
param tags object
param subnetId string
param healthcareapiName string
param privateDnsZoneIdHealthcareApi string = ''

// FHIR Parameters
@allowed([
  'fhir-Stu3'
  'fhir-R4'
])
param healthcareapiFhirVersion string = 'fhir-R4'
param healthcareapiFhirStorageAccountName string = ''
param healthcareapiFhirContainerRegistryLoginServers array = []

// IoTConnector Parameters
param healthcareapiIotDeviceMapping object  // Sample: '{ "templateType": "CollectionContent", "template": [] }'
param healthcareapiIotFhirMapping object  // { "templateType": "CollectionFhirTemplate", "template": [] }
param healthcareapiIotEventhubNamespaceFqdn string
param healthcareapiIotEventhubName string
param healthcareapiIotEventhubConsumerGroupName string

// Variables
var healthcareapiNameCleaned = toLower(replace(healthcareapiName, '-', ''))
var healthcareapiFhirName = '${healthcareapiNameCleaned}fhir'
var healthcareapiDicomName = '${healthcareapiNameCleaned}dicom'
var healthcareapiIotName = '${healthcareapiNameCleaned}iot'
var healthcareapiPrivateEndpointName = '${healthcareapiNameCleaned}-private-endpoint'

// Resources
resource healthcareapi 'Microsoft.HealthcareApis/workspaces@2021-06-01-preview' = {
  name: healthcareapiNameCleaned
  location: location
  tags: tags
  properties: {}
}

resource healthcareapiPrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = if(false) {
  name: healthcareapiPrivateEndpointName
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: healthcareapiPrivateEndpointName
        properties: {
          groupIds: [
            'workspace'
          ]
          privateLinkServiceId: healthcareapi.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource eventhubNamespacePrivateEndpointARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (false && !empty(privateDnsZoneIdHealthcareApi)) {
  parent: healthcareapiPrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${healthcareapiPrivateEndpoint.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdHealthcareApi
        }
      }
    ]
  }
}

resource healthcareapiFhir 'Microsoft.HealthcareApis/workspaces/fhirservices@2021-06-01-preview' = {
  name: healthcareapiFhirName
  parent: healthcareapi
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  kind: healthcareapiFhirVersion
  properties: {
    accessPolicies: []
    authenticationConfiguration: {
      audience: 'https://${healthcareapiNameCleaned}-stu3.fhir.azurehealthcareapis.com'
      authority: 'https://login.microsoftonline.com/${subscription().tenantId}'
      smartProxyEnabled: false
    }
    acrConfiguration: {
      loginServers: healthcareapiFhirContainerRegistryLoginServers
    }
    corsConfiguration: {
      allowCredentials: false
      headers: [
        '*'
      ]
      maxAge: 1440
      methods: [
        'DELETE'
        'GET'
        'OPTIONS'
        'PATCH'
        'POST'
        'PUT'
      ]
      origins: [
        'https://localhost:6001'
      ]
    }
    exportConfiguration: {
      storageAccountName: healthcareapiFhirStorageAccountName
    }
  }
}

resource healthcareapiDicom 'Microsoft.HealthcareApis/workspaces/dicomservices@2021-06-01-preview' = {
  name: healthcareapiDicomName
  parent: healthcareapi
  location: location
  tags: tags
  properties: {
    authenticationConfiguration: {}
  }
}

resource healthcareapiIot 'Microsoft.HealthcareApis/workspaces/iotconnectors@2021-06-01-preview' = if(!empty(healthcareapiIotDeviceMapping) && !empty(healthcareapiIotFhirMapping)) {
  name: healthcareapiIotName
  parent: healthcareapi
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    deviceMapping: {
      content: healthcareapiIotDeviceMapping
    }
    ingestionEndpointConfiguration: {
      fullyQualifiedEventHubNamespace: healthcareapiIotEventhubNamespaceFqdn
      eventHubName: healthcareapiIotEventhubName
      consumerGroup: healthcareapiIotEventhubConsumerGroupName
    }
  }
}

resource healthcareapiIotFhirConnection 'Microsoft.HealthcareApis/workspaces/iotconnectors/fhirdestinations@2021-06-01-preview' = if(!empty(healthcareapiIotDeviceMapping) && !empty(healthcareapiIotFhirMapping)) {
  name: healthcareapiFhir.name
  parent: healthcareapiIot
  location: location
  properties: {
    resourceIdentityResolutionType: 'Create'  // 'Lookup' can also be used
    fhirMapping: {
      content: healthcareapiIotFhirMapping
    }
    fhirServiceResourceId: healthcareapiFhir.id
  }
}

// Outputs
output healthcareapiFhirId string = healthcareapiFhir.id

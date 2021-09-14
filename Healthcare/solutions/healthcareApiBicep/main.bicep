// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

targetScope = 'resourceGroup'

// General parameters
@description('Specifies the location for all resources.')
param location string
@allowed([
  'dev'
  'tst'
  'prd'
])
@description('Specifies the environment of the deployment.')
param environment string = 'dev'
@minLength(2)
@maxLength(10)
@description('Specifies the prefix for all resources created in this deployment.')
param prefix string
@description('Specifies the tags that you want to apply to all resources.')
param tags object = {}

// Resource parameters
@description('Specifies whether role assignments should be enabled.')
param enableRoleAssignments bool = false
@description('Specifies the storage account file system resource id used for FHIR.')
param fhirStorageAccountId string
@description('Specifies the iot device mapping.')
param iotDeviceMapping object = {}
@description('Specifies the fhir mapping.')
param iotFhirMapping object = {}

// Network parameters
@description('Specifies the resource ID of the subnet to which all services will connect.')
param subnetId string

// Private DNS Zone parameters
@description('Specifies the resource ID of the private DNS zone for EventHub Namespaces.')
param privateDnsZoneIdEventhubNamespace string = ''
@description('Specifies the resource ID of the private DNS zone for healthcare API workspaces.')
param privateDnsZoneIdHealthcareApi string = ''

// Variables
var name = toLower('${prefix}-${environment}')
var eventhubNamespace001Name = '${name}-eventhub001'
var healthcareApi001Name = '${name}-hapi001'
var fhirStorageAccountSubscriptionId = length(split(fhirStorageAccountId, '/')) >= 9 ? split(fhirStorageAccountId, '/')[2] : subscription().subscriptionId
var fhirStorageAccountResourceGroupName = length(split(fhirStorageAccountId, '/')) >= 9 ? split(fhirStorageAccountId, '/')[4] : resourceGroup().name
var fhirStorageAccountName = length(split(fhirStorageAccountId, '/')) >= 9 ? last(split(fhirStorageAccountId, '/')) : 'incorrectSegmentLength'

// Resources
module eventhubNamespace001 'modules/services/eventhubnamespace.bicep' = {
  name: 'eventhubNamespace001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tags
    subnetId: subnetId
    eventhubnamespaceName: eventhubNamespace001Name
    privateDnsZoneIdEventhubNamespace: privateDnsZoneIdEventhubNamespace
    eventhubnamespaceMinThroughput: 1
    eventhubnamespaceMaxThroughput: 1
  }
}

module healthcareApi001 'modules/services/healthcareapi.bicep' = {
  name: 'healthcareApi001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tags
    subnetId: subnetId
    healthcareapiFhirVersion: 'fhir-R4'
    privateDnsZoneIdHealthcareApi: privateDnsZoneIdHealthcareApi
    healthcareapiName: healthcareApi001Name
    healthcareapiFhirStorageAccountName: fhirStorageAccountName
    healthcareapiIotEventhubName: eventhubNamespace001.outputs.eventhub001Name
    healthcareapiIotEventhubConsumerGroupName: eventhubNamespace001.outputs.eventhub001ConsumerGroupName
    healthcareapiIotEventhubNamespaceFqdn: eventhubNamespace001.outputs.eventhubNamespaceFqdn
    healthcareapiIotDeviceMapping: iotDeviceMapping
    healthcareapiIotFhirMapping: iotFhirMapping
  }
}

module healthcareApi001RoleAssignmentStorage 'modules/auxiliary/healthcareapiFhirRoleAssignmentStorage.bicep' = if(enableRoleAssignments) {
  name: 'healthcareApi001RoleAssignmentStorage'
  scope: resourceGroup(fhirStorageAccountSubscriptionId, fhirStorageAccountResourceGroupName)
  params: {
    healthcareapiFhirId: healthcareApi001.outputs.healthcareapiFhirId
    storageAccountId: fhirStorageAccountId
  }
}

// Outputs


// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// The module contains a template to create a role assignment of the SHIR Healthcare API to a storage account.
targetScope = 'resourceGroup'

// Parameters
param storageAccountFileSystemId string
param healthcareapiFhirId string

// Variables
var storageAccountName = length(split(storageAccountFileSystemId, '/')) >= 13 ? split(storageAccountFileSystemId, '/')[8] : 'incorrectSegmentLength'
var storageAccountFileSystemName = length(split(storageAccountFileSystemId, '/')) >= 13 ? last(split(storageAccountFileSystemId, '/')) : 'incorrectSegmentLength'
var healthcareapiSubscriptionId = length(split(healthcareapiFhirId, '/')) >= 11 ? split(healthcareapiFhirId, '/')[2] : subscription().subscriptionId
var healthcareapiResourceGroupName = length(split(healthcareapiFhirId, '/')) >= 11 ? split(healthcareapiFhirId, '/')[4] : resourceGroup().name
var healthcareapiName = length(split(healthcareapiFhirId, '/')) >= 11 ? split(healthcareapiFhirId, '/')[8] : 'incorrectSegmentLength'
var healthcareapiFhirName = length(split(healthcareapiFhirId, '/')) >= 11 ? last(split(healthcareapiFhirId, '/')) : 'incorrectSegmentLength'

// Resources
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
}

resource storageAccountBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' existing = {
  name: 'default'
  parent: storageAccount
}

resource storageAccountFileSystem 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' existing = {
  name: storageAccountFileSystemName
  parent: storageAccountBlobServices
}

resource healthcareapi 'Microsoft.HealthcareApis/workspaces@2022-05-15' existing = {
  name: healthcareapiName
  scope: resourceGroup(healthcareapiSubscriptionId, healthcareapiResourceGroupName)
}

resource healthcareapiFhir 'Microsoft.HealthcareApis/workspaces/fhirservices@2022-05-15' existing = {
  name: healthcareapiFhirName
  parent: healthcareapi
}

resource healthcareapiFhirRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(uniqueString(storageAccountFileSystem.id, healthcareapiFhir.id))
  scope: storageAccountFileSystem
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
    principalId: healthcareapiFhir.identity.principalId
  }
}

// Outputs

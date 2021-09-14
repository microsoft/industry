// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// The module contains a template to create a role assignment of the SHIR Healthcare API to a storage account.
targetScope = 'resourceGroup'

// Parameters
param storageAccountId string
param healthcareapiFhirId string

// Variables
var storageAccountName = length(split(storageAccountId, '/')) >= 9 ? last(split(storageAccountId, '/')) : 'incorrectSegmentLength'
var healthcareapiSubscriptionId = length(split(healthcareapiFhirId, '/')) >= 11 ? split(healthcareapiFhirId, '/')[2] : subscription().subscriptionId
var healthcareapiResourceGroupName = length(split(healthcareapiFhirId, '/')) >= 11 ? split(healthcareapiFhirId, '/')[4] : resourceGroup().name
var healthcareapiName = length(split(healthcareapiFhirId, '/')) >= 11 ? split(healthcareapiFhirId, '/')[8] : 'incorrectSegmentLength'
var healthcareapiFhirName = length(split(healthcareapiFhirId, '/')) >= 11 ? last(split(healthcareapiFhirId, '/')) : 'incorrectSegmentLength'

// Resources
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
}

resource healthcareapi 'Microsoft.HealthcareApis/workspaces@2021-06-01-preview' existing = {
  name: healthcareapiName
  scope: resourceGroup(healthcareapiSubscriptionId, healthcareapiResourceGroupName)
}

resource healthcareapiFhir 'Microsoft.HealthcareApis/workspaces/fhirservices@2021-06-01-preview' existing = {
  name: healthcareapiFhirName
  parent: healthcareapi
}

resource synapseRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(uniqueString(storageAccount.id, healthcareapiFhir.id))
  scope: storageAccount
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
    principalId: healthcareapiFhir.identity.principalId
  }
}

// Outputs

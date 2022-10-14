// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// The module contains a template to create a role assignment of the Machine Learning MSI to a Storage file system.
targetScope = 'resourceGroup'

// Parameters
param storageAccountFileSystemId string
param machineLearningId string

// Variables
var storageAccountFileSystemName = length(split(storageAccountFileSystemId, '/')) >= 13 ? last(split(storageAccountFileSystemId, '/')) : 'incorrectSegmentLength'
var storageAccountName = length(split(storageAccountFileSystemId, '/')) >= 13 ? split(storageAccountFileSystemId, '/')[8] : 'incorrectSegmentLength'
var machineLearningSubscriptionId = length(split(machineLearningId, '/')) >= 9 ? split(machineLearningId, '/')[2] : subscription().subscriptionId
var machineLearningResourceGroupName = length(split(machineLearningId, '/')) >= 9 ? split(machineLearningId, '/')[4] : resourceGroup().name
var machineLearningName = length(split(machineLearningId, '/')) >= 9 ? last(split(machineLearningId, '/')) : 'incorrectSegmentLength'

// Resources
resource storageAccountFileSystem 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' existing = {
  name: '${storageAccountName}/default/${storageAccountFileSystemName}'
}

resource machineLearning 'Microsoft.MachineLearningServices/workspaces@2021-04-01' existing = {
  name: machineLearningName
  scope: resourceGroup(machineLearningSubscriptionId, machineLearningResourceGroupName)
}

resource synapseRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(uniqueString(storageAccountFileSystem.id, machineLearning.id))
  scope: storageAccountFileSystem
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
    principalId: machineLearning.identity.principalId
  }
}

// Outputs

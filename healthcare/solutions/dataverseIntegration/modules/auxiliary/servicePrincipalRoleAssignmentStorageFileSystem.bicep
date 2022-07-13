// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// The module contains a template to create a role assignment of a Service Principle to a storage file system.
targetScope = 'resourceGroup'

// Parameters
param storageAccountFileSystemId string
param servicePrincipalObjectId string
@metadata({
  'Owner': '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
  'Storage Blob Data Owner': 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
  'Storage Blob Data Contributor': 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
  'Storage Account Contributor': '17d1049b-9a84-46fb-8f53-869881c3d3ab'
  'Reader and Data Access': 'c12c1c16-33a1-487b-954d-41c89c60f349'
})
param roleId string

// Variables
var storageAccountFileSystemName = length(split(storageAccountFileSystemId, '/')) >= 13 ? last(split(storageAccountFileSystemId, '/')) : 'incorrectSegmentLength'
var storageAccountName = length(split(storageAccountFileSystemId, '/')) >= 13 ? split(storageAccountFileSystemId, '/')[8] : 'incorrectSegmentLength'

// Resources
resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
}

resource storageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' existing = {
  name: 'default'
  parent: storage
}

resource storageFileSystem 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' existing = {
  name: storageAccountFileSystemName
  parent: storageBlobServices
}

resource synapseRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(uniqueString(roleId, storageFileSystem.id, servicePrincipalObjectId))
  scope: storageFileSystem
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleId)
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

// Outputs

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
@secure()
@description('Specifies the administrator password of the sql servers in Synapse.')
param administratorPassword string = ''
@description('Specifies the object ID of the Enterprise Application "Microsoft Power Query".')
param powerPlatformServicePrincipalObjectId string = ''
@description('Specifies the object ID of the Enterprise Application "Export to data lake".')
param dataverseServicePrincipalObjectId string = ''
@description('Specifies the resource ID of the central purview instance to connect Purviw with Data Factory or Synapse. If you do not want to setup a connection to Purview, leave this value empty as is.')
param purviewId string = ''
@description('Specifies whether role assignments should be enabled for Synapse (Blob Storage Contributor to default storage account).')
param enableRoleAssignments bool = false

// Network parameters
@description('Specifies the resource ID of the subnet to which all services will connect.')
param subnetId string

// Private DNS Zone parameters
@description('Specifies the resource ID of the private DNS zone for Blob Storage.')
param privateDnsZoneIdBlob string = ''
@description('Specifies the resource ID of the private DNS zone for Datalake Storage.')
param privateDnsZoneIdDfs string = ''
@description('Specifies the resource ID of the private DNS zone for KeyVault.')
param privateDnsZoneIdKeyVault string = ''
@description('Specifies the resource ID of the private DNS zone for Synapse Dev.')
param privateDnsZoneIdSynapseDev string = ''
@description('Specifies the resource ID of the private DNS zone for Synapse Sql.')
param privateDnsZoneIdSynapseSql string = ''

// Variables
var name = toLower('${prefix}-${environment}')
var tagsDefault = {
  Project: 'Dataverse - Data Integration'
  Environment: environment
  Toolkit: 'bicep'
  Name: name
}
var tagsJoined = union(tagsDefault, tags)
var administratorUsername = 'SqlServerMainUser'
var keyvault001Name = '${name}-vault001'
var storage001Name = '${name}-storage001'
var synapse001Name = '${name}-synapse001'

// Resources
module keyVault001 'modules/services/keyvault.bicep' = {
  name: 'keyVault001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    keyvaultName: keyvault001Name
    privateDnsZoneIdKeyVault: privateDnsZoneIdKeyVault
  }
}

module storage001 'modules/services/storage.bicep' = {
  name: 'storage001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    fileSystemNames: [
      'synapse'
      'power-platform-dataflows'
      'dataverse'
    ]
    storageName: storage001Name
    subnetId: subnetId
    privateDnsZoneIdBlob: privateDnsZoneIdBlob
    privateDnsZoneIdDfs: privateDnsZoneIdDfs
  }
}

module synapse001 'modules/services/synapse.bicep' = {
  name: 'synapse001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    synapseName: synapse001Name
    administratorUsername: administratorUsername
    administratorPassword: administratorPassword
    synapseSqlAdminGroupName: ''
    synapseSqlAdminGroupObjectID: ''
    privateDnsZoneIdSynapseDev: privateDnsZoneIdSynapseDev
    privateDnsZoneIdSynapseSql: privateDnsZoneIdSynapseSql
    purviewId: purviewId
    synapseComputeSubnetId: ''
    synapseDefaultStorageAccountFileSystemId: storage001.outputs.storageFileSystemIds[0].storageFileSystemId
  }
}

module synapse001RoleAssignmentStorageFileSystem 'modules/auxiliary/synapseRoleAssignmentStorageFileSystem.bicep' = if(enableRoleAssignments) {
  name: 'synapse001RoleAssignmentStorageFileSystem'
  scope: resourceGroup()
  params: {
    storageAccountFileSystemId: storage001.outputs.storageFileSystemIds[0].storageFileSystemId
    synapseId: synapse001.outputs.synapseId
  }
}

module powerPlatformRoleAssignmentStorage001 'modules/auxiliary/servicePrincipalRoleAssignmentStorage.bicep' = if(enableRoleAssignments && !empty(powerPlatformServicePrincipalObjectId)) {
  name: 'powerPlatformRoleAssignmentStorage001'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: powerPlatformServicePrincipalObjectId
    storageAccountId: storage001.outputs.storageId
    roleId: 'c12c1c16-33a1-487b-954d-41c89c60f349'  // Reader and Data Access
  }
}

module powerPlatformRoleAssignmentStorageFileSystem001 'modules/auxiliary/servicePrincipalRoleAssignmentStorageFileSystem.bicep' = if(enableRoleAssignments && !empty(powerPlatformServicePrincipalObjectId)) {
  name: 'powerPlatformRoleAssignmentStorageFileSystem001'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: powerPlatformServicePrincipalObjectId
    storageAccountFileSystemId: storage001.outputs.storageFileSystemIds[1].storageFileSystemId
    roleId: 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'  // Storage Blob Data Owner
  }
}

module dataverseRoleAssignmentStorage001 'modules/auxiliary/servicePrincipalRoleAssignmentStorage.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorage001'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountId: storage001.outputs.storageId
    roleId: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'  // Owner
  }
}

module dataverseRoleAssignmentStorage002 'modules/auxiliary/servicePrincipalRoleAssignmentStorage.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorage002'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountId: storage001.outputs.storageId
    roleId: 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'  // Storage Blob Data Owner
  }
}

module dataverseRoleAssignmentStorage003 'modules/auxiliary/servicePrincipalRoleAssignmentStorage.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorage003'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountId: storage001.outputs.storageId
    roleId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'  // Storage Blob Data Contributor
  }
}

module dataverseRoleAssignmentStorage004 'modules/auxiliary/servicePrincipalRoleAssignmentStorage.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorage004'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountId: storage001.outputs.storageId
    roleId: '17d1049b-9a84-46fb-8f53-869881c3d3ab'  // Storage Account Contributor
  }
}

module dataverseRoleAssignmentStorageFileSystem001 'modules/auxiliary/servicePrincipalRoleAssignmentStorageFileSystem.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorageFileSystem001'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountFileSystemId: storage001.outputs.storageFileSystemIds[2].storageFileSystemId
    roleId: '17d1049b-9a84-46fb-8f53-869881c3d3ab'  // Storage Account Contributor
  }
}

module dataverseRoleAssignmentStorageFileSystem002 'modules/auxiliary/servicePrincipalRoleAssignmentStorageFileSystem.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorageFileSystem002'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountFileSystemId: storage001.outputs.storageFileSystemIds[2].storageFileSystemId
    roleId: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'  // Owner
  }
}

module dataverseRoleAssignmentStorageFileSystem003 'modules/auxiliary/servicePrincipalRoleAssignmentStorageFileSystem.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorageFileSystem003'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountFileSystemId: storage001.outputs.storageFileSystemIds[2].storageFileSystemId
    roleId: 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'  // Storage Blob Data Owner
  }
}

module dataverseRoleAssignmentStorageFileSystem004 'modules/auxiliary/servicePrincipalRoleAssignmentStorageFileSystem.bicep' = if(enableRoleAssignments && !empty(dataverseServicePrincipalObjectId)) {
  name: 'dataverseRoleAssignmentStorageFileSystem004'
  scope: resourceGroup()
  params: {
    servicePrincipalObjectId: dataverseServicePrincipalObjectId
    storageAccountFileSystemId: storage001.outputs.storageFileSystemIds[2].storageFileSystemId
    roleId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'  // Storage Blob Data Contributor
  }
}

// Outputs
output synapseId string = synapse001.outputs.synapseId
output dataverseDataLakeFileSystemId string = storage001.outputs.storageFileSystemIds[2].storageFileSystemId

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
@description('Specifies the administrator password of the sql servers in Synapse. If you selected dataFactory as processingService, leave this value empty as is.')
param administratorPassword string = ''
@description('Specifies the resource ID of the default storage account file system for Synapse. If you selected dataFactory as processingService, leave this value empty as is.')
param synapseDefaultStorageAccountFileSystemId string = ''
@description('Specifies the resource ID of the central purview instance to connect Purviw with Data Factory or Synapse. If you do not want to setup a connection to Purview, leave this value empty as is.')
param purviewId string = ''
@description('Specifies whether role assignments should be enabled for Synapse (Blob Storage Contributor to default storage account).')
param enableRoleAssignments bool = false

// Network parameters
@description('Specifies the resource ID of the subnet to which all services will connect.')
param subnetId string

// Private DNS Zone parameters
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
var synapseDefaultStorageAccountSubscriptionId = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(synapseDefaultStorageAccountFileSystemId, '/')[2] : subscription().subscriptionId
var synapseDefaultStorageAccountResourceGroupName = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(synapseDefaultStorageAccountFileSystemId, '/')[4] : resourceGroup().name
var keyvault001Name = '${name}-vault001'
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
    synapseDefaultStorageAccountFileSystemId: synapseDefaultStorageAccountFileSystemId
  }
}

module synapse001RoleAssignmentStorage 'modules/auxiliary/synapseRoleAssignmentStorage.bicep' = if(enableRoleAssignments) {
  name: 'synapse001RoleAssignmentStorage'
  scope: resourceGroup(synapseDefaultStorageAccountSubscriptionId, synapseDefaultStorageAccountResourceGroupName)
  params: {
    storageAccountFileSystemId: synapseDefaultStorageAccountFileSystemId
    synapseId: synapse001.outputs.synapseId
  }
}

// Outputs

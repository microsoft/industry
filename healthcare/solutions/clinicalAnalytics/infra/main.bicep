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
@allowed([
  'dataFactory'
  'synapse'
])
@description('Specifies the data engineering service that will be deployed (Data Factory, Synapse).')
param processingService string = 'dataFactory'
@description('Specifies the list of resource IDs of Data Lake Gen2 Containers which will be connected as datastores in the Machine Learning workspace. If you do not want to connect any datastores, provide an empty list.')
param datalakeFileSystemIds array = []
@description('Specifies the resource ID of an Azure Kubernetes cluster to connect it with Machine Learning for model deployments. If you do not want to connect an AKS cluster to Machine Learning, leave this value empty as is.')
param aksId string = ''
@description('Specifies the resource ID of a Conatiner Registry to which the Machine Learning MSI can be assigned. If you do not want to connect an external Container Registry, leave this value empty as is.')
param externalContainerRegistryId string = ''
@description('Specifies the object ID of the user who gets assigned to compute instance 001 in the Machine Learning Workspace. If you do not want to create a Compute Instance, leave this value empty as is.')
param machineLearningComputeInstance001AdministratorObjectId string = ''
@secure()
@description('Specifies the public ssh key for compute instance 001 in the Machine Learning Workspace. This parameter is optional and allows the user to connect via Visual Studio Code to the Compute Instance.')
param machineLearningComputeInstance001AdministratorPublicSshKey string = ''
@secure()
@description('Specifies the administrator password of the sql servers in Synapse. If you selected dataFactory as processingService, leave this value empty as is.')
param administratorPassword string = ''
@description('Specifies the resource ID of the default storage account file system for Synapse. If you selected dataFactory as processingService, leave this value empty as is.')
param synapseDefaultStorageAccountFileSystemId string = ''
@description('Specifies whether an Azure SQL Pool should be deployed inside your Synapse workspace as part of the template. If you selected dataFactory as processingService, leave this value as is.')
param enableSqlPool bool = false
@description('Specifies the resource ID of the central purview instance to connect Purviw with Data Factory or Synapse. If you do not want to setup a connection to Purview, leave this value empty as is.')
param purviewId string = ''
@description('Specifies the resource ID of the managed storage of the central purview instance.')
param purviewManagedStorageId string = ''
@description('Specifies the resource ID of the managed event hub of the central purview instance.')
param purviewManagedEventHubId string = ''
@description('Specifies the resource ID of the Databricks workspace that will be connected to the Machine Learning Workspace. If you do not want to connect Databricks to Machine Learning, leave this value empty as is.')
param databricksWorkspaceId string = ''
@description('Specifies the workspace URL of the Databricks workspace that will be connected to the Machine Learning Workspace. If you do not want to connect Databricks to Machine Learning, leave this value empty as is.')
param databricksWorkspaceUrl string = ''
@secure()
@description('Specifies the access token of the Databricks workspace that will be connected to the Machine Learning Workspace. If you do not want to connect Databricks to Machine Learning, leave this value empty as is.')
param databricksAccessToken string = ''
@description('Specifies whether role assignments should be enabled for Synapse (Blob Storage Contributor to default storage account).')
param enableRoleAssignments bool = false
@allowed([
  'AnomalyDetector'
  'ComputerVision'
  'ContentModerator'
  'CustomVision.Training'
  'CustomVision.Prediction'
  'Face'
  'FormRecognizer'
  'ImmersiveReader'
  'LUIS'
  'Personalizer'
  'SpeechServices'
  'TextAnalytics'
  'TextTranslation'
])
@description('Specifies the cognitive service kind that will be deployed.')
param cognitiveServiceKinds array = []
@description('Specifies whether Azure Search should be deployed as part of the template.')
param enableSearch bool = false

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
@description('Specifies the resource ID of the private DNS zone for Data Factory.')
param privateDnsZoneIdDataFactory string = ''
@description('Specifies the resource ID of the private DNS zone for Data Factory Portal.')
param privateDnsZoneIdDataFactoryPortal string = ''
@description('Specifies the resource ID of the private DNS zone for Cognitive Services.')
param privateDnsZoneIdCognitiveService string = ''
@description('Specifies the resource ID of the private DNS zone for Container Registry.')
param privateDnsZoneIdContainerRegistry string = ''
@description('Specifies the resource ID of the private DNS zone for Azure Search.')
param privateDnsZoneIdSearch string = ''
@description('Specifies the resource ID of the private DNS zone for Blob Storage.')
param privateDnsZoneIdBlob string = ''
@description('Specifies the resource ID of the private DNS zone for File Storage.')
param privateDnsZoneIdFile string = ''
@description('Specifies the resource ID of the private DNS zone for Machine Learning API.')
param privateDnsZoneIdMachineLearningApi string = ''
@description('Specifies the resource ID of the private DNS zone for Machine Learning Notebooks.')
param privateDnsZoneIdMachineLearningNotebooks string = ''

// Variables
var name = toLower('${prefix}-${environment}')
var tagsDefault = {
  Owner: 'Data Management and Analytics Scenario'
  Project: 'Data Management and Analytics Scenario'
  Environment: environment
  Toolkit: 'bicep'
  Name: name
}
var tagsJoined = union(tagsDefault, tags)
var administratorUsername = 'SqlServerMainUser'
var synapseDefaultStorageAccountSubscriptionId = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(synapseDefaultStorageAccountFileSystemId, '/')[2] : subscription().subscriptionId
var synapseDefaultStorageAccountResourceGroupName = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(synapseDefaultStorageAccountFileSystemId, '/')[4] : resourceGroup().name
var externalContainerRegistrySubscriptionId = length(split(externalContainerRegistryId, '/')) >= 9 ? split(externalContainerRegistryId, '/')[2] : subscription().subscriptionId
var externalContainerRegistryResourceGroupName = length(split(externalContainerRegistryId, '/')) >= 9 ? split(externalContainerRegistryId, '/')[4] : resourceGroup().name
var datalakeFileSystemScopes = [for datalakeFileSystemId in datalakeFileSystemIds : {
  subscriptionId: length(split(datalakeFileSystemId, '/')) >= 13 ? split(datalakeFileSystemId, '/')[2] : subscription().subscriptionId
  resourceGroupName: length(split(datalakeFileSystemId, '/')) >= 13 ? split(datalakeFileSystemId, '/')[4] : resourceGroup().name
}]
var keyvault001Name = '${name}-vault001'
var synapse001Name = '${name}-synapse001'
var datafactory001Name = '${name}-datafactory001'
var cognitiveservicesName = '${name}-cognitiveservice'
var search001Name = '${name}-search001'
var applicationInsights001Name = '${name}-insights001'
var containerRegistry001Name = '${name}-containerregistry001'
var storage001Name = '${name}-storage001'
var machineLearning001Name = '${name}-machinelearning001'
var healthcareapiName = '${name}-health'
var eventHubName = '${name}-eventhub'

// Resources


module eventHub 'modules/services/eventHub.bicep' = {
  name: 'eventhub'
  scope: resourceGroup()
  params: {
    name: eventHubName
    myTags: tagsJoined
  }
}

module healthcareapi 'modules/services/healthcareapi.bicep' = {
  name: 'healthcareApi'
  scope: resourceGroup()
  params: {
    eventhubDetails: eventHub.outputs.eventhubdetails
    myTags: tagsJoined
    name: healthcareapiName
    storageAccountName: storage001Name
  }
}

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

module synapse001 'modules/services/synapse.bicep' = if (processingService == 'synapse') {
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
    enableSqlPool: enableSqlPool
    synapseComputeSubnetId: ''
    synapseDefaultStorageAccountFileSystemId: synapseDefaultStorageAccountFileSystemId
  }
}

module synapse001RoleAssignmentStorage 'modules/auxiliary/synapseRoleAssignmentStorage.bicep' = if (processingService == 'synapse' && enableRoleAssignments) {
  name: 'synapse001RoleAssignmentStorage'
  scope: resourceGroup(synapseDefaultStorageAccountSubscriptionId, synapseDefaultStorageAccountResourceGroupName)
  params: {
    storageAccountFileSystemId: synapseDefaultStorageAccountFileSystemId
    synapseId: processingService == 'synapse' ? synapse001.outputs.synapseId : ''
  }
}

module datafactory001 'modules/services/datafactory.bicep' = if (processingService == 'dataFactory') {
  name: 'datafactory001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    datafactoryName: datafactory001Name
    keyVault001Id: keyVault001.outputs.keyvaultId
    privateDnsZoneIdDataFactory: privateDnsZoneIdDataFactory
    privateDnsZoneIdDataFactoryPortal: privateDnsZoneIdDataFactoryPortal
    purviewId: purviewId
    purviewManagedStorageId: purviewManagedStorageId
    purviewManagedEventHubId: purviewManagedEventHubId
    machineLearning001Id: machineLearning001.outputs.machineLearningId
  }
}

module cognitiveservices 'modules/services/cognitiveservices.bicep' = [for (cognitiveServiceKind, index) in cognitiveServiceKinds: {
  name: 'cognitiveservice${padLeft(index + 1, 3, '0')}'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    cognitiveServiceName: '${cognitiveservicesName}${padLeft(index + 1, 3, '0')}'
    cognitiveServiceKind: cognitiveServiceKind
    cognitiveServiceSkuName: 'S0'
    privateDnsZoneIdCognitiveService: privateDnsZoneIdCognitiveService
  }
}]

module search001 'modules/services/search.bicep' = if(enableSearch) {
  name: 'search001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    searchName: search001Name
    searchHostingMode: 'default'
    searchPartitionCount: 1
    searchReplicaCount: 1
    searchSkuName: 'standard'
    privateDnsZoneIdSearch: privateDnsZoneIdSearch
  }
}

module applicationInsights001 'modules/services/applicationinsights.bicep' = {
  name: 'applicationInsights001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    applicationInsightsName: applicationInsights001Name
    logAnalyticsWorkspaceId: ''
  }
}

module containerRegistry001 'modules/services/containerregistry.bicep' = {
  name: 'containerRegistry001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    containerRegistryName: containerRegistry001Name
    privateDnsZoneIdContainerRegistry: privateDnsZoneIdContainerRegistry
  }
}

module storage001 'modules/services/storage.bicep' = {
  name: 'storage001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    storageName: storage001Name
    storageContainerNames: [
      'default'
    ]
    storageSkuName: 'Standard_LRS'
    privateDnsZoneIdBlob: privateDnsZoneIdBlob
    privateDnsZoneIdFile: privateDnsZoneIdFile
  }
}

module machineLearning001 'modules/services/machinelearning.bicep' = {
  name: 'machineLearning001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tagsJoined
    subnetId: subnetId
    machineLearningName: machineLearning001Name
    applicationInsightsId: applicationInsights001.outputs.applicationInsightsId
    containerRegistryId: containerRegistry001.outputs.containerRegistryId
    keyVaultId: keyVault001.outputs.keyvaultId
    storageAccountId: storage001.outputs.storageId
    datalakeFileSystemIds: datalakeFileSystemIds
    aksId: aksId
    databricksAccessToken: databricksAccessToken
    databricksWorkspaceId: databricksWorkspaceId
    databricksWorkspaceUrl: databricksWorkspaceUrl
    synapseId: processingService == 'synapse' ? synapse001.outputs.synapseId : ''
    synapseBigDataPoolId: processingService == 'synapse' ? synapse001.outputs.synapseBigDataPool001Id : ''
    machineLearningComputeInstance001AdministratorObjectId: machineLearningComputeInstance001AdministratorObjectId
    machineLearningComputeInstance001AdministratorPublicSshKey: machineLearningComputeInstance001AdministratorPublicSshKey
    privateDnsZoneIdMachineLearningApi: privateDnsZoneIdMachineLearningApi
    privateDnsZoneIdMachineLearningNotebooks: privateDnsZoneIdMachineLearningNotebooks
    enableRoleAssignments: enableRoleAssignments
  }
}

module machineLearning001RoleAssignmentContainerRegistry 'modules/auxiliary/machineLearningRoleAssignmentContainerRegistry.bicep' = if (!empty(externalContainerRegistryId) && enableRoleAssignments) {
  name: 'machineLearning001RoleAssignmentContainerRegistry'
  scope: resourceGroup(externalContainerRegistrySubscriptionId, externalContainerRegistryResourceGroupName)
  params: {
    containerRegistryId: externalContainerRegistryId
    machineLearningId: machineLearning001.outputs.machineLearningId
  }
}

module machineLearning001RoleAssignmentStorage 'modules/auxiliary/machineLearningRoleAssignmentStorage.bicep' = [ for (datalakeFileSystemId, i) in datalakeFileSystemIds : if(enableRoleAssignments) {
  name: 'machineLearning001RoleAssignmentStorage-${i}'
  scope: resourceGroup(length(datalakeFileSystemIds) <= 0 ? subscription().subscriptionId : datalakeFileSystemScopes[i].subscriptionId, length(datalakeFileSystemIds) <= 0 ? resourceGroup().name : datalakeFileSystemScopes[i].resourceGroupName)
  params: {
    machineLearningId: machineLearning001.outputs.machineLearningId
    storageAccountFileSystemId: datalakeFileSystemId
  }
}]

// Outputs

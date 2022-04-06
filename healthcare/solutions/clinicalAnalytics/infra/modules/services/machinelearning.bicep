// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Machine Learning workspace.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param machineLearningName string
param applicationInsightsId string
param containerRegistryId string
param keyVaultId string
param storageAccountId string
param datalakeFileSystemIds array = []
param aksId string = ''
param synapseId string = ''
param synapseBigDataPoolId string = ''
param databricksWorkspaceId string = ''
param databricksWorkspaceUrl string = ''
@secure()
param databricksAccessToken string = ''
param machineLearningComputeInstance001AdministratorObjectId string = ''
@secure()
param machineLearningComputeInstance001AdministratorPublicSshKey string = ''
param privateDnsZoneIdMachineLearningApi string = ''
param privateDnsZoneIdMachineLearningNotebooks string = ''
param enableRoleAssignments bool = false

// Variables
var machineLearningPrivateEndpointName = '${machineLearning.name}-private-endpoint'
var noPublicIpRegions = [
  'australiaeast'
  'eastasia'
  'japaneast'
  'japanwest'
  'francecentral'
  'northeurope'
  'westeurope'
  'centralus'
  'eastus'
  'eastus2'
  'northcentralus'
  'southcentralus'
  'westcentralus'
  'westus'
  'westus2'
]

// Resources
resource machineLearning 'Microsoft.MachineLearningServices/workspaces@2021-07-01' = {
  name: machineLearningName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    allowPublicAccessWhenBehindVnet: false
    description: machineLearningName
    //#disable-next-line BCP035
    encryption: {
      status: 'Disabled'
    }
    friendlyName: machineLearningName
    hbiWorkspace: true
    imageBuildCompute: 'cpucluster001'
    primaryUserAssignedIdentity: ''
    applicationInsights: applicationInsightsId
    containerRegistry: containerRegistryId
    keyVault: keyVaultId
    storageAccount: storageAccountId
    publicNetworkAccess: 'Disabled'
  }
}

resource machineLearningKubernetes001 'Microsoft.MachineLearningServices/workspaces/computes@2021-07-01' = if (!empty(aksId)) {
  parent: machineLearning
  name: 'kubernetes001'
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    computeType: 'AKS'
    resourceId: aksId
  }
}

resource machineLearningDatabricks001 'Microsoft.MachineLearningServices/workspaces/computes@2021-07-01' = if (enableRoleAssignments && !empty(databricksWorkspaceId) && !empty(databricksWorkspaceUrl) && !empty(databricksAccessToken)) {
  parent: machineLearning
  name: 'databricks001'
  location: location
  tags: tags
  properties: {
    computeType: 'Databricks'
    computeLocation: location
    description: 'Databricks workspace connection'
    disableLocalAuth: true
    properties: {
      databricksAccessToken: databricksAccessToken
      workspaceUrl: databricksWorkspaceUrl
    }
    resourceId: databricksWorkspaceId
  }
}

resource machineLearningSynapse001 'Microsoft.MachineLearningServices/workspaces/linkedServices@2020-09-01-preview' = if (enableRoleAssignments && !empty(synapseId)) {
  parent: machineLearning
  name: 'synapse001'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    linkedServiceResourceId: synapseId
    linkType: 'Synapse'
  }
}

resource machineLearningSynapse001BigDataPool001 'Microsoft.MachineLearningServices/workspaces/computes@2021-07-01' = if (enableRoleAssignments && !empty(synapseId) && !empty(synapseBigDataPoolId)) {
  parent: machineLearning
  name: 'bigdatapool001'
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  dependsOn: [
    machineLearningSynapse001
  ]
  properties: {
    computeType: 'SynapseSpark'
    computeLocation: location
    description: 'Synapse workspace - Spark Pool'
    disableLocalAuth: true
    resourceId: synapseBigDataPoolId
  }
}

resource machineLearningCpuCluster001 'Microsoft.MachineLearningServices/workspaces/computes@2021-07-01' = {
  parent: machineLearning
  name: 'cpucluster001'
  dependsOn: [
    machineLearningPrivateEndpoint
    machineLearningPrivateEndpointARecord
  ]
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    computeType: 'AmlCompute'
    computeLocation: location
    description: 'Machine Learning cluster 001'
    disableLocalAuth: true
    properties: {
      enableNodePublicIp: contains(noPublicIpRegions, location) ? false : true
      isolatedNetwork: false
      osType: 'Linux'
      remoteLoginPortPublicAccess: 'Disabled'
      scaleSettings: {
        minNodeCount: 0
        maxNodeCount: 4
        nodeIdleTimeBeforeScaleDown: 'PT120S'
      }
      subnet: {
        id: subnetId
      }
      vmPriority: 'Dedicated'
      vmSize: 'Standard_DS3_v2'
    }
  }
}

resource machineLearningGpuCluster001 'Microsoft.MachineLearningServices/workspaces/computes@2021-07-01' = {
  parent: machineLearning
  name: 'gpucluster001'
  dependsOn: [
    machineLearningPrivateEndpoint
    machineLearningPrivateEndpointARecord
  ]
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    computeType: 'AmlCompute'
    computeLocation: location
    description: 'Machine Learning cluster 001'
    disableLocalAuth: true
    properties: {
      enableNodePublicIp: contains(noPublicIpRegions, location) ? false : true
      isolatedNetwork: false
      osType: 'Linux'
      remoteLoginPortPublicAccess: 'Disabled'
      scaleSettings: {
        minNodeCount: 0
        maxNodeCount: 4
        nodeIdleTimeBeforeScaleDown: 'PT120S'
      }
      subnet: {
        id: subnetId
      }
      vmPriority: 'Dedicated'
      vmSize: 'Standard_NC6'
    }
  }
}

resource machineLearningComputeInstance001 'Microsoft.MachineLearningServices/workspaces/computes@2021-07-01' = if (!empty(machineLearningComputeInstance001AdministratorObjectId)) {
  parent: machineLearning
  name: 'computeinstance001'
  dependsOn: [
    machineLearningPrivateEndpoint
    machineLearningPrivateEndpointARecord
  ]
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    computeType: 'ComputeInstance'
    computeLocation: location
    description: 'Machine Learning compute instance 001'
    disableLocalAuth: true
    properties: {
      applicationSharingPolicy: 'Personal'
      computeInstanceAuthorizationType: 'personal'
      //#disable-next-line BCP037
      enableNodePublicIp: contains(noPublicIpRegions, location) ? false : true
      //#disable-next-line BCP037
      isolatedNetwork: false
      personalComputeInstanceSettings: {
        assignedUser: {
          objectId: machineLearningComputeInstance001AdministratorObjectId
          tenantId: subscription().tenantId
        }
      }
      setupScripts: {
        scripts: {
          creationScript: {}
          startupScript: {}
        }
      }
      sshSettings: {
        adminPublicKey: machineLearningComputeInstance001AdministratorPublicSshKey
        sshPublicAccess: empty(machineLearningComputeInstance001AdministratorPublicSshKey) ? 'Disabled' : 'Enabled'
      }
      subnet: {
        id: subnetId
      }
      vmSize: 'Standard_DS3_v2'
    }
  }
}

resource machineLearningDatastores 'Microsoft.MachineLearningServices/workspaces/datastores@2021-03-01-preview' = [for (datalakeFileSystemId, i) in datalakeFileSystemIds : if(length(split(datalakeFileSystemId, '/')) == 13) {
  parent: machineLearning
  name: '${length(datalakeFileSystemIds) <= 0 ? 'undefined${i}' : split(datalakeFileSystemId, '/')[8]}${length(datalakeFileSystemIds) <= 0 ? 'undefined${i}' : last(split(datalakeFileSystemId, '/'))}'
  properties: {
    tags: tags
    contents: {
      contentsType: 'AzureDataLakeGen2'
      accountName: split(datalakeFileSystemId, '/')[8]
      containerName: last(split(datalakeFileSystemId, '/'))
      credentials: {
        credentialsType: 'None'
        secrets: {
          secretsType: 'None'
        }
      }
      endpoint: environment().suffixes.storage
      protocol: 'https'
    }
    description: 'Data Lake Gen2 - ${split(datalakeFileSystemId, '/')[8]}'
    isDefault: false
  }
}]

resource machineLearningPrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: machineLearningPrivateEndpointName
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: machineLearningPrivateEndpointName
        properties: {
          groupIds: [
            'amlworkspace'
          ]
          privateLinkServiceId: machineLearning.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource machineLearningPrivateEndpointARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdMachineLearningApi) && !empty(privateDnsZoneIdMachineLearningNotebooks)) {
  parent: machineLearningPrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${machineLearningPrivateEndpoint.name}-api-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdMachineLearningApi
        }
      }
      {
        name: '${machineLearningPrivateEndpoint.name}-notebooks-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdMachineLearningNotebooks
        }
      }
    ]
  }
}

// Outputs
output machineLearningId string = machineLearning.id

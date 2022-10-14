// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Synapse workspace.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param synapseName string
param administratorUsername string = 'SqlServerMainUser'
@secure()
param administratorPassword string
param synapseSqlAdminGroupName string = ''
param synapseSqlAdminGroupObjectID string = ''
param synapseDefaultStorageAccountFileSystemId string
param synapseComputeSubnetId string = ''
param privateDnsZoneIdSynapseSql string = ''
param privateDnsZoneIdSynapseDev string = ''
param purviewId string = ''
param enableSqlPool bool = false

// Variables
var synapseDefaultStorageAccountFileSystemName = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? last(split(synapseDefaultStorageAccountFileSystemId, '/')) : 'incorrectSegmentLength'
var synapseDefaultStorageAccountName = length(split(synapseDefaultStorageAccountFileSystemId, '/')) >= 13 ? split(synapseDefaultStorageAccountFileSystemId, '/')[8] : 'incorrectSegmentLength'
var synapsePrivateEndpointNameSql = '${synapse.name}-sql-private-endpoint'
var synapsePrivateEndpointNameSqlOnDemand = '${synapse.name}-sqlondemand-private-endpoint'
var synapsePrivateEndpointNameDev = '${synapse.name}-dev-private-endpoint'

// Resources
resource synapse 'Microsoft.Synapse/workspaces@2021-03-01' = {
  name: synapseName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      accountUrl: 'https://${synapseDefaultStorageAccountName}.dfs.${environment().suffixes.storage}'
      filesystem: synapseDefaultStorageAccountFileSystemName
    }
    managedResourceGroupName: synapseName
    managedVirtualNetwork: 'default'
    managedVirtualNetworkSettings: {
      allowedAadTenantIdsForLinking: []
      linkedAccessCheckOnTargetResource: true
      preventDataExfiltration: true
    }
    publicNetworkAccess: 'Disabled'
    purviewConfiguration: {
      purviewResourceId: purviewId
    }
    sqlAdministratorLogin: administratorUsername
    sqlAdministratorLoginPassword: administratorPassword
    virtualNetworkProfile: {
      computeSubnetId: synapseComputeSubnetId
    }
  }
}

resource synapseSqlPool001 'Microsoft.Synapse/workspaces/sqlPools@2021-03-01' = if(enableSqlPool) {
  parent: synapse
  name: 'sqlPool001'
  location: location
  tags: tags
  sku: {
    name: 'DW100c'
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    storageAccountType: 'GRS'
  }
}

resource synapseBigDataPool001 'Microsoft.Synapse/workspaces/bigDataPools@2021-03-01' = {
  parent: synapse
  name: 'bigDataPool001'
  location: location
  tags: tags
  properties: {
    autoPause: {
      enabled: true
      delayInMinutes: 15
    }
    autoScale: {
      enabled: true
      minNodeCount: 3
      maxNodeCount: 10
    }
    // cacheSize: 100  // Uncomment to set a specific cache size
    customLibraries: []
    defaultSparkLogFolder: 'logs/'
    dynamicExecutorAllocation: {
      enabled: true
      //#disable-next-line BCP037
      minExecutors: 1
      //#disable-next-line BCP037
      maxExecutors: 9
    }
    // isComputeIsolationEnabled: true  // Uncomment to enable compute isolation (only available in selective regions)
    // libraryRequirements: {  // Uncomment to install pip dependencies on the Spark cluster
    //   content: ''
    //   filename: 'requirements.txt'
    // }
    nodeSize: 'Small'
    nodeSizeFamily: 'MemoryOptimized'
    sessionLevelPackagesEnabled: true
    // sparkConfigProperties: {  // Uncomment to set spark conf on the Spark cluster
    //   content: ''
    //   filename: 'spark.conf'
    // }
    sparkEventsFolder: 'events/'
    sparkVersion: '3.1'
  }
}

resource synapseManagedIdentitySqlControlSettings 'Microsoft.Synapse/workspaces/managedIdentitySqlControlSettings@2021-03-01' = {
  parent: synapse
  name: 'default'
  properties: {
    grantSqlControlToManagedIdentity: {
      desiredState: 'Enabled'
    }
  }
}

resource synapseAadAdministrators 'Microsoft.Synapse/workspaces/administrators@2021-03-01' = if (!empty(synapseSqlAdminGroupName) && !empty(synapseSqlAdminGroupObjectID)) {
  parent: synapse
  name: 'activeDirectory'
  properties: {
    administratorType: 'ActiveDirectory'
    login: synapseSqlAdminGroupName
    sid: synapseSqlAdminGroupObjectID
    tenantId: subscription().tenantId
  }
}

resource synapsePrivateEndpointSql 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: synapsePrivateEndpointNameSql
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: synapsePrivateEndpointNameSql
        properties: {
          groupIds: [
            'Sql'
          ]
          privateLinkServiceId: synapse.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource synapsePrivateEndpointSqlARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdSynapseSql)) {
  parent: synapsePrivateEndpointSql
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${synapsePrivateEndpointSql.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdSynapseSql
        }
      }
    ]
  }
}

resource synapsePrivateEndpointSqlOnDemand 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: synapsePrivateEndpointNameSqlOnDemand
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: synapsePrivateEndpointNameSqlOnDemand
        properties: {
          groupIds: [
            'SqlOnDemand'
          ]
          privateLinkServiceId: synapse.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource synapsePrivateEndpointSqlOnDemandARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdSynapseSql)) {
  parent: synapsePrivateEndpointSqlOnDemand
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${synapsePrivateEndpointSqlOnDemand.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdSynapseSql
        }
      }
    ]
  }
}

resource synapsePrivateEndpointDev 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: synapsePrivateEndpointNameDev
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: synapsePrivateEndpointNameDev
        properties: {
          groupIds: [
            'Dev'
          ]
          privateLinkServiceId: synapse.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource synapsePrivateEndpointDevARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdSynapseDev)) {
  parent: synapsePrivateEndpointDev
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${synapsePrivateEndpointDev.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdSynapseDev
        }
      }
    ]
  }
}

// Outputs
output synapseId string = synapse.id
output synapseBigDataPool001Id string = synapseBigDataPool001.id

// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Storage account.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param subnetId string
param storageName string
@allowed([
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param storageSkuName string = 'Standard_LRS'
param storageContainerNames array = [
  'default'
]
param privateDnsZoneIdBlob string = ''
param privateDnsZoneIdFile string = ''

// Variables
var storageNameCleaned = replace(storageName, '-', '')
var storagePrivateEndpointNameBlob = '${storage.name}-blob-private-endpoint'
var storagePrivateEndpointNameFile = '${storage.name}-file-private-endpoint'

// Resources
resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageNameCleaned
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: storageSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    encryption: {
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: false
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
        queue: {
          enabled: true
          keyType: 'Service'
        }
        table: {
          enabled: true
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    isNfsV3Enabled: false
    keyPolicy: {
      keyExpirationPeriodInDays: 7
    }
    largeFileSharesState: 'Disabled'
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'Metrics'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    routingPreference: {
      routingChoice: 'MicrosoftRouting'
      publishInternetEndpoints: false
      publishMicrosoftEndpoints: false
    }
    supportsHttpsTrafficOnly: true
  }
}

resource storageManagementPolicies 'Microsoft.Storage/storageAccounts/managementPolicies@2021-02-01' = {
  parent: storage
  name: 'default'
  properties: {
    policy: {
      rules: [
        {
          enabled: true
          name: 'default'
          type: 'Lifecycle'
          definition: {
            actions: {
              baseBlob: {
                // enableAutoTierToHotFromCool: true  // Not available for this configuration
                tierToCool: {
                  // daysAfterLastAccessTimeGreaterThan: 90  // Not available for HNS storage yet
                  daysAfterModificationGreaterThan: 90
                }
                // tierToArchive: {  // Uncomment, if you want to move data to the archive tier
                //   // daysAfterLastAccessTimeGreaterThan: 365
                //   daysAfterModificationGreaterThan: 365
                // }
                // delete: {  // Uncomment, if you also want to delete assets after a certain timeframe
                //   // daysAfterLastAccessTimeGreaterThan: 730
                //   daysAfterModificationGreaterThan: 730
                // }
              }
              snapshot: {
                tierToCool: {
                  daysAfterCreationGreaterThan: 90
                }
                // tierToArchive: {  // Not available for HNS storage yet
                //   daysAfterCreationGreaterThan: 365
                // }
                // delete: {  // Uncomment, if you also want to delete assets after a certain timeframe
                //   daysAfterCreationGreaterThan: 730
                // }
              }
              version: {
                tierToCool: {
                  daysAfterCreationGreaterThan: 90
                }
                // tierToArchive: {  // Uncomment, if you want to move data to the archive tier
                //   daysAfterCreationGreaterThan: 365
                // }
                // delete: {  // Uncomment, if you also want to delete assets after a certain timeframe
                //   daysAfterCreationGreaterThan: 730
                // }
              }
            }
            filters: {
              blobTypes: [
                'blockBlob'
              ]
              prefixMatch: []
            }
          }
        }
      ]
    }
  }
}

resource storageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-02-01' = {
  parent: storage
  name: 'default'
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    // automaticSnapshotPolicyEnabled: true  // Uncomment, if you want to enable addition features on the storage account
    // changeFeed: {
    //   enabled: true
    //   retentionInDays: 7
    // }
    // defaultServiceVersion: ''
    // deleteRetentionPolicy: {
    //   enabled: true
    //   days: 7
    // }
    // isVersioningEnabled: true
    // lastAccessTimeTrackingPolicy: {
    //   name: 'AccessTimeTracking'
    //   enable: true
    //   blobType: [
    //     'blockBlob'
    //   ]
    //   trackingGranularityInDays: 1
    // }
    // restorePolicy: {
    //   enabled: true
    //   days: 7
    // }
  }
}

resource storageContainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [for storageContainerName in storageContainerNames: {
  parent: storageBlobServices
  name: storageContainerName
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}]

resource storagePrivateEndpointBlob 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: storagePrivateEndpointNameBlob
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: storagePrivateEndpointNameBlob
        properties: {
          groupIds: [
            'blob'
          ]
          privateLinkServiceId: storage.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource storagePrivateEndpointBlobARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdBlob)) {
  parent: storagePrivateEndpointBlob
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${storagePrivateEndpointBlob.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdBlob
        }
      }
    ]
  }
}

resource storagePrivateEndpointFile 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: storagePrivateEndpointNameFile
  location: location
  tags: tags
  properties: {
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: storagePrivateEndpointNameFile
        properties: {
          groupIds: [
            'file'
          ]
          privateLinkServiceId: storage.id
          requestMessage: ''
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource storagePrivateEndpointFileARecord 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = if (!empty(privateDnsZoneIdFile)) {
  parent: storagePrivateEndpointFile
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${storagePrivateEndpointFile.name}-arecord'
        properties: {
          privateDnsZoneId: privateDnsZoneIdFile
        }
      }
    ]
  }
}

// Outputs
output storageId string = storage.id

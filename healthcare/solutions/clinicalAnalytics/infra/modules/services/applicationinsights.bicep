// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create Application Insights.
targetScope = 'resourceGroup'

// Parameters
param location string
param tags object
param applicationInsightsName string
//#disable-next-line no-unused-params
param logAnalyticsWorkspaceId string

// Variables

// Resources
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    Flow_Type: 'Bluefield'
    ForceCustomerStorageForProfiler: false
    ImmediatePurgeDataOn30Days: true
    IngestionMode: 'ApplicationInsights'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Disabled'
    Request_Source: 'rest'
    // SamplingPercentage: 50  // Uncomment, if you want to define the sampling percentage that should be used for the telemetry.
    // WorkspaceResourceId: logAnalyticsWorkspaceId  // Uncomment, if you want to connect your application insights to the central log analytics workspace.
  }
}

// Outputs
output applicationInsightsId string = applicationInsights.id

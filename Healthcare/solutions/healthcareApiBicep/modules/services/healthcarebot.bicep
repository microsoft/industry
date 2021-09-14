// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

// This template is used to create a Healthcare API.
targetScope = 'resourceGroup'

// General Parameters
param location string
param tags object
param healthcarebotName string
@allowed([
  'F0'
  'C0'
  'S1'
])
param healthcarebotSku string = 'S1'

// Variables

// Resources
resource healthbot 'Microsoft.HealthBot/healthBots@2020-12-08' = {
  name: healthcarebotName
  location: location
  tags: tags
  sku: {
    name: healthcarebotSku
  }
  properties: {}
}

// Outputs

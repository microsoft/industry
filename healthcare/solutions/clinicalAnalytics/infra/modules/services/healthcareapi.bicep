targetScope = 'resourceGroup'

param name string
param storageAccountName string
param myTags object
param eventhubDetails object
param authorityUrl string = '${environment().authentication.loginEndpoint}${subscription().tenantId}'
param audienceUrl string = 'https//${name}healthapi-${name}healthapi-fhir.fhir.azurehealthcareapis.com'

resource healthapi 'Microsoft.HealthcareApis/workspaces@2021-06-01-preview' = {
  name: 'healthapi'
  location: resourceGroup().location
  tags: myTags

  resource healthApiFihr 'fhirservices@2021-06-01-preview' = {
    name: '${name}-fhir'
    kind: 'fhir-R4'
    location: resourceGroup().location
    properties: {
      //accessPolicies: 
      authenticationConfiguration: {
          authority: authorityUrl
          audience: audienceUrl
          smartProxyEnabled: false
      }
      corsConfiguration: {
        allowCredentials: false
        headers: [
          '*'
        ]
        maxAge: 1440
        methods: [
          'DELETE'
          'GET'
          'OPTIONS'
          'PATCH'
          'POST'
          'PUT'
        ]
        origins: [
          'https://localhost:6001'
        ]
      }
      exportConfiguration: {
        storageAccountName: storageAccountName
      }
    }
    
  }

  resource healthApiDicom 'dicomservices@2021-06-01-preview' = {
    name: '${name}-dicom'
    location: resourceGroup().location
  }

  resource healthApiIot 'iotconnectors@2021-06-01-preview' = {
    name: '${name}healthapi-iot'
    location: resourceGroup().location
    properties: {
      ingestionEndpointConfiguration:{
        eventHubName: eventhubDetails.eventHubName  //eventHubName
        consumerGroup: eventhubDetails.consumerGroup
        fullyQualifiedEventHubNamespace: eventhubDetails.fullyQualifiedEventHubNamespace
      }
      deviceMapping: {
        content: {
          templateType: 'CollectionContent'
          template: [
          {
            templateType: 'JsonPathContent'
            template: {
              typeName: 'heartrate'
              typeMatchExpression: '$..[?(@heartrate)]'
              deviceIdExpression: '$.deviceid'
              timestampExpression: '$.measurementdatetime'
              values: [
                {
                required: 'true'
                valueExpression: '$.heartrate'
                valueName: 'Heart rate'
              }            
            ]
            }
          }
        ]
        }
      }
    }
    resource iotDestination 'fhirdestinations@2021-06-01-preview' = {
			name: '${name}-iotdestination'
			location: resourceGroup().location
			
			properties: {
				resourceIdentityResolutionType: 'Create'
				fhirServiceResourceId: healthApiFihr.id
				fhirMapping: {
          content: {
            templateType: 'CollectionFhirTemplate'
            template: [
            {
              templateType: 'CodeValueFhir'
              template: {
                codes: [
                  {
                    code: '8867-4'
                    system: 'http://loinc.org'
                    display: 'Heart rate'
                  }
                  ]
                  periodInterval: 60
                  typeName: 'heartrate'
                  value: {
                    defaultPeriod: 5000
                    unit: 'count/min'
                    valueName: 'hr'
                    valueType: 'SampledData'
                  }
                }
              }
              ]
           }        
        } 
      }
    }
  }
}


output healthapiout string = name

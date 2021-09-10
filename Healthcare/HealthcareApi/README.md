# Azure Healthcare APIs

This is a sample template for Azure Healthcare APIs. More details about the service can be found in [the official documentation](https://docs.microsoft.com/en-us/azure/healthcare-apis/).

## Deployment

Please use the following button to deploy the service into your resource group:

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)]()

## Policies

Custom Policies for the industry specific services used in this solution can be found in the folder [`/Healthcare/HealthcareApi/Policies/PolicyDefinitions/HealthCareApis`](/Healthcare/HealthcareApi/Policies/PolicyDefinitions/HealthCareApis). These policies can be deployed using:

1. [ARM template for deployment to subscription scope](/Healthcare/HealthcareApi/Policies/PolicyDefinitions/deploy.policyDefinition.sub.json)
2. [ARM template for deployment to management group scope](/Healthcare/HealthcareApi/Policies/PolicyDefinitions/deploy.policyDefinition.mg.json)

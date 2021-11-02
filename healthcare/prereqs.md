# Pre-requisites for Healthcare

To setup the Healthcare capabilities that spans the Microsoft Clouds, the following pre-requisites are required.

## Licensing requirements

| Product name | Description |
|:----------------------|:------------|
|Microsoft Cloud for Healthcare | Licenses for Healthcare applications deployed to Power platform
|Digital Messaging add-in for Dynamics 365 Customer service | placeholder
|Dynamics 365 Customer Service Enterprise | placeholder
|Dynamics 365 Marketing | placeholder
|Power BI Pro | placeholder
|Power Apps for Dynamics 365 | placeholder
|Dynamics 365 Field Service | placeholder
|Sales Insights Add-in for Dynamics 365 Sales | placeholder
|Dynamics 365 Sales Enterprise | placeholder
|Microsoft Teams | placeholder

## Azure subscription (landing zone)

Healthcare APIs require a subscription (landing zone) in Azure that will host the Healthcare APIs to enable FHIR to integrate with the Healthcare applications.

[Prescriptive guidance for Azure landing zone and reference implementation](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/implementation)

## Healthcare APIs (FHIR)

Use this reference implementation to deploy Healthcare APIs into your landing zone, which follows best practices from a composition, security, and observability perspective. Additional configuration and enhancement can be made per your requirements

[Prescriptive guidance and design recommendations for Healthcare APIs with FHIR and reference implementation](./solutions/healthcareApis)

## Power Platform

Healthcare requires Power Platform environments (recommendation is dedicated environments for test, development, and production) that are created into the target region with D365 applications enabled.

[Prescriptive guidance and design recommendations for Power Platform for Healthcare](../foundations/powerPlatform)

## Microsoft Teams

Teams is used for many of the healthcare capabilities, such as care management and collaboration.

[Prescriptive guidance and design recommendations for Microsoft Teams for Healthcare](./solutions/microsoftTeams)
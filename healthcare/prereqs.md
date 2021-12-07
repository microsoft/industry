# Pre-requisites for Healthcare

To setup the Healthcare capabilities that spans the Microsoft Clouds, the following pre-requisites are required.

## Licensing requirements

| Product name |
|:----------------------:|
|Microsoft Cloud for Healthcare
|Digital Messaging add-in for Dynamics 365 Customer service
|Dynamics 365 Customer Service Enterprise
|Dynamics 365 Marketing
|Power BI Pro
|Power Apps for Dynamics 365
|Dynamics 365 Field Service
|Sales Insights Add-in for Dynamics 365 Sales
|Dynamics 365 Sales Enterprise
|Microsoft Teams

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

---

[Back to documentation root](../README.md)
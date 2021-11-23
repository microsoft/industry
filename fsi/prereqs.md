# Pre-requisites for Financial Services

To setup the Financial Services capabilities that spans the Microsoft Clouds, the following pre-requisites are required.

## Licensing requirements

| Product name |
|:----------------------:|
|Microsoft Cloud for Financial Services
|Dynamics 365 Customer Service Enterprise
|Chat add-in for Dynamics 365 Customer Service
|Dynamics 365 Fraud Protection
|Dynamics 365 Customer Insights
|Power Apps for Dynamics 365
|Microsoft Teams

## Azure subscription (landing zone)

Azure Synapse provides industry-specific schema definitions that provide a quick method of creating a database known as lake database, that can accelerate building analytics-infused industry applications. Azure Synapse require a subscription (landing zone) in Azure that will host the Synapse and requisite infrastructure.

[Prescriptive guidance for Azure landing zone and reference implementation](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/implementation)

## Azure Synapse with database template for Banking

Use this reference implementation to deploy Azure Synapse with database template for Banking into your landing zone, which follows best practices from a composition, security, and observability perspective. Additional configuration and enhancement can be made per your requirements

[Prescriptive guidance and design recommendations for Azure Synapse with database template for Banking and reference implementation](./solutions/synapseBanking)

## Power Platform

Microsoft Cloud for Financial Services requires Power Platform environments (recommendation is dedicated environments for test, development, and production) that are created into the target region with D365 applications enabled.

[Prescriptive guidance and design recommendations for Power Platform for Financial Services](../foundations/powerPlatform)

## Microsoft Teams

Microsoft Teams is used for many of the Financial Services capabilities, such as collaboration manager for loans.

[Prescriptive guidance and design recommendations for Microsoft Teams for Financial Services](./solutions/microsoftTeams)
# Financial Services Foundations (Recommended)

To setup the Financial Services capabilities that spans the Microsoft Clouds, the following pre-requisites are required.

## Licensing requirements

The table below summarizes the licenses you may require depending on the Financial Services scenarios you want to deploy. See specific requirements in the respective documentation and implementation guide for each scenario.

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

Microsoft Cloud for Financial Services requires Power Platform environments (recommendation is dedicated environments for test, development, and production) that are created into the target region with Dataverse and D365 applications enabled.

[Prescriptive guidance and design recommendations for Power Platform for Financial Services](../foundations/powerPlatform)

## Microsoft Teams

Microsoft Teams is used for many of the Financial Services capabilities, such as collaboration manager for loans.

[Prescriptive guidance and design recommendations for Microsoft Teams for Financial Services](./solutions/microsoftTeams)

### Design Recommendations

Business applications for FSI has a need for realtime data in several user scenarios, ex account balance has to be reflecting the current state and is updated frequently.

Analytics use cases require a larger dataset, but less frequent updates.

Dataverse use a data model for FSI, this model is tightly integrated with the business applications built for Microsoft Cloud for Finance. Azure Synapse using Lake Database templates currently offers data models for Banking and Fund Management. For data to flow between the different models a mapping data flow needs to be developed. This mapping can be developed using Synapse Pipelines or Azure Data Factory.

### Design Considerations

Consider creating different data pipelines for the realtime data requirements of the business applications and for the analytics workloads.

It is technically possible to connect PowerBi directly to Dataverse, but in order to have a unified data pipeline consider to let all data flow from Dataverse to ADLS/Synapse and PowerBI reads from that storage layer.

## Known issues

> - FSI connector is in development.
> - Mapping between data models is in development.
> 
# Financial Services

Overall architecture for Microsoft Cloud for Financial Services.

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Azure for FSI | Azure for FSI foundation  provides full architecture with landing zones for FSI industry |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fri%2FhealthArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fri%2Fhealth-portal.json)
| Power Platform for FSI | Coming Soon | Coming Soon
| Microsoft Teams for FSI | Coming Soon | Coming Soon

![Financial Services Industry Reference Architecture](./docs/mc4f-reference-architecture.png)

## Design Recommendations

Business applications for FSI has a need for realtime data in several user scenarios, ex account balance has to be reflecting the current state and is updated frequently.

Analytics use cases require a larger dataset, but less frequent updates.

Dataverse use a data model for FSI, this model is tightly integrated with the business applications built for Microsoft Cloud for Finance. Azure Synapse using Lake Database templates currently offers data models for Banking and Fund Management. For data to flow between the different models a mapping data flow needs to be developed. This mapping can be developed using Synapse Pipelines or Azure Data Factory.

## Design Considerations

Consider creating different data pipelines for the realtime data requirements of the business applications and for the analytics workloads.

It is technically possible to connect PowerBi directly to Dataverse, but in order to have a unified data pipeline consider to let all data flow from Dataverse to ADLS/Synapse and PowerBI reads from that storage layer.

## Known issues

> - FSI connector is in development
> - Mapping between data models
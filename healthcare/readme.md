# Healthcare

In the overall architecture for Microsoft Cloud for Healthcare, the Healthcare APIs components together with the FHIR Sync Agent enable organizations to use standards based data models e.g. Fast Healthcare Interoperability Resources (FHIR) standards frameworks and simplifies data synchronization between Azure and Microsoft Dataverse in the Power Platform.

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Azure for Healthcare | Azure for Healthcare foundation  provides full architecture with landing zones for Healthcare industry, including Azure Healthcare API workloads |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fri%2FhealthArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fri%2Fhealth-portal.json)
| Power Platform for Healthcare | Coming Soon | Coming Soon
| Microsoft Teams for Healthcare | Coming Soon | Coming Soon

![Healthcare Industry Reference Architecture](./docs/mc4h-reference-architecture.png)

> ### Known issues
>
> There are a few known issues:
>
> - Existing storage account and existing workspace is currently not mapped
> - Container for storage account must be created post deployment (will be fixed shortly)
> - FHIR sync agent is coming shortly
> - FHIR proxy is coming shortly
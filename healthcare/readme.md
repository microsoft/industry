# Azure for Healthcare

Due to the security and compliance requirements nature of their business, organizations in the healthcare industry have a unique set of requirements compared other organizations of similar scale. Such requirements include:

* placeholder
* placeholder
* placeholder

This article provides a reference architecture with prescriptive guidance and recommendations for the Healthcare industry across the Microsoft Cloud (Power Platform, Dynamics, Microsoft 365 and Microsoft Azure).

## Table of Contents

* [Azure for Healthcare Reference Implementations](#azure-for-telecommunications-reference-implementation)
* [Azure for Healthcare Reference Architectures](#azure-for-telecommunications-reference-architecture)
* [High-level architecture](#high-level-architecture)
  * [Governance for Healthcare Industry Scenarios](#letter-a)
  * [Healthcare APIs and interoperability for Healthcare Industry Scenarios](#letter-b)
  * [Healthcare Landing Zones](#letter-c)
  * [Data and Analytics for Healthcare Industry Scenarios](#letter-d)
* [Next Steps](#next-steps)

## Azure for Healthcare Reference Implementations

In the overall architecture for Microsoft Cloud for Healthcare, the Healthcare APIs components together with the FHIR Sync Agent enable organizations to use standards based data models e.g. Fast Healthcare Interoperability Resources (FHIR) standards frameworks and simplifies data synchronization between Azure and Microsoft Dataverse in the Power Platform.

| Industry Architecture | Description | Deploy | Documentation
|:----------------------|:------------|--------|--------------|
| Azure for Healthcare | Azure for Healthcare foundation that provides a full, rich, compliant architecture which caters for highly regulated landing zones for Healthcare industry scenarios |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afhRI) | [User Guide](./referenceImplementation/readme.md)
| Azure Healthcare APIs | Reference implementation for Healthcare APIs |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afoScaleOut) | [User Guide](./referenceImplementation/readme.md)
| Healthcare Analytics | Reference implementation for data and analytics specifically for Healthcare industry |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afoScaleOut) | [User Guide](./referenceImplementation/readme.md)

![Healthcare Industry Reference Architecture](./docs/mc4h-reference-architecture.png)

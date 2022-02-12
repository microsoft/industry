# Azure for Healthcare

This article provides a reference architecture with prescriptive guidance and recommendations for the Healthcare industry across the Microsoft Cloud (Power Platform, Dynamics, Microsoft 365 and Microsoft Azure).

## Table of Contents

- [Azure for Healthcare Reference Implementations](#azure-for-healthcare-reference-implementations)
- [Azure for Healthcare Reference Architecture](#azure-for-healthcare-reference-architecture)
- [Regulatory Compliance](#regulatory-compliance)
- [Architecture composition](#architecture-composition)
  - [Healthcare Landing Zones](#healthcare-landing-zones)
  - [Azure Healthcare API](#azure-healthcare-api)
  - [Healthcare Analytics](#healthcare-analytics)

## Azure for Healthcare Reference Implementations

| Industry Architecture | Description | Deploy | Documentation
|:----------------------|:------------|--------|--------------|
| Azure for Healthcare | Azure for Healthcare foundation that provides a full, rich, compliant architecture which caters for highly regulated landing zones for Healthcare industry scenarios |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afhRI) | [User Guide](./referenceImplementation/readme.md)
| Azure Healthcare APIs | Reference implementation for Healthcare APIs |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afhApis) | [User Guide](./solutions/healthcareApis)
| Healthcare Analytics | Reference implementation for data and analytics specifically for Healthcare industry |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afhAnalytics) | [User Guide](./solutions/clinicalAnalytics)

## Azure for Healthcare Reference Architecture

![Healthcare Industry Reference Architecture](./docs/mc4h-reference-architecture.png)

## Regulatory Compliance

Due to the security and compliance requirements nature of their business, organizations in the healthcare industry have a unique set of requirements compared other organizations of similar scale. Such requirements include:

- ASIP HDS
  - Microsoft Azure, Microsoft Dynamics 365, and Microsoft Office 365 have been granted the Health Data Hosting (Hébergeurs de Données de Santé, HDS) certification. Using this reference deployment ensures that advanced security and privacy requirements on the hosted services to ensure that the confidentiality and integrity of sensitive data is adequately protected. The HDS certificate applies to Azure services listed as compliant with the ISO/IEC 27001 standard in Azure Compliance offerings and provisioned in European regions.
- EPCS
  - This reference template helps you meet your EPCS multi-factor authentication requirements. According to NIST SP 800-63B Section 4.3, multi-factor authenticators used at AAL3 shall rely on hardware cryptographic modules validated at FIPS 140 Level 2 overall with at least FIPS 140 Level 3 for physical security. Verifiers at AAL3 shall be validated at FIPS 140 Level 1 or higher.
- GxP
  - This reference template helps you meet your GxP requirements and regulations enforced by the FDA under 21 CFR Part 11. There is no GxP or FDA 21 CFR Part 11 certification for cloud service providers; however, Azure has undergone independent third-party audits for quality management and information security, including ISO 9001 and ISO 27001
- HIPAA
  - This reference template enable the physical, technical, and administrative safeguards required by HIPAA and the HITECH Act inside the in-scope Azure services. Resources are evaluated by Azure Policy for compliance with assigned policy definitions. Microsoft offers a HIPAA BAA as part of the Microsoft Online Services Terms to all customers who are covered entities or business associates under HIPAA for use of such in-scope Azure services.
- HITRUST
  - Microsoft Azure is one of the first hyper-scale cloud service providers to receive a formal certification for the HITRUST CSF. Deployment using these reference templates ensures that you adhere to the compliance requirements for HITRUST.
- MARS-E
  - The reference template applies the relevant controls in the underlying NIST SP 800-53 control baseline demonstrate Azure alignment with MARS-E security and privacy requirements.
  
Audit reports can be found here: [Azure & O365 Audit Reports](https://servicetrust.microsoft.com/ViewPage/MSComplianceGuideV3?command=Download&downloadType=Document&downloadId=15d5a5fa-fbb6-4ea6-8126-2a2c684ae789&tab=7027ead0-3d6b-11e9-b9e1-290b1eb4cdeb&docTab=7027ead0-3d6b-11e9-b9e1-290b1eb4cdeb_GRC_Assessment_Reports)

## Architecture composition

The composition of the end to end Microsoft Cloud For Healthcare deployment is layered in a set of steps. This gives you flexibility with deploying the relevant components and allow for different teams in the organization to be responsible for deployment and continuous ownership of additional development, configuration and maintenance needs. In the overall architecture for Microsoft Cloud for Healthcare, the Healthcare APIs components enable organizations to use standards based data models e.g. Fast Healthcare Interoperability Resources (FHIR) standards frameworks and Dicom image library.

### Healthcare Landing Zones

- [Healthcare Landing Zones](./referenceImplementation)

The architecture in the Healthcare Industry reference implementation establishes the essentials for a scalable, secure environment following the compliance requirements of the industry globally.

### Azure Healthcare APIs

- [Azure Healthcare API](./solutions/healthcareApis/readme.md)

Building on the secure foundation established in Healthcare Landing Zone an essential part of a healthcare cloud environment are the Azure Healthcare API's.

### Healthcare Analytics

- [Healthcare Analytics](./solutions/clinicalAnalytics/readme.md)
  
The solution for Healthcare Analytics will harness data and discover insights to deliver value. In this guidance we show how you can persist data in the Healthcare API, export de-identified data to an analytical store, enable large scale analytical query capabilities and leverage insights from AI assisted imaging analysis and population health metrics to determine course of care. The analytical solution enable you to search through large amounts of data from sources like electronic medical records, smart medical devices, patient and population demographics, and the public domain to find hidden patterns and trends and predict outcomes.

---

[Back to documentation root](../README.md)

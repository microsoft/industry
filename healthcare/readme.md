# Azure for Healthcare

This article provides a reference architecture with prescriptive guidance and recommendations for the Healthcare industry across the Microsoft Cloud (Power Platform, Dynamics, Microsoft 365 and Microsoft Azure).

## Table of Contents

- [Azure for Healthcare Reference Implementations](#azure-for-healthcare-reference-implementations)
- [Azure for Healthcare Reference Architectures](#azure-for-healthcare-reference-architecture)
- [Compliance](#compliance)
- [Deployment steps](#deployment-steps)
  - [Healthcare Landing Zone](#healthcare-landing-zone)
  - [Azure Healthcare API](#azure-healthcare-api)
  - [Healthcare Analytics](#healthcare-analytics)
  - [North Star Architecture for Power Platform](#north-star-architecture-for-power-platform)
  - [Solutions for healthcare](#solutions-for-healthcare)

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

* ASIP HDS
  * Microsoft Azure, Microsoft Dynamics 365, and Microsoft Office 365 have been granted the Health Data Hosting (Hébergeurs de Données de Santé, HDS) certification. Using this reference deployment ensures that advanced security and privacy requirements on the hosted services to ensure that the confidentiality and integrity of sensitive data is adequately protected. The HDS certificate applies to Azure services listed as compliant with the ISO/IEC 27001 standard in Azure Compliance offerings and provisioned in European regions.
* EPCS
  * This reference template helps you meet your EPCS multi-factor authentication requirements. According to NIST SP 800-63B Section 4.3, multi-factor authenticators used at AAL3 shall rely on hardware cryptographic modules validated at FIPS 140 Level 2 overall with at least FIPS 140 Level 3 for physical security. Verifiers at AAL3 shall be validated at FIPS 140 Level 1 or higher.
* GxP
  * This reference template helps you meet your GxP requirements and regulations enforced by the FDA under 21 CFR Part 11. There is no GxP or FDA 21 CFR Part 11 certification for cloud service providers; however, Azure has undergone independent third-party audits for quality management and information security, including ISO 9001 and ISO 27001
* HIPAA
  * This reference template enable the physical, technical, and administrative safeguards required by HIPAA and the HITECH Act inside the in-scope Azure services. Resources are evaluated by Azure Policy for compliance with assigned policy definitions. Microsoft offers a HIPAA BAA as part of the Microsoft Online Services Terms to all customers who are covered entities or business associates under HIPAA for use of such in-scope Azure services.
* HITRUST
  * Microsoft Azure is one of the first hyper-scale cloud service providers to receive a formal certification for the HITRUST CSF. Deployment using these reference templates ensures that you adhere to the compliance requirements for HITRUST.
* MARS-E
  * The reference template applies the relevant controls in the underlying NIST SP 800-53 control baseline demonstrate Azure alignment with MARS-E security and privacy requirements.
  
Audit reports can be found here: [Azure & O365 Audit Reports](https://servicetrust.microsoft.com/ViewPage/MSComplianceGuideV3?command=Download&downloadType=Document&downloadId=15d5a5fa-fbb6-4ea6-8126-2a2c684ae789&tab=7027ead0-3d6b-11e9-b9e1-290b1eb4cdeb&docTab=7027ead0-3d6b-11e9-b9e1-290b1eb4cdeb_GRC_Assessment_Reports)

## Deployment steps

The composition of the end to end Microsoft Cloud For Healthcare deployment is layered in a set of steps. This gives you flexibility with deploying the relevant components and allow for different teams in the organization to be responsible for deployment and continuous ownership of additional development, configuration and maintenance needs. In the overall architecture for Microsoft Cloud for Healthcare, the Healthcare APIs components enable organizations to use standards based data models e.g. Fast Healthcare Interoperability Resources (FHIR) standards frameworks and Dicom image library.

### Healthcare Landing Zone

The architecture in the Healthcare Industry reference implementation establishes the essentials for a scalable, secure environment following the compliance requirements of the industry globally.

### Azure Healthcare API

* [Azure Healthcare API](./solutions/healthcareApis/readme.md)

Building on the secure foundation established in Healthcare Landing Zone an essential part of a healthcare cloud environment are the Azure Healthcare API's.

### Healthcare Analytics

* [Healthcare Analytics](./solutions/clinicalAnalytics/readme.md)
  
The solution for Healthcare Analytics will harness data and discover insights to deliver value. In this guidance we show how you can persist data in the Healthcare API, export de-identified data to an analytical store, enable large scale analytical query capabilities and leverage insights from AI assisted imaging analysis and population health metrics to determine course of care. The analytical solution enable you to search through large amounts of data from sources like electronic medical records, smart medical devices, patient and population demographics, and the public domain to find hidden patterns and trends and predict outcomes.

### North Star Architecture for Power Platform

* [North Star Architecture for Power Platform](../foundations/powerPlatform/readme.md) 

All up architecture for Power Platform with landing zones (environments) securely configured with security, governance, and compliance for scalable business applications - and industry solutions for professional and citizen developers. North Star Architecture for Power Platform is an architecture and design methodology, as well as a reference implementation to deploy into your on Power Platform tenant. It enables effective construction and operationalization of landing zones (environments) on Power Platform, at scale. This approach aligns with the platform and product roadmap and the Center of Excellence adoption framework.

### Solutions for healthcare

* [Care management](./solutions/careManagement/readme.md) The Care management solution creates a model-driven app within Power Platform to provide healthcare-specific capabilities as part of Microsoft Cloud for Healthcare. The solution allows health providers to create, personalize and enable new care plans for patients and manage care team members.
* [Home Health](./solutions/homeHealth/readme.md) Home health extends Microsoft Dynamics 365 Field Services with healthcare specific capabilities to manage home visit schedules, notify patients and give providers access to medical information.
* [Internet of Medical Things](./solutions/IoMT/readme.md) Internet of Medical Things (IoMT) focusses on the practical application of IoT in the area of healthcare. In IoMT scenarios medical data is collected and sometime pre-processed through the means of internet Connected medical devices and then sent to a datacenter in (near) real-time.
* [Microsoft Teams for Healthcare](./solutions/microsoftTeams/readme.md) Microsoft Teams offers a number of useful tele-medicine features and scenarios useful for hospitals and Healthcare organizations in the context of Microsoft Cloud for Healthcare. This document outlines recommendations in order to leverage Microsoft Teams across the various Healthcare scenarios, as well as a reference architecture and implementation.
* [Patient Access](./solutions/patientAccess/readme.md) Patient access customizes a Microsoft Power Apps portal with healthcare-specific capabilities as part of Microsoft Cloud for Healthcare. It provides patients with access to their health data, knowledge articles, and in-person and virtual appointment scheduling, chat with health bot, communicate with a caregiver, and view their clinical data. The portal connects with entities in Dataverse.
* [Patient outreach](./solutions/patientOutreach/readme.md) Patient outreach is a patient campaign management application that helps organize and automate marketing and outreach to patients. Healthcare providers can communicate with their communities and patients in a targeted, efficient way. Providers can use email, text, regular mail, or a combination, to provide healthcare information to specific groups of patients and community members.
* [Patient service center](./solutions/patientServiceCenter/readme.md) Patient service center enables your organization to engage with your patients in the way they want, by using chat, and monitor automatic conversations through the Microsoft Azure Healthbot service. Service agents can help your patients with information and setting up appoints.

---

[Back to documentation root](../README.md)

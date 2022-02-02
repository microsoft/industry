# Azure Cloud Foundation for industries

The Microsoft Azure Cloud Foundation for industries is based on proven and authoritative guidance that is published and documented in the [Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/).

Each of the respective reference implementations in this repository is based on this as a foundation, and provides unique industry recommendations and industry specific implementations to accelerate organizations in the respective industries journey to a scalable foundation for subsequent industry solutions.

| Azure Cloud Foundations | Description | Deploy |
|:----------------------|:------------|--------|
| Azure for Telecommunications | Azure for Telco foundation that provides a full, rich, compliant architecture with scale-out pattern for connectivity and landing zones for Telco industry scenarios |[![Deploy To Microsoft Cloud](../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afoRi)
| Azure for Healthcare | Azure for Healthcare foundation that provides a full, rich compliant architecture with specific HIPAA/HITRUST compliance requirements, alongside with Healthcare APIs in the landing zones for interoperability with Healthcare solutions in Power Platform | [![Deploy To Microsoft Cloud](../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/afhRi)

The architecture and design for the Azure for industries foundation is based on the following design principles:

## Design Principles for Azure Cloud Foundation

These principles serve as a compass for subsequent design decisions across critical technical domains. Readers are strongly advised to familiarize themselves with these principles to better understand their impact and the trade-offs associated with non-adherence.

### Subscription Democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities, to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design and development/testing of new workloads and migration of workloads.

### Policy Driven Governance

Azure Policy should be used to provide the **guard-rails** and ensure the continued compliance of the customer platform and applications deployed onto it, whilst also providing application owners sufficient freedom and a secure unhindered path to cloud.

### Single Control and Management Plane

The "North Star" architecture should not consider any abstraction layers such as customer developed portals or tooling and should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels which should be used to establish a consistent set of policies and controls for governing the entire customer estate, subject to RBAC and policy driven controls.

### Application Centric and Archetype-Neutral

The "North Star" architecture should focus on application centric migrations and development rather than a pure infrastructure "lift and shift" migration (i.e. movement of virtual machines) and should not differentiate between old/new applications or IaaS/PaaS applications. Ultimately, it should provide the foundation for all application types to be deployed onto the customer Azure platform securely and safely.

### Azure Native Design and Roadmap Aligned

The **Enterprise Scale architecture** approach advocates the use of native platform services and capabilities whenever possible, which should be aligned with Azure platform roadmaps to ensure new capabilities are made available within customer environments. Azure platform roadmaps should help inform the migration strategy and **North Star** trajectory.

### Recommendations

- Be prepared to trade off functionality as not everything will likely be required on day one.
- Leverage preview services and take dependencies on service roadmaps in order to remove technical blockers.

## Critical Design areas

Use the guidelines in the following Critical design areas article series to help you translate your requirements to Azure constructs and capabilities. These eight critical design areas articles can help you address the mismatch between on-premises and cloud-design infrastructure, which typically creates dissonance between the enterprise-scale definition and Azure adoption.

Decisions you make within these critical areas reverberate across enterprise-scale architecture and influence other decisions. Familiarize yourself with these eight critical design areas to better understand the consequences of encompassed decisions, which might later produce trade-offs within related areas:

* [Enterprise enrollment and Azure AD tenants](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/enterprise-enrollment-and-azure-ad-tenants)

* [Identity and access management](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/identity-and-access-management)

* [Management group and subscription organization](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/management-group-and-subscription-organization)

* [Network topology and connectivity](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/network-topology-and-connectivity)

* [Management and monitoring](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/management-and-monitoring)

* [Business continuity and disaster recovery](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/business-continuity-and-disaster-recovery)

* [Security, governance and compliance](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/security-governance-and-compliance)

* [Platform automation and DevOps](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/platform-automation-and-devops)

---

[Back to documentation root](../README.md)
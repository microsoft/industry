# Architecture and Design

This article goes into the details of the architecture and design of the FSI Landing Zones on Microsoft Azure, and explains key design areas and recommendations across the critical design areas for Azure as a whole that an organization within the financial services industry must consider.

## Table of contents

* [Architecture overview](#overview)
* [Design principles](#design-principles)
    * [Subscription democratization](#subscription-democratization)
    * [Policy-Driven governance](#policy-driven-governance)
    * [Single control and management plane](#single-control-and-management-plane)
    * [Archetype neutral, and application centric](#archetype-neutral-and-application-centric)
    * [Azure native design and aligned with platform roadmap](#azure-native-design-and-aligned-with-platform-roadmap)
* [Design areas](#design-areas)
    * [Identity and access management](#identity-and-access-management)
    * [Management group and subscription organization](#management-group-and-subscription-organization)
    * [Network topology and connectivity](#network-topology-and-connectivity)
    * [Management and monitoring](#management-and-monitoring)
    * [Business continuity and disaster recovery](#business-continuity-and-disaster-recovery)
    * [Security, governance and compliance](#security-governance-and-compliance)
    * [Platform automation and DevOps](#platform-automation-and-devops)
* [FAQ](#faq)
* [Anti-Patterns and untold stories](#anti-patterns-and-untold-stories)
* [Next Steps](#next-steps)

## Architecture overview



## Design principles

FSI Landing Zones on Microsoft Azure is grounded on key design principles that has been developed and evolved over years of experience. The design principles are:

### Subscription democratization

The design takes a key dependency on a multi-subscription environment where there is a clear separation of what is considered to be *platform* resources, and *workloads*. The platform resources are the resources that are required to run the platform, and the workloads are running in their landing zones (subscriptions where everything that must be *true* is provided by the platform side). The platform resources are typically shared across multiple workloads, and the workloads are typically unique to a specific workload.
Further, adding subscriptions is the only way to scale in Azure, it is critical to star with this separation and to avoid going back to the whiteboard to figure out next step *when* a new subscription must be introduced.

### Policy-Driven governance

Azure Policy must be used to provide guardrails and ensure continued compliance with your organization's platform, along with the applications deployed onto it. Azure Policy also provides application owners with sufficient freedom and a secure unhindered path to the cloud.

### Single control and management plane

FSI Landing Zones architecture must not consider any abstraction layers, such as customer-developed portals or tooling. It should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane (Azure Resource Manager) across all Azure resources and provisioning channels subject to role-based access and policy-driven controls. Azure can be used to establish a standardized set of policies and controls for governing the entire enterprise application estate in the cloud.

### Archetype neutral, and application centric

FSI Landing Zones architecture must focus on application-centric composition, migration, deployment and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. It must not differentiate between old and new applications, infrastructure as a service, or platform as a service applications. Ultimately, it must provide a safe and secure foundation for all application types to be deployed onto your Azure platform.

### Azure native design and aligned with platform roadmap

The FSI Landing Zones architecture advocates using Azure-native platform services and capabilities whenever possible. This approach should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help to inform the migration strategy and landing zone trajectory.

## Design areas
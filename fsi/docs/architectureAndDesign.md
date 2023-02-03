# Architecture and Design

This article goes into the details of the architecture and design of the FSI Landing Zones on Microsoft Azure, and explains key design areas and recommendations across the critical design areas for Azure as a whole that an organization within the financial services industry must consider.

## Table of contents

* [Architecture overview](#architecture-overview)
  * [Multi-subscription design](#multi-subscription-design)
  * [Multi-region design](#multi-region-design)
  * [Autonomy with governance](#autonomy-with-governance)
* [Separating platform and landing zones](#separating-platform-and-landing-zones)
  * [Platform responsibilities and functions](#platform-responsibilities-and-functions)
  * [Landing zone owners responsibilities](#landing-zone-owners-responsibilities)
* [FAQ](#faq)
* [Next Steps](#next-steps)

## Architecture overview

FSI Landing Zones on Microsoft Azure provides a scalable architecture from the very first workload to a large enterprise regardless of scale-point. The scale-out architecture is enabled by a purpose-built management group structure that caters for:

* Centralized management of the platform.
* Centralized and federated management of the landing zones, supporting N characteristics of workloads from a policy, networking, management, and security perspective.
* On-ramp path to Azure for existing workloads and applications, and net new development and exploration.
* Life-cycle management of Azure subscriptions.

The architecture is tied closely to the Policy-Driven governance design principle, which enables autonomy for the *platform*, *landing zones*, and the *workload* within the landing zones. The architecture will meet FSI customers where they are, whether it is brownfield or greenfield, and allow them to scale alongside business requirements, and is aligned with the overall platform roadmap for Microsoft Azure.

A high-level view of the management group structure is depicted in the picture below, which provides clear intentions and boundaries for the platform and landing zones.

![FSI Landing Zones management group structure](./fsimgmt.png)

The architecture is also rooted on the following principles, which are explained in more detail below:

### Multi-subscription design

FSI Landing Zones leverage a multi-subscription design where the platform and landing zones are explicitly separate from each other. A subscription is used to isolate resources, serves as a scale unit, and is a management and policy boundary. Having a multi-subscription design by default provides the following benefits:

* Rapid innovation and experimentation. Each subscription can be used to experiment with new technologies, and can be quickly deleted when no longer needed. Subscriptions can be allocated to application teams, specific workloads, or to specific environments (e.g. development, test, production).

* Governance and management at scale. Subscriptions can be managed independently, yet still be governed centrally at scale by grouping them into management groups to ensure uniform policies and standards are applied across the organization.

* Simplified cost management. Using multiple subscriptions will not incur additional costs, and can be used to isolate costs for specific workloads or environments. The consumption of the cost can be done in various ways, such as by subscription, management groups, or tags.

FSI Landing Zones provides a prescriptive guidance on how to structure the subscriptions and management groups in Azure. As a starting point, there will be 3 dedicated subscriptions for the platform purposes:

* Connectivity
This is the dedicated subscription for the initial hub virtual network in the first Azure region to be used. It will contain all centrally managed networking resources such as the hub virtual network, VPN and/or ExpressRoute gateways, Azure Private DNS Zones, etc. This subscription will be managed by the platform team, and more specifically the networking team.

* Management
A dedicated subscription is used to host the management resources that must remain separated from the workloads and landing zones, that provides an unified view with regards to security, platform observability, alerts, and remediations. It will contain a dedicated Log Analytics workspace that is tightly integrated with Microsoft Defender for Cloud, Microsoft Sentinel, and governed by Azure Policy.

* Identity
A dedicated subscription for identity purposes, such as hosting Windows Server Active Directory Domain Controllers if there is a business requirement to migrate and deploy domain joined virtual machines in the landing zones. This subscription will provide the AuthN/AuthZ for such workloads.

### Multi-region design

Alongside with a multi-subscription design, FSI Landing Zones enables you to start with a single Azure region - or as many as you want, while allowing you to scale effortless when the business requirements changes. Having a multi-region design by default provides the following benefits:

* Azure regions are designed to offer protection against localized disasters with availability zones and protection from regional or large geography disasters with disaster recovery, by making use of another region.
* By having a platform designed for multi-region support, your platform and landing zones in Azure will be protected against localized disasters with availability zones and also from regional or large geography disasters, by making use of another region.
* Besides protecting you from a disaster in an Azure region, this architecture allows you to deploy highly available, mission critical systems in an Active-Passive or Active-Active configuration where instances of your application can be deployed across 2 (or more) Azure regions.

FSI Landing Zones provides a prescriptive guidance on how to expland your Azure platform to a new Azure region (File > New > Region), which at a high-level consists of:

* Decide whether to use your existing Connectivity subscription, or create a new subscription for the networking resources in the new region. If a new subscription is created, it must be placed under the **Connectivity** Management Group.
* Deploy and configure the networking components in the new region (for example, hub virtual network, VPN and/or ExpressRoute gateways and connectivity to on-premises, Azure Firewall or 3rd party network virtual appliance, etc).
* If you are using the Identify subscription, decide whether to use your existing Identity subscription, or create a new subscription for the Active Directory Domain Services resources in the new region. If a new subscription is created, it must be placed under the **Identity** Management Group.
* Enable the new region in Azure Policy to allow deployments of Azure resources to that region.

Once you deployed your platform resources in a new region, your organization is ready to create landing zones in the new region.

### Autonomy with governance

Azure Policy is a key enabler for FSI Landing Zones to provide autonomy for the platform, landing zones, and workloads within the landing zones. The policy-driven governance model is based on the following principle of **proactive vs reactive**.

Using policy effects such as *deny* and *deployIfNotExists* reduces the effort required to enforce compliance at scale as your Azure footprint grows, regardless of amount of subscriptions and workloads. It also helps the application teams by being transparent on the guardrails in place, and to foster greater technical intensity as part of the Azure journey and overall adoption.

## Separating platform and landing zones

One of the key tenets of FSI Landing Zones architecture is to have a clear separation of the Azure *platform* and the *landing zones*. This allows organizations to scale their Azure architecture alongside with their business requirements, while providing autonomy to their application teams for deploying, migrating and doing net-new development of their workloads into their landing zones. This model fully supports workload autonomy and distinguish between central and federated functions.

Architecturally, the separation is achieved by having dedicated management group for the platform, and dedicated management group for the different types of landing zones - such as corp connected workloads, and online workloads which drives different set of requirements for networking, security, governance and compliance.

![Separation](./separation.png)

By having the separation at this level, FSI organizations can scale out both the platform and the landing zones independently and without having to revisit the whiteboard to understand what must be done *when* a new subscription is being introduced, and the intent of that subscription.

### Platform responsibilities and functions

Platform resource are managed by a cross-functional platform team. The team consist mainly out of the following functions. These functions working in close collaboration with the SME functions across the organization:

* PlatformOps: Responsible for management and deployment of control plane resource types such as subscriptions, management groups via IaC and the respective CI/CD pipelines. Management of the platform related identify identity resources on Azure AD and cost management for the platform.
 Operationalization of the Platform for an organization is under the responsibility of the platform function.

* SecOps: Responsible for definition and management of Azure Policy and RBAC permissions on the platform for landing zones and platform management groups and subscriptions. Security operations including monitoring and the definition and the operation of reporting and auditing dashboard.
* NetOps: Definition and management of the common networking components in Azure including the connectivity via ExpressRoute and/or VPN, firewall resources to control internet facing networking traffic or ensuring DNS name resoultion across the environment. NetOps team is responsible to handout virtual networks to landing zone owners or teams.

### Landing zone owners responsibilities

FSI Landing Zones reference implementation enables landing zones supporting a both centralized and federated application DevOps models. Most common model are dedicated **DevOps** team aligned with a single workload. In case of smaller workloads or COTS or third-party application a single **AppDevOps** team is responsible for workload operation. Independent of the model every DevOps team manages several workload staging environments (DEV, UAT, PROD) deployed to individual landing zones/subscriptions. Each landing zone has a set of RBAC permissions managed with Azure AD PIM provided by the Platform SecOps team.

When the landing zones/subscriptions are handed over to the DevOps team, the team is end-to-end responsible for the workload. They can independently operate within the security guardrails provided by the platform team. If dependency on central teams or functions are discovered, it is highly recommended to review the process and eliminate as soon as possible to unblock DevOps teams.

## FAQ

Q. What is the difference between a landing zone and a subscription?

A. The subscription is the scale-unit, management boundary, and isolation boundary. The landing zone is a *definition* when everything that must be **true** in order for workload deployments to commence into the subscription, is provided by the platform team, such as shared networking capabilities, identity and access management, governance, and security.

Q. Can we start with a single subscription, and later add a new subscription?

A. Trust us - you do not want to start with a single subscription. In the scenario where you combine both *platform* resources and *application* resources in a single subscription, and then later adds a new subscription, you are up for a tedious exercise to move or/and redeploy resources which will cause interruption. Further, it violates known best practices and design principles for overall landing zones. Lastly, there's no additional cost associated with the subscriptions themselves, hence it will not cost more for the subscriptions, just that the resource composition and distribution is better aligned for scale.

## Next Steps

Deploy the FSI Landing Zones on Microsoft Azure reference implementation. Explore the user guide and the deployment experience by following the links below:

| Reference Implementation | Description | Deploy | Documentation
|:----------------------|:------------|--------|--------------|
| FSI Landing Zones | FSI Landing Zones foundation that provides a full, rich, compliant architecture with scale-out pattern for secure-by default regions and landing zones, with a robust and customizable service enablement framework to accelerate adoption of Azure service and enables digital transformation |[![Deploy To Microsoft Cloud](../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/fsilz) | [User Guide](./referenceImplementation/readme.md)

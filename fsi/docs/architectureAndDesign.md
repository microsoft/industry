# Architecture and Design

This article goes into the details of the architecture and design of the FSI Landing Zones on Microsoft Azure, and explains key design areas and recommendations across the critical design areas for Azure as a whole that an organization within the financial services industry must consider.

## Table of contents

* [Architecture overview](#overview)
    * [Multi-subscription design](#multi-subscription-design)
    * [Multi-region design](#multi-region-design)
    * [Autonomy and governance](#autonomy-and-governance)
* [Separating platform and landing zones](#separating-platform-and-landing-zones)
    * [Platform responsibilities and functions](#platform-responsibilities-and-functions)
    * [Landing zone owners responsibilities](#landing-zone-owners-responsibilities)
    * [FAQ](#faq)
* [Anti-Patterns and untold stories](#anti-patterns-and-untold-stories)
* [Next Steps](#next-steps)

## Architecture overview



## Design principles

FSI Landing Zones on Microsoft Azure is grounded on key design principles that has been developed and evolved over years of experience. The design principles are:

## Separating platform and landing zones

One of the key tenets of FSI Landing Zones architecture is to have a clear separation of the Azure *platform* and the *landing zones*. This allows organizations to scale their Azure architecture alongside with their business requirements, while providing autonomy to their application teams for deploying, migrating and doing net-new development of their workloads into their landing zones. This model fully supports workload autonomy and distinguish between central and federated functions.

## Platform responsibilities and functions

Platform resource are managed by a cross-functional platform team. The team consist mainly out of the following functions. These functions working in close collaboration with the SME functions across the organization:

- PlatformOps: Responsible for management and deployment of control plane resource types such as subscriptions, management groups via IaC and the respective CI/CD pipelines. Management of the platform related identify identity resources on Azure AD and cost management for the platform.
 Operationalization of the Platform for an organization is under the responsibility of the platform function.

- SecOps: Responsible for definition and management of Azure Policy and RBAC permissions on the platform for landing zones and platform management groups and subscriptions. Security operations including monitoring and the definition and the operation of reporting and auditing dashboard.
- NetOps: Definition and management of the common networking components in Azure including the hybrid connectivity and firewall resource to control internet facing networking traffic. NetOps team is responsible to handout virtual networks to landing zone owners or team.

## Landing zone owners responsibilities

FSI Landing Zones reference implementation enables landing zones supporting a both centralized and federated application DevOps models. Most common model are dedicated **DevOps** team aligned with a single workload. In case of smaller workloads or COTS or third-party application a single **AppDevOps** team is responsible for workload operation. Independent of the model every DevOps team manages several workload staging environments (DEV, UAT, PROD) deployed to individual landing zones/subscriptions. Each landing zone has a set of RBAC permissions managed with Azure AD PIM provided by the Platform SecOps team.

When the landing zones/subscriptions are handed over to the DevOps team, the team is end-to-end responsible for the workload. They can independently operate within the security guardrails provided by the platform team. If dependency on central teams or functions are discovered, it is highly recommended to review the process and eliminate as soon as possible to unblock DevOps teams.
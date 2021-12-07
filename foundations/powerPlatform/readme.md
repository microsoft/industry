# North Star Architecture for Power Platform

North Star is an architectural approach and a reference implementation. It enables effective construction and operationalization of landing zones (environments) on Power Platform, at scale. This approach aligns with the platform and product roadmap and the Center of Excellence adoption framework.

Specifically for Microsoft Cloud for Industries (e.g., Healthcare, Financial Services), Microsoft Power Platform is an essential platform for the overall industry solutions, and this prescriptive guidance aims to provide you with best practices and recommendations across the critical design areas for Power Platform to host and integrate the various industry applications.

| Reference implementation | Description | Deploy |
|:----------------------|:------------|--------|
| North Star Architecture for Power Platform | Power Platform environments with DLP, logging, and security enabled for scalable industry solutions |[![Deploy To Microsoft Cloud](../../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2FhealthcareArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2Fhealthcare-portal.json)

## Architecture overview

North Star architecture for Power Platform represents the strategic design path and target technical state for an organizations Power Platform enviornment. It continues to evolve alongside the Power roadmap. Various design decisions define the architecture that your organization must make to map your Power Platform journey.

### High-level architecture

A North Star architecture includes a set of design considerations and recommendations across the [critical design areas](#critical-design-areas-for-power-platform) for Power Platform. It is modular by design and allows you to start with a foundational architecture that enables construction and operationalization of landing zones (Environments) that supports your business application portfolios, for both pro developers and citizen developers. The architecture will scale regardless your organization scale-point and business requirements.

Figure 1 depicts the high-level architecture of North Star architecture for Power Platform

![power platform architecture](./images/architecture.png)

### Landing zone in North Star architecture for Power Platform

A landing zone (environment) is where professional developers and citizen developers can confidently develop and run their business applications, that accounts for:

* Scale
* Security
* Governance
* Interoperability and extensibility

The landing zones consider all platform capabilities and resources that are necessary to support the organization's business application portfolio.

Figure 2 shows the landing zone (environment) in Power Platform.

![landing zone for power platform](./images/landingzone.png)

## Design Principles

The North Star architecture is based on the design principles described in this section. These principles serve as a compass for subsequent design decisions across critical technical domains. Readers are strongly advised to familiarize themselves with these principles to better understand their impact and the trade-offs associated with non-adherence.

### Environment Democratization

Environments are used as a unit of management, scale, and policy boundary, aligned with business needs and priorities, to support business areas and developers to accelerate digital transformation

### Policy Driven Governance

Data-loss prevention (DLP) policies are used to provide the guard-rails and ensure the continued compliance of the customer platform and applications created onto it, whilst also providing developers sufficient freedom and a secure unhindered path to cloud

### Single Control and Management Plane

The North Star architecture does not use any abstraction layers such as custom developed portals or tooling and ensures a consistent experience for both Platform admins and developers, subject to role-based access controls and policy-driven controls by DLP

### Persona Agnostic

The North Star architecture is Persona agnostic, and does not treat them differently from an architecture and capability perspective, and provides a safe and secure foundation for all developer personas an organization may have

### Power Platform Native Design and Platform Roadmap Alignment

The North Star architecture approach advocates using Power Platform native services and capabilities whenever possible. This approach aligns with the product roadmap to ensure that new capabilities are available within your environments. The Power Platform roadmap helps to inform the adoption strategy and North Star trajectory.

### Recommendations

* Be prepared to trade off functionality as not everything will likely be required on day one.
* Leverage preview services and take dependencies on roadmap in order to remove technical blockers.

## Critical design areas for Power Platform

Together with the design principles, the core of North Star architecture for Power Platform also contains a critical design path comprised of fundamental design areas with heavily interrelated and dependent design decisions. This repository provides design guidance across these architecturally significant technical domains to support the critical design decisions that must occur to define the North Star architecture. For each of the key design areas listed below, review the considerations and recommendations provided and use them to structure and drive design decisions within each area.

* [Licensing and AD tenants](#licensing-and-ad-tenants)
* [Identity and access management](#identity-and-access-management)
* [Security, governance, and compliance](#security-governance-and-compliance)
* [Environments](#environments)
* [Management and monitoring](#management-and-monitoring)
* [Business continuity and Disaster recovery](#business-continuity-and-disaster-recovery)
* [Azure VNet connectivity for Power Platform](#azure-vnet-connectivity-for-power-platform)
* [Platform Automation and DevOps](#platform-automation-and-devops)

## Licensing and AD Tenants

Organizations can obtain licenses by either licensing Microsoft Power Apps or Microsoft Power Automate specifically or by it being included in the license of another Microsoft cloud service offering. For example, both Microsoft 365 and Dynamics 365 provide entitlements for Power Apps and Power Automate. As with most Microsoft licensing, you can mix and match for users as appropriate, giving some additional entitlements. Further, any users in an organization can sign up for a Power App trial, unless explicitly blocked by the organization.
### Design considerations

* Licensing is the first control-gate to allowing access to Power Platform components.
* Licenses are tied to the tenant and the assigned Azure AD users/groups.
* Power Platform provides different licensing constructs, as well as capacity add-ons and requires some planning in advance
* D365 Trials are one-in-a-lifetime per Azure AD tenant
* Pay As You Go (PAYG) is a low-risk entry to Premium functionality in Power Platform
### Design recommendations

* Avoid creating multiple Azure AD tenants
* Dev/test/prod environments can be isolated and controlled natively in the Power Platform, without needing separation at the identity control plane (AD tenant). For secure usage of connectors related to Microsoft Graph - such as Office 365, Sharepoint etc., ensure a well-defined RBAC model is implemented to meet the security and data classification requirements.
* Use the pay-as-you-go plan for apps that need to be shared with a large user base with infrequent and/or unpredictable use
* Use an Azure Subscription for Power Apps to reduce license procurement overhead and consolidate with other service purchases
## Identity and access management

Identity and access to the Power Platform, the environments, the applications, components, and solutions within the environments must be carefully thought through in parallel with assigned licenses.
Furthermore, for data, security in Dataverse is there to ensure users can do their work with the least amount of friction, while still protecting the data and services. Security in Dataverse can be implemented as a simple security model with broad access all the way to highly complex security models where users have specific record and field level access.

### Design considerations

* Ability to create applications and flows is controlled by security roles in the context of an environment.
* Environments act as a security boundary, allowing different security requirements to be implemented in each environment.
* The security and RBAC model for Environments with - and without Dataverse are different.
* Environments with Dataverse support more advanced security models to control access to data and services within the Dataverse environment.
* A user's ability to see and use apps is controlled by sharing the application with the user.
  * Sharing of canvas apps is done directly with a user or Azure AD group but is still subject to Dataverse security roles.
  * Sharing of model-driven apps is done via Dataverse security roles.
* If an Environment is first created without Dataverse and it gets added later, the Dataverse roles will take over for controlling security in the Environment and all environment admins and makers are automatically migrated.

### Design recommendations

* Create AAD groups that are automatically assigned the correct licenses per user per their requirements and roles, and avoid assigning licenses to individual users.
* Organize the AAD groups that streamline and simplify RBAC for the environments per the functions and requirements for the business units and application teams.
* Use Conditional Access Policies in Azure AD to grant/prevent access to Power Apps and Power Automate based upon user/group, device, and location.
* Include mapping of security groups to Environments where Dataverse is enabled as part of the Environment creation process.

## Security, governance, and compliance

An environment in Power Platform is an allow-by default system from a policy perspective, and for the Healthcare solutions and applications, one must use Data-Loss Prevention policies to explicitly categorize and enable/disable connecters for business use cases. This will help to mitigate risk for data exfiltration, and help to stay secure and compliant.

### Design considerations

* A policy can be scoped to include the entire tenant, multiple environments, as well as exclude multiple environments.
* You can create data loss prevention (DLP) policies that can act as guardrails to help prevent users from unintentionally exposing organizational data.
* DLP policies can be scoped at the environment or tenant level, offering flexibility to craft sensible policies that strike the right balance between protection and productivity.
* Connectors can be grouped into business, non-business, and blocked. Once categorized, they cannot be used in conjunction with other connectors outside its group. When a connector is blocked, it cannot be used at all.
* Environment admins cannot edit policies created by tenant admins.
* Tenant isolation for Power Platform can be applied at the connector level and is used to prevent connectors using Azure AD based authentication to other tenants, and supports both one-way (inbound) or two-way (inbound and outbound) restriction. Enabling tenant isolation requires raising a support ticket in the Power Platform admin center.

### Design recommendations

* Create a data loss prevention policy that enforces the bare minimum security requirements at the tenant scope, to ensure that all landing zones are secure by-default and both pro devs and citizen devs can safely develop business applications that do not violate the security requirements.
* The tenant wide policy spanning all environments should prevent all unsupported non-Microsoft connectors, and classify all Microsoft connectors as 'Business data'.
* Create a policy for the default environment that furter restricts which Microsoft connectors are classified as 'Business Data'.
* Establish a process that will always include data-loss prevention policy when creating a new landing zone (environment), to ensure no one are accessing - or starting to create or deploy apps could potentially violate the policies.

## Environments

Environments acts as the scale-unit, and management boundary in Power platform and is where organizations can store, manage, and share business data, applications, including Dynamics 365 apps, chatbots, and flows. It's recommended to have a strategy for how you should create, distribute, and scale environments to accelerate digital transformation for your pro - and citizen developers.
The following section describes the design considerations and the design recommendations for Environments, to help you navigate to the correct setup per your organizational requirements.

![Environments for Healthcare](./images/env.png)

### Design considerations

* An environment must be pinned to a location (abstraction of Azure regions), and is determined during creation by the maker/admin, and cannot be changed post creation.
* Environments are defined out of the box to serve different audiences and purposes like dev, test, production, and personal exploration/development. Depending on what type of environment that is created, it will determine what you can do with the environment as well as the apps within.
* Each tenant has a default environment and it is created in the region closest to the default region of the Azure AD tenant.
* Data Loss Prevention (DLP) policies can be applied to individual environments or the tenant root ("/") level.
* Non-default environments can be created by licensed Power Apps, Power Automate and Dynamics users. Creation can be restricted to only global and service admins via a tenant setting.
* An environment can have one or zero database (Dataverse) instances.
* Environments act as security boundaries allowing different security needs to be implemented in each environment.
* Environments can be created with - or without Dynamics 365 application templates available in the tenant.
* Dynamics 365 applications takes a dependency on environments with Dataverse provisioned.

### Design recommendations

* Treat environments as a democratized unit of management aligned with business needs and priorities, and use the following principles when identifying requirements for new environments:
  * Scale limits. Environments serve as scale unit for components/apps/database to scale within the platform limits
  * Management boundary: Environments provide a management boundary for governance and isolation, which allows for a clear separation of concerns. For example, different environments such as dev, test, and production are often isolated from a management perspective
  * Policy boundary: Environments serve as a boundary for the assignment of Data Loss Prevention (DLP) policies. For example, apps that are subject to regulatory compliance such as PCI and HITRUST typically require additional DLP policy enforcmenet to achieve compliance
* Rename the Default environment to clarify the intent, e.g., "personal productivity" as all licensed users will have access by default.
* Disable self-service of Environment creation, both for Production and Sandbox as well as Trials, and limit this to selected Power Platform admins as this can potentially cause [capacity constraints](https://docs.microsoft.com/power-platform/admin/capacity-add-on) in the tenant.
* Enable a process for the organization to request new environments aligned to the principles above. Either establish and implement the process yourself or leverage the [Center of Excellence starter kit](https://docs.microsoft.com/power-platform/guidance/coe/starter-kit) as an enabler and starting point which provides a solution that can be imported to a dedicated environment to facilitate this, together with other core capabilities.
* As part of the Environment creation process, ensure auditing, DLP policies, and RBAC are included so the environments can be used safely.
* Have dedicated environments (dev, test, and prod) for administrative purposes for the Power Platform itself, including management, monitoring, and analytics. These environments should be managed and operated by the Power Platform admins, in order to safely operate and scale the distribution of landing zones (environments) to business units and application teams within the organization.
* Create dedicated environments for app teams/business units such as test, development, and production in the same region, which allows ease of maintenance and validation of changes, such as release wave updates which is per environment.
* The production and development environments for production targeted apps must be of type "production", while test environments could be of type "sandbox" to simplify reset process for testing purposes.
* Limit high privilege access by using an Azure AD Security Group with PIM for admin access to the environments.
* Manage the correct number of environments in the tenant to avoid sprawl and conserve capacity.
* Enable auditing for your tenant and environments to understand usage and available capacity.
* For industry solutions (e.g., Healthcare, Financial Services Industry), deploy all Dynamics 365 applications to the same environment(s), and avoid creating islands of data that will be complex to combine later.
* Only split Industry solutions across different environments if there are data or security constraints.

## Management and Monitoring

Power Platform provides first-party connectors for the Power Platform administration capabilities so organizations can configure and implement the desired management scenarios and automation needed for their tenant and environments. The [Center of Excellence starter-kit](https://docs.microsoft.com/power-platform/guidance/coe/core-components) provides ready to use solutions that enables curated management experiences in addition to what the Power Platform admin center enables by default.
Further overall management, including observability and auditing is crucial to ensure a continiously healthy tenant and environments, the the usage of the various applications deployed in the environments, as well as the Dataverse platform. Additional integration and end-to-end view will rely on Microsoft 365 Security and Compliance Center, and Azure Active Directory. For most of the services in Power Platform, organizations who are using Azure can integrate with Azure Monitor (Application Insights and Log Analytics) for long-term retention and further analysis.

### Design considerations

* Only Environments with Dataverse provide auditing capabilities (access logs) at the environment and database layer, and the logs can be viewed and consumed from Office 365 Security & Compliance center
* Auditing for Environments with Dataverse is set to off by default and cannot be enabled on Environments during provisioning. To enable auditing, you must explicitly opt-in within the Environment settings once it has been created.
* Power Platform admin center provides out-of-the box analytics capabilities of the various Power Platform components, such as Dataverse, Power Apps, and Power Automate
* The Power Platform admins can configure Data export for all Power Apps in the tenant, and export to an Azure Data Lake Storage (Gen2) account to get an overview of the adoption, usage, inventory, and application metadata.
* For each environment with Dataverse, the Power Platform admins can export Dataverse diagnostics, such as usage of APIs, form load diagnostics, and performance metrics to an Azure Application Insights instance.
* Activity logs for Power Apps is integrated with Office 365 Security & Compliance center which provides an API to query the data.
* Power Platform provides connectors specifically for management scenarios so organizations can build on top of existing capabilities provided natively in the platform.

### Design recommendations

* Use Application Insights that is linked to a Log Analytics workspace in Azure to capture key diagnostics and performance metrics for all environments using Dataverse and enable critical alerts for the respective Power Platform admins and environments owners.
* If separation of concern is important, configure Data Export to Application Insights on behalf of the application teams/owners, so they can monitor the diagnostics and performance for their own dedicated environments.
* Use Azure Data Lake Storage (Gen2) account to store and analyze Power App usage for the tenant, for durations as required by your organization's data retention policies and use Power BI to build informative reports for the various stakeholders for the Power Platform.
* Enable tenant-level analytics for aggregated view of usage across the Power Platform components.
* Use Center of Excellence starter kit as a starting point to add core management scenarios for the platform management in dedicated "admin" environments managed centrally.

## Business Continuity and Disaster Recovery

Protecting your data in Power Platform is primarily at the Environment level, and allows you to protect data in customer engagement apps (Dynamics 365 Sales, Dynamics 365 Customer Service, Dynamics 365 Field Service, Dynamics 365 Marketing, and Dynamics 365 Project Service Automation), and providing continuous availability of service are important. You have multiple options for backing up and restoring your environments.

### Design considerations

* Monitor the M365 message center for planned service interruptions which will identify the date and time of the service maintenance.
* Unplanned service interruptions result in a notice that the organization is currently undergoing unplanned maintenance
* Backup and restore can be done per Environment.
* Power Platform performs system backups, and:
 * Depending on the amount of copied and restored audit data, copy and restore operations can take up to 8 hours.
 * All your environments, except Trial environments (standard and subscription-based), are backed up.
 * System backups occur continuously. The underlying technology used is Azure SQL Database. See SQL Database documentation Automated backups for details.
 * System backups for production environments that have been created with a database and have one or more Dynamics 365 applications installed are retained up to 28 days. * System backups for production environments which don't have Dynamics 365 applications deployed in them will be retained for 7 days. System backups for sandbox environments will be retained for 7 days.
* You must restore an environment to the same region in which it was backed up.
* When an environment is restored onto itself, audit logs aren't deleted. For example, when an environment is restored onto itself to a past time t1, full audit data for the environment will be available, including any audit logs that were generated after t1.
* Admins of an Environment can also do manual backups:
 * A backup is created for you when we update your environment.
 * You can back up production and sandbox environments.
 * You can't back up the default environment.
 * Sandbox backups are retained for up to 7 days.
 * Manual backups for production environments that have been created with a database and have one or more Dynamics 365 applications installed are retained up to 28 days. 
 * Manual backups for production environments which do not have Dynamics 365 applications deployed in them will be retained for 7 days.
 * You are not limited in the number of manual backups you can make.
 * Manual backups do not count against your storage limits.
 * You must restore an environment to the same region in which it was backed up.

### Design recommendations

* Use Power Automate to create alerts for planned service interruptions that are created into - and managed within dedicated admin environments.
* Establish well-defined processes to manage unplanned services interruptions integrated into the application/IT operations support.
* Make the environment owners aware of their responsibility, to facilitate manual backups as needed per their requirements and lifecycle management.
## Azure VNet connectivity for Power Platform

The Power Platform provides different mechanism to allow connectivity to Azure data services. This section will provide prescriptive design considerations and recommendations to help you implement the right connectivity model from the Power Platform to an Azure VNet.

### Design considerations

* The Power Platform provides two types of data gateways:
  * On-premises data gateway
  * VNet data gateway (currently in public preview)
* On-premises data gateway is designed to provide secure data transfers between on-premises data and Microsoft clouds services.
* VNet data gateway is designed to allow connections from Power Platform Cloud services (Power BI Datasets and Power Platform Dataflows) to Azure data services.

![VNet data gateway](./images/vnet-data-gw.png)

* Customers must install and manage the host/virtual machine where the on-premises data gateway is deployed. With the VNet data gateway no installation is required because it's a Microsoft managed service.
* VNet data gateway is well suited to complex scenarios in which multiple people access multiple data sources.
* When using the VNet data gateway, there is no need of using an on-premises data gateway.
* A Power BI Premium license (Power BI Premium workspaces and Premium Per User (PPU)) is required to make use of the VNet data gateway.
* Be sure to familiarize with VNet data gateway [limitations](https://docs.microsoft.com/data-integration/vnet/overview#limitations) as well as [supported Azure data services](https://docs.microsoft.com/data-integration/vnet/use-data-gateways-sources-power-bi#supported-azure-data-services).
### Design recommendations

* Use a VNet data gateway to access data from cloud services in the data platform to Azure data services.
  * This feature is still in public preview, hence may not be suitable for production scenarios.
* Deploy the VNet data gateway in the [hub virtual network](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/traditional-azure-networking-topology) on the [Azure Landing Zones](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) platform. This will provide connectivity to Azure data services located in Azure Landing Zones.
* Use on-premises data gateway if you cannot deploy preview services in your Azure environment, or you need to securely access data assets stored outside Azure.
* When using on-premises data gateways:
  * Do not install it in personal mode. The personal mode only allows access for a single user and is therefore not suited for large-scale solutions.
  * To avoid single point of failure, at least two Data Gateways should be installed to [create a cluster](https://docs.microsoft.com/data-integration/gateway/service-gateway-install#add-another-gateway-to-create-a-cluster).
  * To distribute load across the nodes of a cluster, cluster admins should enable the setting to [distribute requests across all active gateways](https://docs.microsoft.com/data-integration/gateway/service-gateway-high-availability-clusters#load-balance-across-gateways-in-a-cluster). To further enhance the load distribution, admins should [setup resource thresholds on the nodes of a cluster](https://docs.microsoft.com/data-integration/gateway/service-gateway-high-availability-clusters#load-balance-based-on-cpu-and-memory-throttling).
  * Updates to on-premises data gateway should be installed regularly by following these [guidelines](https://docs.microsoft.com/data-integration/gateway/service-gateway-update).
  * When installing the on-premises data gateway, [choose the datacenter region](https://docs.microsoft.com/data-integration/gateway/service-gateway-data-region) that is closest to the data.
  * [Enforce HTTPS communication](https://docs.microsoft.com/data-integration/gateway/service-gateway-communication#force-https-communication-with-azure-service-bus) for the on-premises data gateways and make sure that [TLS 1.2 is used](https://docs.microsoft.com/data-integration/gateway/service-gateway-communication#tls-12-for-gateway-traffic) for gateway traffic.

## Platform Automation and DevOps

Most organizations starting with the cloud does not have an operating model that is compatible, and will very likely undergo a degree of operational and organization transformation to deliver on the principle of cloud computing and digital transformation enablement. As it relates to Power Platform it is highly recommended that a DevOps approach is being employed for both the central IT team responsible for the Power Platform, as well as the professional developers teams.

### Design considerations

* Where central teams are concerned, you should use pipelines for continuous integration and deployment. Use pipelines to manage environment life-cycle, including DLP, security groups, RBAC, and auditing from a compliance perspective.
* The blanket application of a DevOps model won’t instantly establish capable DevOps teams
* Investing in engineering capabilities and resources is critical to ensure sustainable engineering and development of the platform alongside with the roadmap

### Design recommendations

* Establish a cross functional DevOps Platform Team to build, manage and maintain the North Star Architecture of Power Platform, including functions to support Environment provisioning with DLP, Security Groups, RBAC, and Auditing.
* This team should include members from your central IT, security, compliance, and business units teams to ensure a wide spectrum of your enterprise is represented. The list below presents a recommended set of DevOps roles for the central Platform Team.
 * PlatformOps (Platform Operations) to:
  * Manage Environment provisioning and delegation of required, IAM, and Data-Loss Prevention policies.
  * Platform management and monitoring (holistic).
  * Cost Management (holistic).
  * "Platform as Code" (management of templates, scripts and other assets).
  * Responsible for overall operations on Power Platform within the Azure AD tenant, such as managing service principles, Graph API registration, and role definitions.
 * SecOps (Security Operations)
  * Role based access control (holistic).
  * Key management (for central services).
  * Policy management and enforcement (holistic).
  * Security monitoring and audit (holistic).
 * NetOps (Network Operations)
  * Network Management (holistic).
* Allow application owners to create and manage application resources through a DevOps model.
* In some instances, customers may wish to break AppDevOps into more granular roles such as AppDataOps for database management like traditional DBA roles, or AppSecOps where more security sensitive applications are concerned; this is to be expected.
* Leverage a policy-driven approach with clear RBAC boundaries to centrally enforce consistency and security across application teams.
* To accelerate adoption, the central platform function should establish and provide common set of guidance, templates, and libraries within the organization
* Don’t restrict developers (both pro and citizen) to use central artifacts or approaches because it hinders their agility
 * This includes enforcing the use of specific tooling for development and IaC, either directly or indirectly
 * You can enforce consistent baseline configuration through policy driven governance (DLP)

 ---

[Back to documentation root](../../README.md)
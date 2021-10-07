# Power Platform for Healthcare

Microsoft Power Platform is an essential component of the overall Healthcare solutions for Microsoft clouds, and this prescriptive guidance aim to provide you with best practices and recommendations across the critical design areas for Power Platform to host and integrate the various Healthcare applications.

| Reference implementation | Description | Deploy |
|:----------------------|:------------|--------|
| Power Platform for Healthcare | Power Platform environments with DLP, logging, and security enabled for Healthcare solutions |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2FhealthcareArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2Fhealthcare-portal.json)

## Environments

Healthcare applications requires an environment in Power Platform, that must be created and governed upfront and in a supported region for Healthcare.
The following section describes the design considerations and the design recommendations for Environments, to help you navigate to the correct setup per your organizational requirements.

![Environments for Healthcare](./images/env.png)

### Design considerations

* An environment must be pinned to a location (abstraction of Azure regions), and is determined during creation by the maker/admin, and cannot be changed post creation.
* Environments are defined out of the box to serve different audiences and purposes like dev, test, production, and personal exploration/development. Depending on what type of environment that is created, it will determine what you can do with the environment as well as the apps within.
* Each tenant has a default environment and it is created in the region closest to the default region of the Azure AD tenant
* Environments can be used to target different audiences and/or for different purposes such as dev,
test and production
* Data Loss Prevention (DLP) policies can be applied to individual environments or the tenant root ("/") level
* Non-default environments can be created by licensed Power Apps, Power Automate and
Dynamics users. Creation can be restricted to only global and service admins via a tenant setting
* An environment can have one or zero database (Dataverse) instances
* Environments act as security boundaries allowing different security needs to be implemented in each environment

### Design recommendations

* Rename the Default environment to clarify the intent, e.g., "personal productivity"
* Create dedicated environments for test, development, and production for the Healthcare solutions, which allows ease of maintenance and validation of changes, such as release wave updates which is per environment
* Create the dedicated environments for Healthcare in the same region
* The production environment for Healthcare must be of type "production", while test and development environments should be of type "sandbox"
* Limit high privilege access by using an AAD Security Group with PIM for admin access to the environments
* Create DLP policies to limit data flow between trusted MSFT connectors and 3rd party APIs, aligned with your organizational requirements
* Manage the correct number of environments in the tenant to avoid sprawl and conserve capacity
* Limit creation of production and sandbox environments to only specific administrators
* Allow users to create trial environments via self-service for exploration and development

To do: End to end architecture reference

## Identity and access

Identity and access to the Power Platform, the environments, and the applications, components, and solutions within the environments must be carefully thought through in parallel with assigned licenses.
Further, for data, security in Dataverse is there to ensure users can do the work they need to do with the least amount of friction, while still protecting the data and services. Security in Dataverse can be implemented as a simple security model with broad access all the way to highly complex security models where users have specific record and field level access.
### Design considerations

* Licensing is the first control-gate to allowing access to Power Platform components
* Ability to create applications and flows is controlled by security roles in the context of an environment
* Environments act as a security boundary, allowing different security requirements to be implemented in each environment
* The security and RBAC model for Environments with - and without Dataverse are different
* Environments with Dataverse supports more advanced security models to control access to data and services within the Dataverse environment
### Design recommendations

* Create AAD groups that are automatically assigned the correct licenses per user per their requirements and roles, and avoid assigning licenses to individual users
## Data-Loss Prevention (governance)

An environment in Power Platform is an allow-by default system from a policy perspective, and for the Healthcare solutions and applications, one must use Data-Loss Prevention policies to explicitly categorize and enable/disable connecters for business use cases. This will help to mitigate risk for data exfiltration, and help to stay secure and compliant.
### Design considerations

* A policy can be scoped to include the entire tenant, multiple environments, as well as exclude multiple environments

* You can create data loss prevention (DLP) policies that can act as guardrails to help prevent users from unintentionally exposing organizational data.
* DLP policies can be scoped at the environment level or tenant level, offering flexibility to craft sensible policies that strike the right balance between protection and productivity.
* Connectors can be grouped into business, non-business, and blocked. Once categorized, it cannot be used in conjunction with other connectors outside its group. When a connector is blocked, it cannot be used at all.
* Environment admins cannot edit policies created by tenant admins
### Design recommendations

## Data

### Design considerations

### Design recommendations
## Observability and logging

### Design considerations

### Design recommendations

* Enable tenant-level analytics for aggregated view of usage across the Power Platform components

## Azure VNet connectivity for Power Platform

For compliance and security reasons, many cutomers require a multi-layered security approach to restrict access to resources. One of the most relevant layers in the security models of our customers is the network connectivity. In this section we will look at the different available options that can be used to limit network traffic between Azure and Power Platform. The section will also include a recommendations to help you selecting the right solution for your scenario.

### Option 1: On-premises Data Gateway

In the past, the default option for accessing network secured data assets in Power Platform was the on-premises Data Gateway. The setup requires customers to [install the gateway application onto a Virtual Machine](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-install). Today, there are new capabilities available for data assets stored within Azure. Having said this, for network secured data assets stored outside of Azure, the on-premises Data Gateway is still the recommended solution for customers. This includes data assets stored on-premises or in other public clouds.

#### Design Considerations

* The Data Gateway should **not** be installed in personal mode to allow more than one user to connect to data assets within the environment. The personal mode only allows access for a single user and is therefore not suited for large-scale solutions.
* To avoid single point of failure, at least two Data Gateways should be installed to [create a cluster](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-install#add-another-gateway-to-create-a-cluster). Settings do not have to be synched across the individual nodes of a cluster. This is automatically done between the instances.
* To distribute load across the nodes of a cluster, cluster admins should enable the setting to [distribute requests across all active gateways](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-high-availability-clusters#load-balance-across-gateways-in-a-cluster). To further enhance the load distribution, admins should [setup resource thresholds on the nodes of a cluster](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-high-availability-clusters#load-balance-based-on-cpu-and-memory-throttling).
* The Data Gateway is receiving updates once per month. Updates should be installed regularly by [following these guidelines](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-update).
* When installing the Data Gateway, [choose the datacenter region](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-data-region) that is closest to the data.
* Enforce HTTPS communication for the on-premises Data Gateways by [following these steps](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-communication#force-https-communication-with-azure-service-bus) and make sure that TLS 1.2 is used for network connectivity as [described here](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-communication#tls-12-for-gateway-traffic).

### Option 2: Virtual Network Data Gateways

To reduce the management effort for customers and to simplify the secure access of Azure data assets from Power Platform, customer can now rely on virtual network Data Gateways instead of on-premises Data Gateways. The benefit of this solution is that customers are no longer required to setup and manage virtual machines or have to worry about updating the host or Data Gateway itself. The virtual network Data Gateway feature uses a delegated subnet to securely inject a container onto the vnet over which connections to data services and assets are established. The steps required by customers to set this up can be found [here](https://docs.microsoft.com/en-us/data-integration/vnet/create-data-gateways). In summary, the virtual network Data Gateway is the recommended solution for customers to access network secured data assets stored within Azure.

#### Desig Considerations

* The feature is still in public preview and hence the solution is not recommended for production scenarios.
* Today, a Power BI Premium license (Power BI Premium workspaces and Premium Per User (PPU)) is required to make use of this feature.
* Before adopting the virtual network Data Gateway, we advise you to [evaluate the current limitations of the service](https://docs.microsoft.com/en-us/data-integration/vnet/overview#limitations) and the [supported Azure data services](https://docs.microsoft.com/en-us/data-integration/vnet/use-data-gateways-sources-power-bi#supported-azure-data-services).

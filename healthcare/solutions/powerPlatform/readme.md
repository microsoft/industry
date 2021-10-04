# Power Platform for Healthcare

Microsoft Power Platform is an essential component of the overall Healthcare solutions for Microsoft clouds, and this prescriptive guidance aim to provide you with best practices and recommendations across the critical design areas for Power Platform to host and integrate the various Healthcare applications.

## Environments

Healthcare applications requires an environment in Power Platform, that must be created and governed upfront and in a supported region for Healthcare. 
The following section describes the design considerations and the design recommendations for Environments, to help you navigate to the correct setup per your organizational requirements.

### Design considerations

* An environment must be pinned to a location (abstraction of Azure regions), and is determined during creation by the maker/admin, and cannot be changed post creation.
* Environments are defined out of the box to serve different audiences and purposes like dev, test, production, and personal exploration/development. Depending on what type of environment that is created, it will determine what you can do with the environment as well as the apps within.
* Each tenant has its own default environment where individuals can freely make their own apps
* Environments can be used to target different audiences and/or for different purposes such as dev, 
test and production
* Data Loss Prevention (DLP) policies can be applied to individual environments or the tenant root ("/") level
* Every tenant has a Default environment where all licensed Power Apps and Power Automate users 
can create apps & flows
* Non-default environments can be created by licensed Power Apps, Power Automate and 
Dynamics users. Creation can be restricted to only global and service admins via a tenant setting
* An environment can have one or zero database (Dataverse) instances

### Design recommendations

* Rename the Default environment to clarify the intent, e.g., "personal productivity"
* Create dedicated environments for test, development, and production for the Healthcare solutions, which allows ease of maintenance and validation of changes, such as release wave updates which is per environment
* Create the dedicated environments for Healthcare in the same region
* The production environment for Healthcare must be of type "production", while test and development environments should be of type "sandbox"
* Limit high privilige access by using an AAD Security Group with PIM for admin access to the environments
* Create DLP policies to limit data flow between trusted MSFT connectors and 3rd party APIs, aligned with your organizational requirements
* Manage the correct number of environments in the tenant to avoid sprawl and conserve capacity
* Limit creation of production and sandbox environments to only specific administrators
* Allow users to create trial environments via self-service for exploration and development

To do: End to end architecture reference

## Data-Loss Prevention (governance)

To ensure that your applications that are deployed, customized, and developed as part of the Healthcare solutions in Power Platform environments are secured and compliant, and also mitigate risk for data exfiltration, Data-Loss Prevention (DLP) policies should be used to determine the connectors availalbe for the environments.
### Design considerations

### Design recommendations
## Observability and logging

### Design considerations

### Design recommendations

* Enable tenant-level analytics for aggregated view of usage across the Power Platform components

## Azure VNet connectivity for Power Platform
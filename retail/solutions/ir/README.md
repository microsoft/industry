# Personalized recommendations with Intelligent Recommendations

## Table of Contents

- [Personalized recommendations with Intelligent Recommendations](#personalized-recommendations-with-intelligent-recommendations)
  - [Table of Contents](#table-of-contents)
  - [Intelligent Recommendations](#intelligent-recommendations)
    - [Capabilities](#capabilities)
    - [Architecture](#architecture)
    - [Terminology](#terminology)
    - [Integration points for IR](#integration-points-for-ir)
    - [Service flow](#service-flow)
    - [FAQ](#faq)
  - [Considerations and Recommended Practices](#considerations-and-recommended-practices)
  - [Deployment guide](#deployment-guide)
  - [Automated Deployment](#automated-deployment)

## Intelligent Recommendations

[Intelligent Recommendations](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/overview) democratizes AI and machine learning recommendations through a codeless and powerful experience powered by the same technology that fuels Xbox, Microsoft 365, and Microsoft Azure. Businesses can now provide relevant discovery for customers with this new, innovative AI for personalization and recommendations.

Intelligent Recommendations IR) is one of the features included in Microsoft Cloud for Retail. While Microsoft Cloud for Retail is in Public Preview, Intelligent Recommendations is now generally available. Whilst the service as a standalone offering is new, the algorithm behind the service has been in use for a few years as part of Dynamics Commerce.

### Capabilities

The IR service uses input datasets and configuration parameters to determine the type of [recommendation scenarios](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/overview). These are:

- Personalized recommendations for end users
- Similar items
- Real-time and session-based recommendations for users
- Basket completion

### Architecture

![ir detailed](./media/ir_detailed_process_flow.png)

### Terminology

- `Cooking process` is the backend process of reading; processing and modelling data according to business needs.
- `User interactions` are the interactions between users and items that Intelligent Recommendations models learn from and use to predict future interactions. Examples of user interactions include click streams, purchases etc. The data is stored in CSV format and shipped to IR as an input.

### Integration points for IR

IR is a scalable headless service and it has two key integration points:

1. ADLS Gen2 storage for storing input datasets and making them available for IR for processing.
2. Frontend APIs where the recommendations (or output) are made available for consumption via applications.

### Service flow

The recommendations process can be broken down into three key steps:

1. Read input datasets (user interactions such as purchase, downloads, views etc.) and configuration from an ADLS Storage Account. IR requires a specific data model and base configuration to build recommendations.These are defined as part of `model.json` file.
2. "Cooking process" is the backend process managed by IR service where datasets (user interactions) are read from ADLS and processed by IR service.
3. Data serving part where the results are made available to the customer through a set of published APIs.

![IR process flow](./media/ir_process_flow.png)

### FAQ

- Does IR support Private Endpoints?

    No. It's meant to be accessible over public internet. One of the use cases is to be able to integrate with eCommerce SaaS platforms such as Shopify, BigCommerce etc.

- Can users choose ML/AI models?

    IR is a PaaS and all model management related tasks are managed by Microsoft. As a result, customers do not have visibility of what model(s) were used to generate a set of recommendations. However, end users can fine-tune the results through [Flexible Filtering](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/fine-tune-results#flexible-filtering) and [Top candidates for recommendation lists](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/fine-tune-results#show-top-candidates-for-recommendations-lists).

- Monitoring the `cooking process`?

    At the time of writing this document, IR does not have APIs or Azure Monitor integration. However, based on internal benchnarks, cooking process could take up to ~72 hours. There is no SLA in place as this service is still under preview.

- Availability of IR and data residency?

    At a bare minimum, IR deployment requires an instance of IR service and an ADLS account where `user interactions` and `model.json` are stored.

    ADLS keeps the data in the region where ADLS service is instantiated. If IR and ADLS share the same region, then data stays within the region. However, if the Data Lake Storage account and modelling resources are in different regions, data will be copied from the Data Lake Storage region to the modelling resource region that you selected. As of Jan 2022, Intelligent Recommendations is available in West US and West Europe (WEU).

    Customers can choose region of modelling resources at the time of creating a `Model Instance`. Once IR instance has been created, under click on (A) Modelling blade and then (B) `Create`. Customers can then choose the region from dropdown list.
    ![Choosing modelling region](./media/choosing_modelling_region.png)

- How to select supported scenarios/models which are computed by IR?
    Customers can choose the feature set to model at the time of creating a Modelling instance. In IR, type of scenarios one can model are tied to tier of Modelling instance one chooses to create.
    ![IR features](./media/ir_features.png)

    `Basic` tier includes modeling of:

        - People also buy
        - Frequently bought together
        - New
        - Trending
        - Best Selling

    `Standard` tier includes modeling scenaros under `Basic` plus:

        - Picks for you (personalization)

    `Premium` tier includes modeling scenarios under `Standard` plus:

        - Similar look (Visual similarity)
        - Similar description (NLP similarity)

- What format is supported for `user interactions` files?

    `User interactions` must be in CSV format. The definition of CSV files is available under [Data Contracts](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/data-contract).

- Does IR support delta for input datasets?

    No. The IR service cannot calculate delta for input datasets. When a dataset is provided to IR for processing, it will process all the records in the input file(s) and then generate a set of recommendations based on that data.

    One option to reduce operational overhead is to extract delta from the source using an ETL tool, however from IR perspective, it expects a full dataset each time to build a set of recommendations.

- Does IR have an availability SLA?

    IR is in preview and currently does not have an availability SLA in place. However, this will be in place when service goes GA.

## Considerations and Recommended Practices

The reference implementation of IR builds upon [Azure Data Management and Analytics (DMA) - Data Product Analytics](https://github.com/Azure/data-product-analytics#data-management--analytics-scenario---data-product-analytics).

![dma-ir](./media/dma_ir_placement.png)

An enterprise-scale deployment of IR will consist of multiple instances of Modelling and Service Endpoints. This must be complemented with ADLS (to store incoming data) and ADF (to move data between various source systems and ADLS). Whilst an ADLS account is mandatory for deployment of IR, ADF is optional, however a similar product/service capable of implementing data pipelines must be implemented. As such, DMA Data Product Analytics scenario offers a good starting point for such deployment.

> Note: Adoption and implementation of DMA is not mandatory for deploying IR and its complimentary services, however DMA architecture and recommendations have been built for at-scale deployment encompassing principles of security, governance and self-serve. Hence, we are using DMA as for reference implementation.

***One or multiple IR and ADLS instances?***

From a deployment perspective, we recommend having separate instances of IR and ADLS for each environment (production, dev, test). Having separate environments will allow you to experiment and optimize the recommendations without risking any downtime or impact to production environment.

There maybe reasons where you may instantiate more than one instance in an environment for reasons related to:

- Scale
- Billing and governance
- Security and/or compliance
- Co-location of resources

**Azure billing and Azure Active Directory tenant**  
There are no IR specific deployment recommendations from EA and Billing perspective; however, we recommend customers to review the considerations and follow the recommendations for ESLZ available [here](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-ad-tenant).

**Identity and Access Management**

IR supports AAD and Azure RBAC. For an enterprise deployment, we recommend having separate instances of IR for each environment (production, development etc.). Within each instance of IR, you may choose to use one or more instances of ADLS, Modeling Instance (MI) and/or Service Endpoint (SE).

There are 2 principles which apply here:

- Principle of least privilege
- Segregation of duties

There are two types of access planes - control plane and data plane.

For **control plane** access, we recommend leveraging Azure RBAC. The control plane strategy outlined below applies to IR and it's dependent services.

For each instance of ADLS, MI and SE, following AAD groups must be created and then users, Managed Identities or Service Principals must be added to these groups. The rationale behind this is that each application which consumes data from IR will most likely have different lifecycle; security requirements; possibly different teams involved etc. Having separate user groups aligned per application per environment will enable you to administer and treat each dependent application differently.

- mi_\<app>\_\<env>\_readers
- se_\<app>\_\<env>\_readers
- adls_\<app>\_\<env>\_\<app>\_readers
- mi_\<app>\_\<env>\_\<region>\_\<app>\_writers
- se_\<app>\_\<env>\_\<region>\_\<app>\_writers
- adls_\<app>\_\<env>\_\<region>\_\<app>\_writers
- mi_\<app>\_\<env>\_\<region>\_\<app>\_admins
- se_\<app>\_\<env>\_\<region>\_\<app>\_admins
- adls_\<app>\_\<env>\_\<region>\_\<app>\_admins  

For Azure RBAC, unless you have specific security and access control requirements, we recommend using built-in roles for readers, writers and admins.

For automation, we recommend using AAD Managed Identity (MI) and assigning them appropriate Azure RBAC to for operational tasks. It's common to use multiple MI to control the blast radius and assign MI to each individual instance of IR.

For **data plane** access, we have apps which consume data from IR using Service Endpoints. This is enabled by `Endpoint Authentication` feature of IR which is configured at IR Account level. It is backed by Azure AD (AAD).

The figure below shows the hierarchy of an IR account and the access flow from external application perspective. External applications (A) will use AAD-backed identity to get an access token from Azure Identity Platform. The access token is then used to access the Service Endpoints (D) and Modeling Resources (E).

Endpoint Authentication basically binds an AAD SPN to an IR Account for data plane access. Even though we recommend using separate AAD-backed SPN for each external application accessing IR Account, it's worth highlighting that once Endpoint Authentication is configured for a given SPN, it can perform GET and POST actions on all of the Service Endpoints and Modeling Resources belonging to that IR Account.

![Endpoint Authentication](./media/ir_authc_access_apps.png)

The default behaviour of Endpoint Authentication assignment belonging to an IR account is that the assigned user, by default, gets read access to all Modeling and Service API endpoints as shown in the figure above. There is no feature to change this behaviour.

> Note: It's not possible to modify this assignment through Azure RBAC as this binding is done at the backend.

There are a few strategies to address the risk associated with access to all endpoints belonging to an IR Account:

- Instantiate a separate IR Account per external application. Basically, you adopt the model where there is 1:1 mapping between an external app (consumer) and an IR Account.
- 



---

- **DevOps and Automation**

    As with other Azure services, we recommend using IaC approach to deploying and managing IR Account and its complementary services such as ADLS.

    > Note: At the time of writing this document, IR doesn't ship with Bicep support, however this will be available in future.

    > Note: IR, just like any other Azure-based resource, supports ARM however, at the time of writing of this documentation, the `Export template` experience from Azure Portal is not supported.

    ***Model Management and MLOps***

    MLOps is a relatively new trend and it is targeted at data scientists similar to what DevOps does for developers and engineers. This section highlights key areas of MLOps and how they apply to Intelligent Recommendations (IR).

    > Note: A key thing to remember here is that IR is a PaaS which means that a large surface area associated with general technical operations and model management are obfuscated from end-users. As a result, some aspects of MLOps do not apply to IR.

  - **Source Control** The code behind models used for recommendations is not accessible to end-users or customers. However, customers can experiment by modifiying data entities and their attributes defined in `model.json` file. The changes committed to `model.json` can be tracked via version control such as Azure DevOps Repo or GitHub.

  - Following aspects of MLOps are managed by Microsoft.
    - Training pipeline
    - Model packaging
    - Model validation
    - Model deployment
    - Model training

  ***Release Management***

  This section focus on release management in context of Intelligent Recommendations service. IR offers following levers to fine tune results and experiment with the recommendations:

  - [Flexible filtering](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/fine-tune-results)
  - [Data Contracts and entities defined in](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/data-contract#data-contracts) `model.json`

  > Note: We are not focusing on release management in context of applications which are consuming output of IR as there is plenty of documentation out in public domain which talks to those themes.

  There are fundamental building blocks and capabilities which enable various release management strategies such as Canary; Blue-Green deployments; and A/B testing. These are:
  - Ability of an IR account to support multiple Modeling resources and Service Endpoints.
  - DevOps tooling such as Azure DevOps (ADO) and its features Pipelines and Repos.
  - Runtime environment such as AKS along with networking capabilities which supports balancing traffic between multiple application endpoints.

  > Note: In addition to parameters in `model.json`, customers can also experiment with different types of Modeling Endpoints (Basic, Standard or Premium) and adopt deployment strategies discussed below.
  
  ![Modeling Tiers](./media/modeling_endpoint_tiers.png)

  Using the setup depicted in the figure shown below, customers can build and deploy complex release strategies.
  
  An application (shown as F) has > 1 instances hosted on a runtime environment (H) which supports layer 7 load balancing. Each application instance is connecting to two separate Service Endpoints (D and E). The overarching idea is that each Service Endpoint is using different Modeling Reource each of which is driven by parameters declared in `model.json` files (C). Driving the recommendations are datasets hosted inside two separate Azure storage containers (A).

  ![deployment strategy](./media/deployment_strategy.png)

  Customers can experiment with input datasets and variables defined in `model.json` to fine tune the recommendations. This IR deployment model combined with capabilities of application runtime environment such as AKS (H) enables customers to implement release management strategies such as Canary; Blue-Green deployments; and A/B Testing.

  > Note: IR supports multiple endpoints, however one would require external capabilities such as network load balancing (such as Azure Application Gateway) and application runtime environment to enable end-to-end release management scenarios discussed here.

- **Network Topology and Connectivity**

    At the time of writing this guidance, IR didn't support Azure Private Endpoints. The APIs published by IR for Modeling Resources and Service Endpoints are routable over the public internet, however a key is required to access them which provides another layer of security.

    To secure the deployment and to keep the surface area of services with addresses routable over the public internet to a minimum, there are a few strategies available.
  - ADLS account must have Private Endpoint enabled so that it's not accessible over the internet.
  - Separate Azure Storage account which is accessible by
  - Separate containers per external app will ensure that the blast radius is restricted to a container in case of a breach.

- **Operations and Monitoring**

    At the time of writing of this guidance, IR doesn't ship with observability feature to track progress of its `Cooking Process` or how APIs are responding to user requests from external systems. At the moment, `Cooking process`, depending on size of data inputs, the cooking process can take up to 72 hours.

    As with other Azure services, we recommend Activity Logs for IR to a Log Analytics Workspace (LA Workspace).

    IR generates logging report and error reports which are written back to the ADLS account configured for use with the Modeling instance. THe logs are generated in JSON and currently no turnkey feature exists to integrate them with Azure Monitor. To address this, we recommend piping the logs through Log Analytics Agent v1.1.0-217+. The details are captured [here](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/data-sources-json).

    For all other services such as ADLS, ADF etc. we recommend enabling collection of Activity Logs and Diagnostic Logs which can be enabled by implementing Azure Policy.

- **Security**
  
   This guidance assumes that the source systems and data stores which support Private Endpoints have this (PE) feature enabled. This guidance focuses on threat surface area associated with the resources and services have a publicily routable IP address. This includes -

  1. ADLS account used by IR for storing files.
  2. IR account
  3. Modeling endpoint
  4. Service endpoint

    ***ADLS***

    In context of IR, ADLS is used to store input data files and log files generated by IR. In line with security and privacy principles, none of the input files should contain any PII or payment card data.

    > **Note:** For building a set of recommendations, IR **does not** require any PII or payment data. Please refer to [Data Contract Reference](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/data-contract#interactions) for details of attributes and fields required to drive various types of recommendations. Based on the input datasets, an organisation can carry out analysis and determine the risk to their deployment.

    Security recommendations for Azure Storage have been published [here](https://docs.microsoft.com/en-us/azure/storage/blobs/security-recommendations). From networking perspective, Private Endpoints are not supported so Azure Storage must have a public endpoint. To lockdown the access, [grant access to trusted Azure services](https://docs.microsoft.com/en-us/azure/storage/common/storage-network-security?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal#grant-access-to-trusted-azure-services).

    > **Note:** Network access is one layer of security. Authentication and Azure RBAC provides another layer of security to protect against malicious actors.

    We also recomomend enabling [Network Routing preference for Azure Storage](https://docs.microsoft.com/en-us/azure/storage/common/network-routing-preference?toc=/azure/storage/blobs/toc.json). This feature ensures that traffic from the internet is routed to the public endpoint of your storage account over the Microsoft global network. Azure Storage provides additional options for configuring how traffic is routed to your storage account.

    At a bare minimum, we recommend using separate ADLS accounts for each environment with separate containers per app. To further reduce the blast radius and risks associated with exfiltration of data, we recommend a dedicated Storage Account for use with IR which only houses datasets required for Intelligent Recommendations.

    You may also want to consider multiple ADLS accounts for a single IR account for the following reasons:

  - Scale - there are scale limits associated with each storage account. Perhaps you might want to scale beyond limits supported by a single instance.
  - Regulatory - region of deployment is determined by a Storage Account and a customer may have regulatory or data residency requirements.
  - Domain alignment - if your organisation is structured around domains, then you may choose to have domain-aligned storage accounts. This also provides a boundary between different teams.
  - Security - having separate Storage Accounts can help you spread the risk across multiple accounts.
  
   ***IR Account***

  An IR account is an instance of service and provides control plane for deploying and configuring Modeling and Service endpoints. An IR account itself doesn't doesn't handle data per se. Instances of Modeling and Service endpoints belonging to an IR account handle the actual data. From threat surface area perspective, IR account can be modified via one of the following Azure Portal, CLI or SDK by a malicious actor. Hence, Azure RBAC must be configured to control access to IR account.

  - Each environment must have separate IR accounts. This is allow for separation between environments and give flexibility around implementing different RBAC across environments.
  - You may also consider separate IR accounts from `Endpoint Authentication` perspective. `Endpoint Authentication` is the authentication mechanism which allows external applications and users to connect to Service Endpoints attached to an IR account. By design, once an `application ID` is granted access to IR Account, it inherits read access to all of the Service and Modelling Endpoints associated with that IR.
  - You may also consider deploying multiple IR acconts if your application has different CORS requirements. Similar to `Endpoint Authentication`, CORS configuration is tied to an instance of IR account and thus, all endpoints belonging to an IR account inherit CORS configuration.
  
  ***Modeling Endpoint***

  As discussed earlier, data plane access to Modeling Endpoint is configured at IR Account level through `Endpoint Authentication` parameter.
  - Access to the control plane for a Modeling Endpoint is configured by Azure RBAC.
  - Access to the data plane for a Modeling Endpoint is configured via Endpoint Authentication configured at IR account level.
  - We recommend organisations to review the input datasets which IR relies upon for building recommendations and then assign an appropriate security risk rating to an IR deployment.
  - An external application interacts with Modeling Endpoint via a set of [REST APIs](https://docs.microsoft.com/en-us/rest/api/industry/intelligent-recommendations/). As such, security risks associated with REST APIs must be considered for Modeling Endpoints. Here are the top risks and a brief commentary on how these are addressed:
  
    - Support for HTTPS: These are enabled by default and cannot be disabled. All API calls take place over HTTPS.

    - Rate limiting and throttling: A `Modeling Endpoint` exposes API which allows customers to resubmit jobs. The API can only be called once every 24 hours.
  
    - Unprotected identity and keys: An external app an interact with a Modeling Endpoint using AAD backed app identity. As a best practice, we recommend storing the secret in Azure Key Vault which an application can access at runtime.

    - Unencrypted payload: The interaction and data exchange between ADLS and Modeling Endpoint takes place over Microsoft's network backbone using HTTPS protocol.

    - Weak API keys: As highlighed earlier, AAD backed app ID and secret to call the Modeling Endpoint APIs.

    - Injection: APIs validate inputs from the applications to reduce risk associated with injection vectors.

  ***Service Endpoints***
  
  The Service Endpoint (SE) supports the APIs which are referenced by applications to fetch recommendations generated by IR. The same set of risks highlighted for Modeling Endpoint apply to SE REST APIs. There are a few differences which are called out here:

  - To ensure QoS, Service Endpoints an instance is instantiated with a pre-allocated capacity which controls maximum transactions-per-second allowed for a given endpoint.

  - In a scenario where a single IR account has multiple Modeling and Service Endpoints, it's worth noting that the applications granted access to the endpoints through `Endpoint Authentication` feature, have read access to all the APIs belonging to all Modeling and Service Endpoints belonging to an IR account.

## Deployment guide

For reference implementation of Azure Intelligent Recommendation (IR), we recommend leveraging Azure Data Management and Analytics scenario guidance. IR is an ML service and it requires other complementary services such as Azure Data Factory (for data movement) and Azure Data Lake Storage (for storage). Rationale being that it relies heavily on complementary services such as ADLS (for storage) and Azure Data Factory (for pipelines).

## Automated Deployment

*Coming soon*

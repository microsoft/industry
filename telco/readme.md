# Azure for Telecomunnications

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Azure for Telecommunications | Azure for Telco foundation that provides a full, rich, compliant architecture with scale-out pattern for connectivity and landing zones for Telco industry scenarios |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2FreferenceImplementation%2FtelcoArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2FreferenceImplementation%2Ftelco-portal.json)
| Scale-out Hub virtual network | When the Azure for Telco foundation is in place, you can use this reference implementation to scale-out the hub virtual network for Telco industry, and configure the corresponding networking infrastructure |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2solutions%2FtelcoNetworking%2FtelcoNwArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2Fsolutions%2FtelcoNetworking%2FtelcoNw-portal.json)

Due to the network centric nature of their business, customers in the Telecommunications (or Telco) industry have a unique set of requirements compared other organizations of similar scale. Such requirements include:

* Delivery of strenuous networking services that consume large amounts of bandwidth and are sensitive to latency and jitter on the network (ex. VOIP or video streaming).
* Provide networking and end user services to consumers (ex. firewall as a service, cloud storage, cloud email, etc).
* Provide managed services to other companies (ex. SD-WAN solutions, SoC or SBC).
* Leverage the provider’s distributed edges to deliver services closer to where their end users are for better performance and lower latency (ex. 5G, gaming or augmented reality).

This article provides a reference architecture with prescriptive guidance and recommendations for the Telco industry across the Microsoft Cloud (Power Platform, Dynamics, Microsoft 365 and Microsoft Azure).

## Azure for Telecommunications Industry Reference Architecture

This article describes the Azure for Telecommunications (Telco) industry reference architecture which enables the delivery of Telco specialized workloads on Microsoft Azure and at the edge.

### High-level architecture

The Azure for Telco industry reference architecture is based on a [proven, at scale Azure architecture](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) foundation for the construction and operationalization of landing zones in Azure.  Our guidance for Telcos provides a specific set of recommendations to accommodate Telco industry requirements and scenarios as described previously on this article. The Azure for Telco reference architecture is depicted on figure 1 below:

![Azure for Telco industry reference architecture](./docs/telco-industry-reference-architecture.png)
_Figure 1:Azure for telco industry reference architecture._

As figure 1 depicts, the Azure for Telco industry follows the design principles and recommendations of proven, compliant, and scalable architecture, but it provides specific guidance and recommendations in the following areas to accommodate for the typical requirements of Telcos:

![The letter A](./docs/a.png) [Governance for Telco Industry Scenarios](./docs/telco-governance.md). To cater for scalability for Telco industry specific scenarios in landing zones, the Azure for Telco industry reference architecture recommends the creation a new Management Group dedicated to Telco industry specific applications and services. Azure policies that are designed to govern and manage those applications can be assigned to ensure Telco applications are compliant, and configured with high-availability as default at this scope and subscriptions dedicated for such applications would need to be deployed under this management group.

![The letter B](./docs/b.png) [Networking for Telco Industry Scenarios](./docs/telco-networking.md). While the networking design considerations and recommendations described in the [Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) are mostly compatible with the Azure for Telco reference architecture, our guidance diverges from the Cloud Adoption Framework when it comes to addressing the Telco specific requirements, as outlined in the introduction above.  Most of these changes focus on how to provide more scalable, flexible connectivity for carrier-grade workloads by using a modified network topology and ExpressRoute connectivity.

![The letter C](./docs/c.png) [Distributed Edge](./docs/telco-edge.md). The Azure for Telco industry reference implementation provides prescriptive guidance to leverage the Telco’s distributed edge infrastructure to provide Azure services at the edge via [Azure Stack Edge](https://docs.microsoft.com/azure/databox-online/) and [Azure private multi-access edge compute (MEC)](https://docs.microsoft.com/azure/private-multi-access-edge-compute-mec/overview), which among other benefits provides a low-latency experience to users, as services are provided directly at the edge instead of having to provide the services from the Azure region.

### Next Steps
The following articles will provide detailed design considerations and recommendations for Telco Industry Scenarios key design areas.

* [Governance for Telco Industry Scenarios](./docs/telco-governance.md)
* [Networking for Telco Industry Scenarios](./docs/telco-networking.md)
* [Distributed Edge](./docs/telco-edge.md)

---

[Back to documentation root](../)
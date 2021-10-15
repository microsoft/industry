# Telecommunications Industry Reference Architecture

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Microsoft Cloud for Telco Industry | Cloud Foundation that spans across Azure, Power Platform, and Microsoft 365 for Telco industry and workloads |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2Fri%2FtelcoArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2Fri%2Ftelco-portal.json)
| Scale-out Hub virtual network | When the Cloud Foundation is in place, you can use this reference implementation to scale-out the hub virtual network for Telco industry, and configure all networking infrastructure |[![Deploy To Microsoft Cloud](../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2solutions%2FtelcoNetworking%2FtelcoNwArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2Fsolutions%2FtelcoNetworking%2FtelcoNw-portal.json)

Due to the network centric nature of their business, customers in the Telecommunications (or Telco) industry have a unique set of requirements compared other organizations of similar scale. Such requirements include:

* Delivery of strenuous networking services that consume large amounts of bandwidth and are sensitive to latency and jitter on the network (ex. VOIP or video streaming).
* Provide networking and end-user services to consumers (ex. firewall as a service, cloud storage, cloud email, etc).
* Provide managed services to other companies (ex. managed SD-WAN solution, managed SoC).
* Leverage the provider’s distributed edges to provide services closer to where their end users are for better performance and lower latency (ex. 5G, gaming or augmented reality).

This article provides a reference architecture with prescriptive guidance and recommendations for the Telco industry across the Microsoft Cloud (Power Platform, Dynamics, Microsoft 365 and Microsoft Azure).

## Telco Industry Reference Architecture on Microsoft Azure

This article describes Telco industry reference architecture on Microsoft Azure which enables the delivery of Telco specialized workloads on Microsoft Azure and at the edge.

### High-level architecture

The Telco industry reference architecture on Microsoft Azure is based on an [Enterprise-Scale Landing Zone](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) foundation for the construction and operationalization of landing zones at scale in Azure.  Our guidacne for Telcos provides a specific set of recommendations to accommodate Telco industry requirements and scenarios as described previously on this article. The reference architecture for Telco industry on Microsoft Azure is depicted on figure 1 below:

![Telco industry reference architecture](./docs/telco-industry-reference-architecture.png)
_Figure 1: Reference architecture for the telco industry on Microsoft Azure._

As figure 1 depicts, the reference architecture for the Telco industry on Microsoft Azure follows the design principles and recommendations of Enterprise-Scale Landing Zones, but it provides specific guidance and recommendations in the following areas to accommodate for the typical requirements of Telcos:

* Telco workloads (depicted as C in figure 1).
* Networking (Depicted as E in figure 1).
* Telco distributed edge (Depicted as G in figure 1).

The following sections will provide a high-level overview of the considerations for each of those areas, and subsequent articles will provide detailed design considerations and recommendations.

### Telco workloads

Many applications - especially those providing traditional internal IT services - can be deployed, managed and governed in Azure using existing Enterprise Scale guidance. However, some applications, such as those that provide managed services to end customers (B2C), or businesses (B2B) might require a set of controls and governance that are different from the internal line-of-business (LOB) applications. These applications typically provide services such as Core CP, vIMS, vHSS, Thin/uCPE, SDWAN, vFW, vRouter, vLTM, CGNAT, vBNG, DDI and vRadius among others.

For example, B2B and B2C telco applications may require deploying their own ExpressRoute Gateways so they can use dedicated ExpressRoute circuits for data plane traffic, while other dedicated circuits can provide connectivity to on-premises network for control plane traffic. Another example would be applications that require public IPs in their Landing Zones.

Given these specialized requirements which might conflict with existing policy controls for internal LOB applications, the reference architecture for the Microsoft Cloud for Telco industry recommends the creation a new Management Group dedicated to Telco industry specific applications and services. Azure policies that are designed to govern and manage those applications can be assigned at this scope and subscriptions dedicated for such applications would need to be deployed under this management group. This new management group is depicted in figure 2 below:

![Management workloads](./docs/management-group-telco.png)
_Figure 2: Management group for business to business and business to customer applications._

### Networking

The reference architecture for Microsoft Cloud for Telco industry users Enterprise-Scale Landing Zones to provide the foundational networking and connectivity services for deploying applications and services in Microsoft Azure at scale.

The Network topology and connectivity design considerations and recommendations provided by Enterprise-Scale Landing Zones are mostly compatible with the Microsoft Cloud for Telco industry reference architecture. For example, guidance around access to Azure PaaS services via Private Link, or the usage of hub and spoke or VWAN network topologies are fully compatible with the Telco reference architecture.

Our guidance diverges from Enterprise Scale when it comes to addressing the Telco specific requirements, as outlined in the introduction above.  Most of these changes focus on how to provide more scalable, flexible connectivity using a modified network topology and ExpressRoute connectivity.

This added complexity is due to most companies in the Telco industry having multiple interconnected on-premises or other private networks (such as an MPLS) they depend on to provide B2B and B2C services for their customers. Many Telco customers also have an heavily segmented on-premises network that is highly isolated across multiple Virtual Routing and Forwarding (VRFs). This network isolation across VRFs is depicted in figure 3 below with some common VRFs found across customers in the Telco industry (such as core network, signaling or media):

![Telco on-prem network](./docs/telco-onprem.png)
_Figure 3 – On-premises network with isolation across multiple example VRFs_

With the design outlined above Telcos with strong network isolation requirements have a network topology that can keep such network isolation from on-premises to Azure where needed.Our reference architecture outlined above provides design considerations and recommendations to ensure isolation is maintained either by using IPSec tunnels or with multiple ExpressRoute circuits and a network topology with multiple hub virtual networks and multi-homed spoke VNets.  This isdepicted in figure 4 below.

Other customers may be fine with consolidating multiple VRFs over a single (or a small set of) ExpressRoute circuit(s). In this scenario, a network topology based on hub and spoke architecture or Azure Virtual WAN as recommended in Enterprise-Scale landing zones would be sufficient without the added complexity.

![Figure 4: Dual-homed VNet](./docs/dual-homed-topology-expressroute.png)

_Figure 4: Dual-homed virtual network with Azure Route Server and ExpressRoute_

---
***NOTE***

While figure 4 depicts a dual-homed network architecture with Azure Route Server and third party appliances, a similar network architecture can be implemented with Azure Firewall and User Defined Routes (UDR).

---

### Operator distributed edge

Telcos operate a distributed edge network to provide services (such as Radio Access Networks (RAN) or Wi-Fi) closer to where their customers are. The Microsoft Cloud for Telco industry reference implementation provides prescriptive guidance to leverage the Telco’s distributed edge infrastructure to provide Azure services at the edge via [Azure Stack Edge](https://docs.microsoft.com/en-us/azure/databox-online/) and [Azure private multi-access edge compute (MEC)](https://docs.microsoft.com/en-us/azure/private-multi-access-edge-compute-mec/overview), which among other benefits provides a low-latency experience to users, as services are provided directly at the edge instead of having to provide the services from the Azure region. Such services typically include 5G, CDN, gaming or augmented/virtual reality. This is depicted in figure 5 below.

![Figure 5: Distributed edge](./docs/telco-industry-edge.png)
_Figure 5: Operators distributed edge_

## Dynamics 365

Coming soon.

## Power Platform

Coming soon

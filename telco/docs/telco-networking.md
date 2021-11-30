# Networking for Telco Industry Scenarios

The Azure for Telco industry reference architecture provides the foundational networking and connectivity services for deploying applications and services in Microsoft Azure at scale.

The Network topology and connectivity design considerations and recommendations described in the [Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) are mostly compatible with the Azure for Telco reference architecture. For example, guidance around access to Azure PaaS services via Private Link, or the usage of hub and spoke or VWAN network topologies are fully compatible with the Azure for Telco reference architecture.

Our guidance diverges from the Cloud Adoption Framework when it comes to addressing the Telco specific requirements, as outlined in the introduction above.  Most of these changes focus on how to provide more scalable, flexible connectivity using a modified network topology and ExpressRoute connectivity.

This added complexity is due to most companies in the Telco industry having multiple interconnected on-premises or other private networks (such as an MPLS) they depend on to provide B2B and B2C services for their customers. Many Telco customers also have an heavily segmented on-premises network that is highly isolated across multiple Virtual Routing and Forwarding (VRFs). This network isolation across VRFs is depicted in figure 3 below with some common VRFs found across customers in the Telco industry (such as core network, signaling or media):

![Telco on-prem network](./telco-onprem.png)
_Figure 3 – On-premises network with isolation across multiple example VRFs_

With the design outlined above, Telcos with strong network isolation requirements have a network topology that can keep such network isolation from on-premises to Azure where needed. Our reference architecture outlined above provides design considerations and recommendations to ensure isolation is maintained either by using an overlay (such as IPSec tunnels) or with multiple ExpressRoute circuits and a network topology with multiple hub virtual networks and multi-homed spoke VNets.  This is depicted in figure 4 below.

Other customers may be fine with consolidating multiple VRFs over a single (or a small set of) ExpressRoute circuit(s). In this scenario, a network topology based on hub and spoke architecture or Azure Virtual WAN as recommended in Cloud Adoption Framework would be sufficient without the added complexity.

![Figure 4: Dual-homed VNet](./dual-homed-topology-expressroute.png)

_Figure 4: Dual-homed virtual network with Azure Route Server and ExpressRoute_

---
***NOTE***

While figure 4 depicts a dual-homed network architecture with Azure Route Server and third party appliances, a similar network architecture can be implemented with Azure Firewall and User Defined Routes (UDR).

---

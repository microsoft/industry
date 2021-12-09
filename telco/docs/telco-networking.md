# Networking for Telco Industry Scenarios

The Azure for Telco industry reference architecture provides the foundational networking and connectivity services for deploying telco applications and services in Microsoft Azure at scale.

The Network topology and connectivity design considerations and recommendations described in the [Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) are mostly compatible with the Azure for Telco reference architecture. For example, guidance around access to Azure PaaS services via Private Link, or the usage of hub and spoke or VWAN network topologies are fully compatible with the Azure for Telco reference architecture.

Our guidance diverges from the Cloud Adoption Framework when it comes to addressing the Telco specific requirements, as outlined in the introduction above. Most of these changes focus on how to provide more scalable, flexible connectivity using a modified network topology and ExpressRoute connectivity.

This added complexity is due to most companies in the Telco industry having multiple interconnected on-premises or other private networks (such as an MPLS) they depend on to provide B2B and B2C services for their customers. It is not uncommon for customers in the telco industry to have an heavily segmented on-premises network that is highly isolated across multiple Virtual Routing and Forwarding (VRFs). Such on-premises networks have a high level of isolation across multiple VRFs for scenarios such as overlapping IP address space, workload isolation, avoid network contention across services among others. Typical VRFs seen in the Telco industry include:
- Access
- Core
- Operations and Management
- Media
- Signaling
- Internet  

Many telco workloads in on-premises network require communication across two or more of such VRFs, and would require similar isolation when such applications are migrated to or deployed as net-new applications in Azure. Azure provides a flat layer-3 network, and hence does not offer a native solution to extend VRFs into virtual networks. However, it is possible to use any of the following approaches by using native Azure technologies:
- Map a VRF to an ExpressRoute circuit.
- Map VRFs by using multiple IPSec tunnels
- As an alternative, customers can use a network overlay (such as VXLAN) over ExpressRoute Private Peering to map on-premises VRF isolation to the Azure VNet.

It is typically recommended to evaluate whether is possible to consolidate multiple VRFs over a single (or a small set of) ExpressRoute circuit(s). In this way, a network topology based on hub and spoke architecture or Azure Virtual WAN as recommended in Cloud Adoption Framework would be sufficient without the added complexity. If is not possible to consolidate multiple VRFs into a single (or a small set of) ExpressRoute circuit(s), evaluate which of the following alternatives would be suitable for your environment to connect multiple on-premises VRFs to Azure:

## Multiple ExpressRoute Circuits

### Design Considerations

- Consider the following ExpressRoute limits when designing for a solution involving multiple ExpressRoute circuits:
  - Up to 4 ExpressRoute connections into the same ExpressRoute Gateway when then connections are provisioned from the same peering location.
  - For Azure VWAN, up to 8 ExpressRoute connections into the same VHub when then connections are provisioned from different peering locations.
  - For hub and spoke, up to 16 ExpressRoute connections into the same VHub when then connections are provisioned from different peering locations.
- Azure Virtual WAN allows the creation of multiple VHubs in the same region within the same VWAN resource. As Azure VWAN VHubs are fully meshed, VMs in Azure VWAN can communicate to on-premises networks through any of their VHUBs.
- In hub andd spoke networks, spoke VNets are typically connected to one hub VNet, but it is possible to connect a spoke VNet to two or more hub VNets via VNet peering. This network topology is called **multi-homed network**, and in this configuration, virtual machines in the spoke VNet can communicate through either hub virtual network to the on-premises network(s).

### Design Recommendations
- Use dedicated ExpressRoute circuits and dedicated ExpressRoute Gateways when end-to-end network isolation from an on-premises VRFs to Azure is required.
  - This approach not only ensures end-to-end network isolation from on-premises to Azure, but also, it overcomes the ExpressRoute connections limits described in the design considerations section above.
- In Azure, connect virtual networks by using VNet peering when resources across different virtual networks need to communicate with each other.
  - A typical scenario is a management plane VNet communicating with data plane VNet(s) as depicted in the picture below:
![Figure 1: VNet peering between control plane and data plane VNets](./telco-multiple-er-vnet-peering.png)
_Figure 1:VNet peering between control plane and data plane VNets._
- When using dedicated ExpressRoute circuits and VNets, and Azure resources must be accesible over two on more ExpressRoute circuits, a multi-homed VNets network architecture is recommended. A multi-homed VNet architecture can be implemented by using one of the following approaches:
  - **Automatic route exchange with Azure Route Server (Preferred)**. In this setup, a NVA in the hub virtual network will learn about on-premises routes from the ExpressRoute gateway through route exchange with the Route Server in the hub. In return, the NVA will send the spoke virtual network addresses to the ExpressRoute gateway using the same Route Server. The Route Server in both the spoke and hub virtual network will then program the on-premises network addresses to the virtual machines in their respective virtual network. The virtual machines in the spoke virtual network will send all traffic destined for the on-premises network to the NVA in the hub virtual network first. Then the NVA will forward the traffic to the on-premises network through ExpressRoute. Traffic from on-premises will traverse the same data path in the reverse direction. In this setup, neither of the Route Servers are in the data path. This scenario is depicted in figure 2 below:
  
  ![Figure 2: Multi-homed VNets using Azure Route Server](./dual-homed-topology-expressroute.png)

  _Figure 2: Multi-homed VNets using Azure Route Server_
  - Static routing with User Defined Routes (UDRs). As a spoke VNet can only be connected to one hub with the “use remote gateway” VNet peering property, we need a different mechanism to ensure a VNet connected to two or more hubs can be reachable from on-premises and vice versa via the different ExpressRoute circuits. If Azure Route Server cannot be used, an alternative approach is by implementing a network model that uses an “auxiliary” or “routing” VNet, with the sole purpose of ensuring that the ExpressRoute gateway advertises to on-premises the address space of the spoke VNets that are connected to the hub without the “use remote gateway” VNet peering property. In this scenario a UDR in the Gateway subnet is required to ensure traffic arriving at the ExpressRoute Gateway with destination a spoke VNet is routed via the Firewall. A UDR in the spoke VNet(s) is also required to send traffic to on-premises over a specific firewall, depending on which VRF or ExpressRoute circuit the traffic needs to go through. This network model with the “routing” or “auxiliary” VNet is depicted in figure 3 below.

  ![Figure 3: Multi-homed VNets using UDR](./dual-homed-topology-udr.png)
  _Figure 3: Multi-homed VNets using User Defined Routes_


## IPSec Tunnels
- **_Work in progress_**

## Overlay Network Technologies (such as VXLAN)
- **_Work in progress_**
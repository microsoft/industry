# Governance for Telco Industry Scenarios

In general, any application composition can be deployed, managed and governed in Azure using the existing prescriptive and architecture guidance provided in Microsoft's Cloud Adoption Framework. However, some applications typical for the Telco industry, such as those that provide managed services to end customers (B2C), to businesses (B2B), or specialized telco applications such as packet core, require additional sets of controls and governance that are different from the traditional LoB applications and cloud native applications.

>Telco industry specific applications typically provide services such as Core CP, SBC, vIMS, vHSS, Thin/uCPE, SDWAN, vFW, vRouter, vLTM, CGNAT, vBNG, DDI and vRADIUS/DIAMETER among others.

As an example, while traditional LOB applications have corporate connectivity to on-premises via an ExpressRoute circuit deployed on the hub VNet, specialized telco applications may require deploying multiple VNets and their own ExpressRoute Gateways so they can use dedicated ExpressRoute circuits for user and data plane traffic, while other set of ExpressRoute circuits provide connectivity to on-premises network (such as near edge) for control plane traffic. Another example would be applications that require public IPs in their Landing Zones, or the need to have IP forwarding capabilities on VM NICs.

This section describes the management group and policies required to accomodate these specialized telco applications on an AfO Landing Zones architecture.

* [Management Group](#management-group)
* [Azure Policies](#azure-policies)
* [Azure Subscriptions](#azure-subscriptions)

## Management Group

Given these specialized requirements and to cater for scalability for specialized Telco workloads in Azure, the AfO Landing Zones architecture recommends the creation a new Management Group dedicated to Telco specific applications and services.

Azure policies that are designed to govern and manage those applications can be assigned to ensure Telco applications are compliant, and configured with high-availability as default at this scope. Subscriptions dedicated for such applications would need to be deployed under this new management group, which is depicted in figure 1 below:

![Management workloads](./management-group-telco.png)
_Figure 1: Management group for specialized telco workloads._

## Azure Subscriptions

Once a dedicated management group for specialized telco workloads has been created, and after assigning the relevant Azure policies at the corresponding scope (for example, some policies will be assigned at the Landing Zones scope, while others would be assigned at the Operator scope), Azure subscriptions can be either created or mover to this scope (depicted as Operator on figure 1). Thus, any Azure subscription that is deployed under this management group, it will inherit and apply any policies defined at the corresponding management group hierarchy.

## Azure Policies

The following table summarizes the Azure Policies that are recommended to be assigned at the Management Group dedicated for specialized telco workloads:

| Policy                                      | Description                                                                                         | Version |
|---------------------------------------------|-----------------------------------------------------------------------------------------------------|---------|
| Ensure Zone Redundant Gateways are deployed | Ensures that ExpressRoute gateways for Telco specialized workloads are deployed as highly-available | 1.0.0   |
| Ensure Public IPs are Zone Redundant        | Ensures that Public Ip addresses for Telco specialized workloads are deployed as highly-available   | 1.0.0   |

[Back to Azure for Telecommunications](../README.md)
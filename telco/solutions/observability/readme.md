# Observability and Analytics for Operators

Devices and equipment on operators on-premises infrastructure (such as radio access networks, or RAN), generate large amounts of logs that not only need to be captured, but also, given the sheer amount of information, operators require a cloud native solution to aggregate, analyze and report the data to embrace data-driven solutions and decisions. For example, a use case would be to collect RAN logs, and analyze them, at scale, to identify annomalies or interference.

This article describes an observability and analytics pattern and how it can be deployed on an operator landing zone. This article provides also a reference implementation to simplify the deployment of such landing zone.

* [Ingesting on-premises data into Azure](#ingesting-on-premises-data-into-azure)
* [Data aggregation and analytics on Azure](#data-aggregation-and-analytics-on-azure)
* [Sample observability landing zone for operators](#sample-observability-landing-zone-for-operators)

## Ingesting on-premises data into Azure

Devices and equipment on operators datacenters, as well as on the far and near edge, tend to generate a large amount of logs. When we augment the large number of operator's devices and equipment in their on-premises environment, they generate an enourmous amount of logs daily that not only is difficult to ingest in on-premises systems, but also aggregate and perform analytics on such logs (for example to identify interference on networks), is a cumbersome activity.

As an alternative, those logs can be send to Azure for data ingestion on an Azure storage service, such as Azure Datalake Storage Gen2. Once logs are on Azure, Azure analytics and AI solutions can be used to generate data from those raw log files.

The following sections provide design considerations and recommendations for ingesting such logs into Azure.

### Design considerations

- There are multiple ways to ingest on-premises data into an Azure. The following table summarizes the options available:

| Option                           | Pros                                                                                                                                                                                                                                                                                                                                                        | Cons                                                                                                                                                                                                                                                                                                                                                                                                                             |
|----------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Internet                         | - Simple to implement - No additional Azure networking costs - No Azure IaaS infrastructure required                                                                                                                                                                                                                                                        | - Traffic traverses the public internet - Latency and bandwidth not guaranteed                                                                                                                                                                                                                                                                                                                                                   |
| VPN                              | - Traffic is encrypted via an IPSec tunnel - Traffic can be kept private within an Azure VNet                                                                                                                                                                                                                                                               | - Traffic traverses the public internet - Azure VPN Gateway maximum bandwidth per IPSec tunnel is about 1Gbps, and there are limits on the maximum number of tunnels  - Azure IaaS infrastructure required (such as VNet, VPN Gateway and a Private Endpoint) - Additional costs due to the required infrastructure - It requires the Azure storage service to be accessible via a private endpoint, which is a metered service. |
| ExpressRoute (Private Peering)   | - Traffic is never exposed to the public internet, as it traverses a private connection - Predictable bandwidth and latency - 99.95% SLA availability - Scalable bandwidth up to 100 Gbps - FastPath can be enabled to remove the ExpressRoute Gateway from the data path                                                                                   | - Requires planning to set it up - Aggregated costs must be factored in, such as partner costs (if involved), ExpressRoute circuit, ExpressRoute gateway. - It requires Azure IaaS infrastructure (such as ExpressRoute gateway) - It requires the Azure storage service to be accessible via a private endpoint, which is a metered service.                                                                                    |
| ExpressRoute (Microsoft Peering) | - Traffic is never exposed to the public internet, as it traverses a private connection - Predictable bandwidth and latency - 99.95% SLA availability - Scalable bandwidth up to 100 Gbps - It has less aggregated costs, as it does not require Azure IaaS infrastructure, and the Azure storage service can be reached privately over its public endpoint | - Requires planning to set it up - Aggregated costs must be factored in, such as partner costs (if involved) - It requires usage of public IPs (although traffic is always kept private)                                                                                                                                                                                                                                         |
### Design recommendations

- Use ExpressRoute as the main option to connect the on-premises operator network to Azure.
- Use ExpressRoute direct if you require more than 10Gbps bandwidth.
- Use ExpressRoute private peering when there is a relatively low amount of data to be ingested.
- When using ExpressRoute private peering:
  - Ensure the Azure storage service (such as ADLS Gen2) is accesible via a private endpoint.
  - Enable FastPath on the ExpressRoute connection. This will remove the ExpressRoute Gateway from the data path. Note that it is still required for control plane operations.


## Data aggregation and analytics on Azure

## Sample observability landing zone for operators


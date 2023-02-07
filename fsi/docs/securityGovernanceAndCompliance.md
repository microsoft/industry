# Compliant and Secure by-default FSI Landing Zones

The FSI Landing Zones on Microsoft Azure provides a proven, authoritative, and scalable starting point for organizations within the financial services industry on their digital transformation trajectory.

This article provides an up-to-date view of every Azure Policy and security control capability that is provided in the reference implementation, and explains the intent, user experiences, and also the required steps for an application teams within the landing zones to mitigate through self-service in order to meet the compliance and security requirements for the Azure services used in their workload compositions.

## Table of contents

* [Autonomy with Governance](#autonomy-with-governance)
  * [Prescriptive, preventive, and proactive](#prescriptive-preventive-and-proactive)
  * [Understanding Azure Policy effects and secure by-default principle](#understanding-azure-policy-effects-and-secure-by-default-principle)
  * [Example - Compliant PaaS service from a Network Access perspective](#example---compliant-paas-service-from-a-network-access-perspective)
* [FSI Landing Zones Azure Policy index](#fsi-landing-zones-azure-policy-index)
* [Next Steps](#next-steps)

## Autonomy with Governance

Azure Policy is one of the key primitives in the Azure platform to ensure that resource configuration and the overall architecture is compliant and meet the regulatory requirements. FSI Landing Zones is consciously prescriptive with its usage of Azure Policy to reduce the management overhead as the environment grows, new business requirements are being introduced, net new Azure services are introduced, and existing Azure services are evolving. As being one of the key principles of FSI Landing Zones on Microsoft Azure, Azure Policy should be used in a prescriptive way to 1) prevent, and 2) be proactive to ensure continous compliance and the desired goal state of the Azure platform, landing zones, and the workload within the landing zones.

### Prescriptive, preventive, and proactive

Azure Policy provides multiple policy effects where organizations in general can decide to prevent, detect, and be proactive with the controls being implemented. The FSI Landing Zones on Microsoft Azure leads with a compliant and secure by-default design meaning each Azure service must conform to the regulatory requirements that the financial services industry is subject to.

### Understanding Azure Policy effects and secure by-default principle

Azure Policy supports the following effects, and the list below explains the order of evaluation:

The following effects are supported by Azure Policy

* Disabled – first effect to check to determine whether the policy rule should be evaluated
* Append and Modify – are triggered second, since either could alter the request, a change made may prevent an audit or deny effect from triggering.
* Deny – is then evaluated.
* Audit – is then evaluated, after Deny to prevent double logging
* Manual – is then evaluated
* auditIfNotExists – is then evaluated
* denyActions – is evaluated last

After a resource provider returns a success code on an ARM request, auditIfNotExists and deployIfNotExists evaluate to determine whether additional compliance logging or action is required.

To illustrate how this is being enforced as part of the FSI Landing Zones, we will cover an example where there's a requirement to ensure that Azure PaaS services are not using a public endpoint (deny), and is configured to use a private endpoint (deployIfNotExists) to ensure the service can be communicate and be consumed over a secure virtual network.

### Example - Compliant PaaS service from a Network Access perspective

**An Azure Policy is assigned to ensure that "Azure Service Bus should not be accessible over a public endpoint**

1. A user submit a request to create a Service Bus namespace into their subscription

````
HTTP PUT https://management.azure.com/subscriptions/{subId}/resourceGroups/{rgId}/providers/Microsoft.ServiceBus/namespaces/{resourceName}?api-version=2022-01-01 
````

2. The request payload (note that not all properties are express here due to readability) has the following properties that describes how the Service Bus namespace should be configured:

````json
  "properties": {
    "disableLocalAuth": true,
    "publicNetworkAccess": "Enabled",
    "zoneRedundant": true
  }
````

3. The policy that is assigned and will apply to this subscription will check for the following, and if the condition evaluates to ‘true’, it will deny the request

````json
{
    "policyRule": {
        "if": {
            "allOf": [
                {
                    "equals": "Microsoft.ServiceBus/namespaces/networkRuleSets",
                    "field": "type"
                },
                {
                    "notEquals": "Disabled",
                    "field": "Microsoft.ServiceBus/namespaces/networkRuleSets/publicNetworkAccess"
                }
            ]
        },
        "then": {
            "effect": "Deny"
        }
    }
}
````

4. The subscription remains compliant as the resource creation was denied with a policy that prevents usage of Service Bus using a public endpoint.

In the next example, we will explore the behavior when a Service Bus namespace resource is created with public network access set to disabled.

**An Azure Policy is assigned to ensure that "Azure Service Bus must be configured to use a private endpoint**

1. A user submit a request to create a Service Bus Namespace with the “publicNetworkAccess” property set to “Disabled”, which means the request will comply with the Deny policy and be successfully created within the subscription.

2. The policy will look for - and deploy a Private Endpoint configuration for Service Bus namespaces if it does not already exists (which is now not accessible over the public network), will be checking for the following:

````json
{
    "then": {
        "effect": "DeployIfNotExists",
        "details": {
            "type": "Microsoft.ServiceBus/namespaces/privateEndpointConnections",
            "existenceCondition": {
                "field": "Microsoft.ServiceBus/namespaces/privateEndpointConnections/privateLinkServiceConnectionState.status",
                "equals": "Approved"
            },
            "deployment": {...}
        }
    }
}
````

3. As the Azure Service Bus namespace is not creating with a private endpoint, the policy will evaluate to 'non-compliant' and the deployIfNotExists effect will deploy the Microsoft.Network/privateEndpoints resource into the subscription where the namespace is being created, and associate the endpoint.

````json
  "properties": {
    "disableLocalAuth": true,
    "publicNetworkAccess": "Disabled",
    "privateEndpointConnections": [
      {
        "properties": {
          "privateEndpoint": {
            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/privateEndpoints/pe1"
          },
          "privateLinkServiceConnectionState": {
            "status": "Approved"
          },
          "provisioningState": "Succeeded"
        }
      }
    ]
  }
````

**Summary**

Deny effect is used on the individual resource properties, where DINE is used to 1) check for existence condition on the resource properties, and 2) subsequently deploy ‘auxiliary’ resources to ensure desired state configuration provided by other Azure services – in this example a private endpoint resource which is part of the Microsoft.Network resource provider.

## FSI Landing Zones Azure Policy index

**Coming soon**

## Next Steps

Deploy the FSI Landing Zones on Microsoft Azure reference implementation. Explore the user guide and the deployment experience by following the links below:

| Reference Implementation | Description | Deploy | Documentation
|:----------------------|:------------|--------|--------------|
| FSI Landing Zones | FSI Landing Zones foundation that provides a full, rich, compliant architecture with scale-out pattern for secure-by default regions and landing zones, with a robust and customizable service enablement framework to accelerate adoption of Azure service and enables digital transformation |[![Deploy To Microsoft Cloud](../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/fsilz) | [User Guide](./referenceImplementation/readme.md)
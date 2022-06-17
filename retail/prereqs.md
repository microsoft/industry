# Microsoft cloud for retail (MCR)

Microsoft Cloud for Retail (MCR) accelerates business growth by providing trusted retail industry solutions that integrate with retailers’ existing systems. It brings together different data sources across the retail value chain and uniquely connects experiences across the end-to-end shopper journey though a set of capabilities that deliver more relevant personalized experiences and operational excellence for sustained profitability.

It's composed of indvidual capabilities which are built on Microsoft Dynamics 365, Microsoft Power Platform, Microsoft 365, and Microsoft Azure.

- Shopper and operations analytics
- Unified customer profile
- Intelligent stores
- Unified commerce
- Real-time personalization
- Digital advertising solutions
- Seamless customer service
- Demand planning and operations
- Supply chain visibility
- Flexible fufillment
- Process automation and career development
- Retail workforce management
- Real-time store communications and collaborations
- Retail media
- Intelligent fraud prevention

[Microsoft Cloud Solution Center](https://aka.ms/solutioncenter) provides a central place to deploy and configure Microsoft industry cloud solutions. It gives customers and partners a unified view of industry cloud capabilities for a seamless provisioning experience across Microsoft 365, Microsoft Azure, Microsoft Dynamics 365, and Microsoft Power Platform. Solution Center guides you through and simplifies the deployment process. It checks licensing requirements and dependencies to help make sure you have everything you need for your deployment.

## Licensing requirements

The table below summarizes the licenses you may require depending on the retail scenarios you wish to deploy. See specific requirements in the respective documentation and implementation guide for each scenario.

 Retail Capability | Product Name | Licensing Requirement(s) |
|:----------------------:|:----------------------|:----------------------|
| Shopper and operations analytics | Azure Synapse Analytics | Azure Subscription
|| Dynamics 365 Customer Insights | Customer Insights is licensed per tenant and includes multiple capabilities. You can purchase more capacity and licenses to increase the default quota. Please refer to [Pricing guide](https://dynamics.microsoft.com/ai/customer-insights/pricing/) for further details.
|| Microsoft Clarity | Free - no additional license required; however, registration is required.
| Unified customer profile | Unified customer profile ||
|| Dynamics 365 Customer Insights |
| Intelligent stores | Dynamics 365 Connected Spaces (Public Preview) | Preview offers a free 180-day trial. Dynamics 365 Connected Spaces is currently offered for Preview. When the product is released for general availability (GA), you'll be able to convert the trial to a [paid license](https://docs.microsoft.com/en-us/dynamics365/connected-spaces/trial-faq#can-i-convert-the-trial-to-a-paid-license).
| Unified commerce | Dynamics 365 Commerce | Commerce is licensed per user. Note - When you license Commerce, you automatically become entitled to the Fraud Protection capabilities and transaction capacities noted below. Once you have Commerce, you may also buy additional capacity licenses for Fraud Protection.
|| Azure Cognitive Search | Azure Subscription
| Real-time personalization | Intelligent Recommendations | Azure Subscription
||Azure Cognitive Search | Azure Subscription
|| Dynamic 365 Marketing | Dynamics 365 Marketing is licensed per tenant and includes a default seeded capacity allotment of 10K Marketing Contacts and 100K Marketing Interactions per month.
| Digital advertising solutions | Microsoft Advertising |
| Seamless customer service | Omnichannel for Customer Service | Dynamics 365 license for Customer Service is required. Customer Service is available as either an Enterprise or Professional user license and with several optional add-ins to deliver the capabilities needed for your situation.
|| Power Virtual Agents | Access to Power Virtual Agents license required. The Power Virtual Agents application is licensed per tenant. Power Virtual Agents will be charged according to the unit of ‘billed sessions'. A user license (called Power Virtual Agent User License) is required for each user authoring bots with Power Virtual Agents. Available at no additional cost, the license can be assigned to users by the administrator in the admin portal. We recommend acquiring the tenant license (with capacity add-on if needed) and user licenses as part of a single transaction to simplify onboarding to Power Virtual Agents. Please refer to Power Virtual Agents [licensing guide](https://go.microsoft.com/fwlink/?LinkId=2085130&clcid=0x409)for more details.
|| Dynamic 365 Commerce | Dynamics 365 Commerce license is required for this capability. Commerce is licensed per user.
| Demand planning and operations | Dynamics 365 Supply Chain Management | Dynamics 365 Supply Chain Management license is required. Supply Chain Management is licensed per user and has minimum purchase requirements detailed in the [Product Terms](https://www.microsoft.com/licensing/terms/).
| Supply chain visibility | Dynamics 365 Supply Chain Insights (Preview) | This is a preview service and it's available as part of Supply Chain.
| Flexible fulfillment | Dynamics 365 Intelligent Order Management | Intelligent Order Management is an intelligent multitenant standalone service. Intelligent Order Management is licensed per tenant, and it comes with 1K order lines. If you need additional capacity, you can buy multiple units of the same license. Intelligent Order Management license also includes limited Power Automate use rights, such as Power Platform requests per month, and use of connectors. See [Power Platform Licensing Guide](https://go.microsoft.com/fwlink/?LinkId=2085130&clcid=0x409) for more details.
|| Microsoft 365 for frontline workers | A minimum of Microsoft 365 F1 license is required to use this service. More details are available [here](https://www.microsoft.com/microsoft-365/enterprise/frontline?rtc=1#office-SKUChooser-0dbn8nt).
|| Dynamics 365 Commerce | Dynamics 365 Commerce license is required for this capability. Commerce is licensed per user.
| Process automation & career development | Microsoft Viva Connections | Viva is a desktop and mobile experience that is built on Microsoft 365 ecosystem and SharePoint. This is available as part of Microsoft 365 E3 and E5; Office 365 E1, E3, E5 and F3; Microsoft 365 F1 and F3. More details are available [here.](https://go.microsoft.com/fwlink/p/?linkid=2139145)
|| Microsoft Viva Learning | Microsoft Viva Learning in Teams is available as part of Microsoft 365 E3 and E5; Office 365 E1, E3, E5 and F3; Microsoft 365 F1 and F3 licenses.
|| Microsoft Viva Insights | Requires Microsoft 365 or Office 365 E1/A1/G1/E3/A3/G3/E5/A5/G5, Microsoft 365 Business Basic, Business Standard,Business Premium, or Exchange Online Plan 1 or Plan 2 license to be eligible for Microsoft Viva Insights.
| Retail workforce management | Microsoft 365 for frontline workers | A minimum of Microsoft 365 F1 license is required to use this service. More details are available [here](https://www.microsoft.com/microsoft-365/enterprise/frontline?rtc=1#office-SKUChooser-0dbn8nt).
| Real-time store communications and collaborations | Microsoft 365 for frontline workers | A minimum of Microsoft 365 F1 license is required to use this service. More details are available [here](https://www.microsoft.com/microsoft-365/enterprise/frontline?rtc=1#office-SKUChooser-0dbn8nt).
| Retail media | Microsoft PromoteIQ | Ad revenue sharing. Contact Microsoft Sales.
| Intelligent fraud prevention | Dynamics 365 Fraud Protection | Dynamics 365 Fraud Protection is required for this feature. There are two ways to purchase Dynamics 365 Fraud Protection: Pre-paid capacity model and Pay-as-you-go model. More details are available as part of [Dynamics 365 licensing guide](https://go.microsoft.com/fwlink/p/?LinkId=866544). Fraud Protection may be deployed in the same tenant as, but cannot share the same environment with Sales, Customer Service, Field Service, or Marketing, or with Finance, Supply Chain Management, or Commerce.
---

**Note** - Dynamics 365 applications are licensed by subscription in two broad categories - Assigned licenses (grants access for a named user, regardless of the device used) and Unassigned licenses (provide access to a feature or service at tenant level regardless of the user/device).For more details about Dynamics 365 licensing, see the [licensing guide](https://go.microsoft.com/fwlink/?LinkId=866544&clcid=0x409).

---

## MCR and Dataverse dependencies

Microsoft has published retail applications and capabilities they enable [here](https://download.microsoft.com/download/9/8/5/9854801b-878d-4eb8-a5b6-321279456912/Microsoft_Cloud_for_Retail_pricing%20data_sheet.pdf).

Several applications which are part of MCR ecosystem rely upon Dataverse. The table below provides a summarized view of app deployment and Dataverse dependency.

|Application|Dataverse required for deployment?|Additional Comments|
|:-|:-|:-|
|D365 Commerce|No|
|D365 e-Commerce|No|
|D365 Commerce POS Add-On|No|
|D365 Fraud Protection|No|
|D365 Connected Spaces|Yes|
|D365 Marketing|Yes|
|D365 Customer Insights|Yes|
|Teams for Frontline Workers|No|Optional - Dataverse is required if you plan to use **Approvals** teams app for frontline workers.|
|D365 Supply Chain Management|No|
|D365 Intelligent Order Management|Yes|
|D365 Customer Service|Yes|
|Microsoft Teams|No|

## Azure landing zones

Several capabilities of MCR rely on Azure-based services. Guidance for these services is to leverage [Azure Landing Zones](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/).

## Power Platform

Power Platform environments (recommendation is dedicated environments for test, development, and production) that are created into the target region with Dataverse and D365 applications enabled.

Prescriptive guidance for deploying Power Platform are published [here](https://github.com/microsoft/industry/tree/main/foundations/powerPlatform).

## Microsoft Teams

Some of the retail capabilities rely on Microsoft Teams, such as Frontline Workers and Microsoft Viva.

Prescriptive guidance and design recommendations for Microsoft Teams are published [here](https://github.com/microsoft/industry/tree/main/foundations/teams)

---

[Back to documentation root](../README.md)

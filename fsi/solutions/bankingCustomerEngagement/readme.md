# Banking Customer Engagement

> Please note that this solution is still in Preview. Previews are not meant for production use.

The banking customer engagement solution enables instant connections and an improved customer engagement for customer service representatives and service agents. The solution can provide an immediate view and contextual information of the financial situation of the client. This can ultimately drive better outcomes, an increased customer satisfaction and a higher agent productivity.

Key capabilities of the Banking Customer Engagement scenario include:

* **Contact snapshot**: Provides an holistic overview of the customer including their personal details, life moments, financial holdings, credit & debit cards. This allows representatives to get a full financial picture of the client and enables an enhanced and personalized client experience.
* **Enhanced conversation view**: The holistic contact view can be places side-by-side with customer cases, timelines and conversation summaries to provide a comprehensive experience for the customer representative and improve their decision making.
* **Monitor agent**: Dashboards allow agents, shift managers and general managers to get an overview of various insights depending on their requirements. Dashboards can present active cases, conversations, and more.
* **Agent script**: Enables agent scripts to address customer specific issues. Own scripts and rules can be integrated.
* **Knowledge management**: Providing relevant information to service providers at their fingertips is increasingly relevant and can be achieved with this solution. Articles, FAQs, and other shareable or internal knowledge pieces can be made available at the right time in teh right place.

| Reference implementation    | Description | Deploy |
|:----------------------------|:------------|--------|
| Banking Customer Engagement | The scenario empowers customer service representatives to quickly resolve issues and drive toward better outcomes, increasing customer satisfaction and agent productivity. |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/solutioncenter) |

## Prerequisites

Before you deploy and configure, verify you have implemented the [prerequisites](../../prereqs.md).

Specifically for the banking customer engagement scenario, you need:

* [Power Platform environments](../../../foundations/powerPlatform/)
  * Must be created upfront, in United States with Dataverse and D365 Apps enabled
  * D365 application dependencies, such as
    * D365 Customer Service
    * Omnichannel for Customer Service
    * Customer Insights (optional but required for full experience)

> Note: The implementation of the Banking Customer Engagement solution can currently not be automated, and requires manual implementation and configuration across Solution Center and Power Platform Admin Center.

## Deployment of banking customer engagement solution

To deploy the banking customer engagement solution you first need to create a Power Platform environment. Next, you need to follow a few steps to deploy the financial services specific solution.
For the deployment, please [follow the steps described here (Step 1, Step 2, Step 3)](https://docs.microsoft.com/en-us/dynamics365/industry/financial-services/deploy#step-1-prepare-environment) and deploy the banking customer engagement solution.

The solution can be optionally deployed with sample data. The sample data can only be added when deplyoing the solution through the solution center. There is no capability to remove the sample data. This needs to be done in the application.

## Access of banking customer engagement solution

Grant users access to the financial services banking customer engagement solution by creating the following role assignments:

* Microsoft Cloud for Financial Services: Basic user
* Retail banking: Viewer, Retail banking – Contributor
* Customer service representative
* Omnichannel agent, supervisor, or admin
* Financial intelligence user (optional for Banking customer engagement with Customer Intelligence)

For more details on how to grant users access to an environment please visit [this site](https://docs.microsoft.com/en-us/power-platform/admin/add-users-to-environment). For more details about security roles, please visit [this site](https://docs.microsoft.com/power-platform/admin/database-security).

## Features of banking customer engagement solution

The following sections will walkthrough the various features of the banking customer engagement solution.

### Contact snapshot

![Contact Snapshot](./docs/ContactView.png)

The contact view or customer snapshot provides a holistic overview of the customer and his/her situation. The snapshot includes:

* *Personal information*: Name, demographics.
* *Financial Information*: Financial measures, regular income, branch information.
* *Contact information*: Preferred channel for communication.
* *Customer intelligence-driven information* (optional): Segments, churn score
* *Conversations*: Open and historical customer sessions, conversation summary
* *Financial holdings*: Customer relationship with the bank, wallet share, assets, liabilities, financial holdings, alert indicators, accounts, investments, loans, credit lines, long-term savings
* *Financial summary*: financial holdings name, type & value, alerts for investments and loans, detailed information about holdings, total balance
* *Cards*: Credit cards, debit cards, expiry alerts, card details, card status
* *Life events*: Customers and families future and past milestones

### Enhanced conversation view

![EnhancedConversationView](./docs/EnhancedConversationView.png)

The enhanced conversation view is based on [Omnichannel for Customer Service](https://docs.microsoft.com/dynamics365/customer-service/introduction-omnichannel) enables customer agents, to put relevant client information and teh active case side-by-side. The view appears when a customer initiates a conversation with the service center through a supported channel. More details about Omnichannel for Customer Service can be found [here](https://docs.microsoft.com/dynamics365/customer-service/oc-introduction-agent-interface).

### Monitor agent

![Monitor Agents](./docs/MonitorAgents.png)

The monitoring capabilities are built into a solution and can be accessed by opening the dashboard view of the application. Different dashboard views are available for different personas and can be used to monitor active sessions, active cases, cases that require a follow-up, active agents and call-center performance.

To learn how additional dashboards can be created, visit [this page](https://docs.microsoft.com/powerapps/maker/model-driven-apps/create-edit-dashboards).

### Agent scripts

Agent scripts can be used to provide guidance to agents to avoid errors and ensure that processes are followed. The contextual guidance guides them through the conversation and provides accurate information that can then be shared with customers. This allows to create a unified experience for customers and allows to respond more timely and efficiently to customer queries.

More details about the agent script feature in Dynamics 365 customer services can be found [here](https://docs.microsoft.com/en-us/dynamics365/app-profile-manager/agent-scripts).

### Knowledge management

In order to improve customer case resolution, the right information needs to be available at the right time to customer representatives. The knowledge management capability in the banking customer engagement solution can help service agents to respond timely in a clear and standardized fashion, by being able to search through a knowledge base and find the right articles at the right time.

This lowers the training cost of customer representative, while keeping the quality of the customer service high. This is built on top of the knowledge article feature of Omnichannel for Customer Service. More information about this feature can be found [here](https://docs.microsoft.com/en-us/dynamics365/customer-service/knowledge-management-oc).

## Planning guidelines for banking customer engagement

This section provides prescriptive guidance with design considerations and recommendations across the critical design areas for banking customer engagement for the teams that will deploy and manage the capabilities within the Microsoft Cloud for Financial Services.

> Note: The design areas for banking customer engagement are lightweight as the critical design areas, considerations and recommendations should be addressed in the Power Platform architecture itself. This is primarily because the banking customer engagement scenario and its dependencies are D365 applications that must only be sequenced and deployed into existing environments.

* [Identity and access](#identity-and-access)
* [Deployment](#deployment)

## Identity and access

### Design considerations

* The user who deploys and configures the D365 Customer Service solution must either be Global Admin, Power Platform Admin, D365 Admin, or have sufficient permissions directly on the dedicated Power Platform environment.
* If you are deploying to an Environment in Power Platform that previously had the Customer Service solution deployed, then the *Service support admin* user must use the same user ID as was used for the initial install. If not, a user with Global Admin, Power Platform Admin, or D365 Admin must deploy it.
* The user deploying the D365 Customer Service app must also have permissions to register applications in Azure AD.
* Due to technical constraints, the user deploying the D365 Customer Service solution must be associated with a D365 Customer Service license.
* To deploy the banking customer engagement solution, the user must have an assigned license for the Financial Services add-on.

### Design recommendations

* Ensure user/group mapping for the requisite licenses are done before deploying the solutions to Power Platform.
* Ensure appropriate RBAC is assigned to the Security group for the dedicated Environment for Financial Services in Power Platform, ideally as part of the Environment creation process.
* If privileged access to application registration in Azure AD cannot be granted for the group/users who will deploy and operate the D365 Customer Service solution and banking customer engagement scenario, a Global Administrator must assist with the deployment.

## Deployment

### Design considerations

* Deployment of D365 Customer Service solution starts from within the Admin Center of Power Platform, which then will take you to the Dynamics 365 apps admin page to complete the setup.
* Deployment of D365 Customer Service solution can take several hours, and puts a write lock on the environment to prevent parallel deployments of solutions.
* There's limited logs and telemetry available during the deployment in case anything fails, hence you should ensure you have reserved enough time to get D365 Customer Service app installed successfully as a dependency to the banking customer engagement solution deployment.
* Sample data can be added when deploying the solution in the solution center.

### Design recommendations

* If Global Administrator permissions are needed to complete the deployment, ensure this is a joint activity in order to troubleshoot and follow-up with support in case D365 Customer Service deployment is having issues.
* Deploy D365 Customer Service to test, development, and production environment to align with the overall [Environment strategy recommendations](../../../foundations/powerPlatform/) for Industry solutions in Power Platform.
* Similarly, deploy banking customer engagement (and all other Financial Services solutions) to test, development, and production environments per the above.
* Unselect the deployment of sample data in the solution center, because there is no one click solution to remove the data afterwards.

---

[Back to documentation root](../../../README.md)

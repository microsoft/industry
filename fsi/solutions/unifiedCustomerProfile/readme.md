# Unified Customer Profile

The unified customer profile scenario in Microsoft Cloud for Financial Services provides financial institutions with a 360-degree perspective of their customers to enable a more engaged interaction and higher customer satisfaction. The unified profile dashboard can be used across multiple business lines to provide accurate, consistent and cohesive information that can be used to provide a personalized experience, reveal important opportunities and prevent potential loss or churn.

Key capabilities of the unified customer profile app include:

* **Customer Summary**: Provides an holistic overview of the customer including their personal details, demographics. life moments, income, financial holdings, credit & debit cards and preferred channel of communication.
* **Relationships and Groupings**: The app provides information about groups that the customer is part of. Groups can be created and associated based on financial strengths per household or other factors. Relationships between contacts can also be captured and created.
* **Financial Holdings**: Provides a detailed overview of financial holdings of the respective customer.

| Reference implementation    | Description | Deploy |
|:----------------------------|:------------|--------|
| Unified Customer Profile | The scenario enables a holistic overview of a customer in the financial industry. |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/solutioncenter) |

## Prerequisites

Before you deploy and configure, verify you have implemented the [prerequisites](../../prereqs.md).

Specifically for the unified customer profile scenario, you need:

* [Power Platform environments](../../../foundations/powerPlatform/)
  * Must be created upfront, in United States with Dataverse and D365 Apps enabled

> Note: The implementation of the unified customer profile solution can currently not be automated, and requires manual implementation and configuration across Solution Center and Power Platform Admin Center.

## Deployment of unified customer profile solution

To deploy the unified customer profile solution you first need to create a Power Platform environment. Next, you need to follow a few steps to deploy the financial services specific solution.
For the deployment, please [follow the steps described here (Step 1, Step 2, Step 3)](https://docs.microsoft.com/en-us/dynamics365/industry/financial-services/deploy#step-1-prepare-environment) and deploy the unified customer profile solution.

The solution can be optionally deployed with sample data. The sample data can only be added when deploying the solution through the solution center. There is no capability to remove the sample data. This needs to be done in the application.

## Access of unified customer profile solution

Grant users access to the financial services unified customer profile solution by creating the following role assignments:

* Microsoft Cloud for Financial Services: Basic user
* Retail banking: Viewer, Retail banking – Contributor

For more details on how to grant users access to an environment please visit [this site](https://docs.microsoft.com/en-us/power-platform/admin/add-users-to-environment). For more details about security roles, please visit [this site](https://docs.microsoft.com/power-platform/admin/database-security).

## Features of unified customer profile solution

The following sections will walkthrough the various features of the unified customer profile solution.

### Customer Summary

The customer summary tab shows the most relevant information about a customer. Following details are provided and are allowed to be edited in the summary tab:

* *Customer snapshot*: personal information such as name, address, demographics and branch information, preferred channel of communication (can be extended with chrun score, and other information)
* *Life events*: customer's and family's past and future life milestones
* *Financial holdings*: Accounts, investments, loans, assets, liabilities, credit lines, long-term savings
* *Cards*: Credit & debit cards held by the customer, status of cards, activation state
* *Main household*: Household income, total assets, total liabilities
* *Customer intelligence*: Churn risk (if customer intelligence churn model has been trained and setup)

### Connections

The connections tab provides a summarized view of relationships to other customers and group membership. Following details are shown and can be edited by the user:

* *Customer groups*: Group memberships such as customer's household, role in group
* *Selected customer group*: Detailed group information includes group address, total income, total assets, total liabilities, shared financial holdings
* *Relationships*: Relationship to other customers including private and professional relationships

### Financial Holdings

The financial holdings tab provides more detailed insights about the financial holdings shown in the summary tab. Following information can be viewed in this section:

* *Financial holdings*: Financial holdings name, category, type, value, instruments, alerts for savings or loans nearing the maturity date
* *Currency treatment*: Detailed financial holdings overview in the original currency and teh default currency

## Planning guidelines for unified customer profile

This section provides prescriptive guidance with design considerations and recommendations across the critical design areas for unified customer profile for the teams that will deploy and manage the capabilities within the Microsoft Cloud for Financial Services.

> Note: The design areas for unified customer profile are lightweight as the critical design areas, considerations and recommendations should be addressed in the Power Platform architecture itself. This is primarily because the unified customer profile scenario and its dependencies are D365 applications that must only be sequenced and deployed into existing environments.

* [Identity and access](#identity-and-access)
* [Deployment](#deployment)

## Identity and access

### Design considerations

* To deploy the unified customer profile solution, the user must have an assigned license for the Financial Services add-on.

### Design recommendations

* Ensure user/group mapping for the requisite licenses are done before deploying the solutions to Power Platform.
* Ensure appropriate RBAC is assigned to the Security group for the dedicated Environment for Financial Services in Power Platform, ideally as part of the Environment creation process.
* If privileged access to application registration in Azure AD cannot be granted for the group/users who will deploy and operate the D365 solution and unified customer profile scenario, a Global Administrator must assist with the deployment.

## Deployment

### Design considerations

* Deployment of D365 solution starts from within the Admin Center of Power Platform, which then will take you to the Dynamics 365 apps admin page to complete the setup.
* Deployment of D365 solution can take several hours, and puts a write lock on the environment to prevent parallel deployments of solutions.
* There's limited logs and telemetry available during the deployment in case anything fails, hence you should ensure you have reserved enough time to get the D365 app installed successfully as a dependency to the unified customer profile solution deployment.
* Sample data can be added when deploying the solution in the solution center.

### Design recommendations

* If Global Administrator permissions are needed to complete the deployment, ensure this is a joint activity in order to troubleshoot and follow-up with support in case D365 deployment is having issues.
* Deploy D365 apps to test, development, and production environment to align with the overall [Environment strategy recommendations](../../../foundations/powerPlatform/) for Industry solutions in Power Platform.
* Similarly, deploy unified customer profile (and all other Financial Services solutions) to test, development, and production environments per the above.
* Unselect the deployment of sample data in the solution center, because there is no one click solution to remove the data afterwards.

---

[Back to documentation root](../../../README.md)

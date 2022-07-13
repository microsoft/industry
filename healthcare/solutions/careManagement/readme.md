# Care management

The Care management solution creates a model-driven app within Power Platform to provide healthcare-specific capabilities as part of Microsoft Cloud for Healthcare.
The solution allows health providers to create, personalize and enable new care plans for patients and manage care team members. Key capabilities include:

* **Care team:** View and collaborate with care teams to provide the best care for the patient.
* **Care plan:** Create and assign care plans and automate adherence to improve care coordination for your patients.
* **Clinical timeline:** See a concise, sequential, and interactive view of patient's clinical occurrences.
* **Virtual clinic:** Provide your care team members the ability to perform virtual appointments with patients.

| Reference implementation | Description | Deploy |
|:-------------------------|:------------|--------|
| IoMT                     | Care management for health providers to create, personalize and enable new care plans for patients and manage care team members. |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/solutioncenter-healthcare) |

## Prerequisites

Before you deploy and configure, verify you have implemented the [prerequisites](../../prereqs.md).

Specifically for care management, you need:

* [Power Platform environments](../powerPlatform/)
  * Must be created upfront, in United States with Dataverse and Dynamics 365 Apps enabled
  * Dynamics 365 application dependency: Dynamics 365 Customer Service License, Microsoft Cloud for Healthcare License

## Deployment of care management

To deploy care management you first need to create a Power Platform environment. Next, you need to follow a few steps to deploy the healthcare specific solution.
For the deployment, please [follow the steps described here (Step 1, Step 2, Step 3)](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/deploy#step-1-prepare-environment) and deploy the care management solution.

## Post-deployment configurations for care management

After successfully deploying the care management solution into your power platform environment, you can to execute the following post-deployment steps to enable additional functionality:

1. Virtual Clinic with virtual care app

   The virtual care app is a solution hat can be used by practinioners to organize and orchestrate schedules, locations and appointments. The app can be integrated into other platforms like Microsoft Teams from which practitioners can directly join Teams meetings that have been generated after a customer has booked an appointment. Practitioners must be granted access to the app to be able to consume the solution, modify data and join Teams calls.

   For more details on how to integrate the app into teams, follow [this link](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/configure-virtual-care) and [this link](https://docs.microsoft.com/en-us/powerapps/teams/embed-model-driven-teams-tab).

2. Care management analytics with Power BI

   Power BI reports can be used and embedded into the care management solution to provide a visual overview of your care management data. Pre-configured healthcare-specific reports are available. For the home care scenario, the following ones are available:

   * Care management Analytics

   [Follow the steps described here](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/configure-powerbi-reports#embed-the-power-bi-report-in-home-health-or-care-management) to embed healthcare-specific Power BI reports into your solution.

## Accesing care management

After deployment, the care management app can be opened from the Microsoft Dynamics 365 home page. For more details about the care menegement app, please [follow this link](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/use-care-management#administration).

Users required to use these apps, need to be granted access on the Power Platform environment. More details and step-by-step guidance can be found [here](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/deploy#step-3-add-users-and-assign-security-role).

## Planning guidelines for care management

This section provides prescriptive guidance with design considerations and recommendations across the critical design areas for care management for the teams that will deploy and manage the capabilities within the Microsoft Cloud for Healthcare.

* [Identity and access](#identity-and-access)
* [Deployment](#deployment)

## Identity and access

### Design considerations

* The user who deploys and configures the Dynamics 365 Field Service solution must have sufficient permissions directly on the dedicated Power Platform environment.
* To deploy the home health solution, the user must have an assigned license for the Healthcare add-on.

### Design recommendations

* Ensure user/group mapping for the requisite licenses are done before deploying the solutions to Power Platform.
* Ensure appropriate RBAC is assigned to the Security group for the dedicated Environment for Healthcare in Power Platform, ideally as part of the Environment creation process.

---

[Back to documentation root](../../../README.md)
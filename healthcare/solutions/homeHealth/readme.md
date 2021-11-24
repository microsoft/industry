# Home health

Home health extends Microsoft Dynamics 365 Field Services with healthcare specific capabilities to manage home visit schedules, notify patients and give providers access to medical information. Key capabilities include:

* **Schedule Home visit:** Enable care coordinators to schedule home visit appointments, while viewing patient information directly in context.
* **Provider scheduling:** View schedules of care team members and optimize visiting routes.
* **Home visit coordination:** Coordinate care and support distinct processes and tasks for the home visit.
* **Patient notifications:** Notify patients of arrival times and send follow-up patient satisfaction survey.

Besides the Dynamics 365 App, the overall solution also encompasses two apps today, the home health app and the care team member app.

Before you deploy and configure, verify you have implemented the [prerequisites](../../prereqs.md).

Specifically for home health, you need:

* [Power Platform environments](../powerPlatform/)
  * Must be created upfront, in United States with Dataverse and D365 Apps enabled
  * Dynamics 365 application dependency: Dynamics 365 Field Service License, Microsoft Cloud for Healthcare License

## Deployment of home health

To deploy home health you first need to create a Power Platform environment. Next, you need to follow a few steps to deploy the healthcare specific solution.
For the deployment, please [follow the steps described here (Step 1, Step 2, Step 3)](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/deploy#step-1-prepare-environment) and deploy the home health solution.

## Post-deployment configurations for home health

After successfully deploying the home health solution into your power platform environment, you can to execute the following post-deployment steps to enable additional functionality:

1. Patient Feedback with Dynamics 365 Customer Voice

   Dynamics 365 Customer Voice can be used to gather and track patient metrics. Pre-configured healthcare-specific surveys are available and can be used to:

    * New Patient Survey: Check in on patient experience and monitor health.
    * Patient Service Center: Experience with patient service center.

   [Follow the steps described here](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/configure-customer-feedback#create-a-survey-project-from-a-template) to create surveys for your patients.

2. Patient and Provider analytics with Power BI

   Power BI reports can be used and embedded into the home health solution to provide a visual overview of your home health data. Pre-configured healthcare-specific reports are available. For the home care scenario, the following ones are available:

   * Patient Analytics
   * Provider Analytics

   [Follow the steps described here](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/configure-powerbi-reports#embed-the-power-bi-report-in-home-health-or-care-management) to embed healthcare-specific Power BI reports into your solution.

## Accesing home health

After deployment, the home health app can be opened from the Microsoft Dynamics 365 home page. For more details about the home health app, please [follow this link](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/use-home-health#home-health-app).

The care member app that is also part of the home health scanario is meant to be accessed through the field service Dnymaics 365 mobile app and can be used to see and update the specifics of a home care visit on a mobile device. Please [follow this link](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/use-home-health#care-team-member-app).

Users required to use these apps, need to be granted access on the Power Platform environment. More details and step-by-step guidance can be found [here](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/deploy#step-3-add-users-and-assign-security-role).

## Planning guidelines for home health

This section provides prescriptive guidance with design considerations and recommendations across the critical design areas for home health for the teams that will deploy and manage the capabilities within the Microsoft Cloud for Healthcare.

* [Identity and access](#identity-and-access)

## Identity and access

### Design considerations

* The user who deploys and configures the Dynamics 365 Field Service solution must have sufficient permissions directly on the dedicated Power Platform environment.
* To deploy the home health solution, the user must have an assigned license for the Healthcare add-on.

### Design recommendations

* Ensure user/group mapping for the requisite licenses are done before deploying the solutions to Power Platform.
* Ensure appropriate RBAC is assigned to the Security group for the dedicated Environment for Healthcare in Power Platform, ideally as part of the Environment creation process.
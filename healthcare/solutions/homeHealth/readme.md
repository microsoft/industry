# Home health

Home health extends Microsoft Dynamics 365 Field Services with healthcare specific capabilities to manage home visit schedules, notify patients and give providers access to medical information. Key capabilities include:

* **Schedule Home visit:** Enable care coordinators to schedule home visit appointments, while viewing patient information directly in context.
* **Provider scheduling:** View schedules of care team members and optimize visiting routes.
* **Home visit coordination:** Coordinate care and support distinct processes and tasks for the home visit.
* **Patient notifications:** Notify patients of arrival times and send follow-up patient satisfaction survey.

Besides the Dynamics 365 App, the overall solution also encompasses two apps today, the home health app and the care team member app.

![Home health](./images/overview.png)

Before you deploy and configure, verify you have implemented the [prerequisites](../../prereqs.md).

Specifically for home health, you need:

* [Power Platform environments](../powerPlatform/)
  * Must be created upfront, in United States with Dataverse and D365 Apps enabled
  * Dynamics 365 application dependency: Dynamics 365 Field Service License, Microsoft Cloud for Healthcare License

## Deployment of home health

To deploy home health you first need to create a Power Platform environment and then you need to follow a few steps to deploy the healthcare specific solution.
For the deployment, please [follow the steps described here (Step 1, Step 2, Step 3)](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/deploy#step-1-prepare-environment).

## Post-deployment configurations for home health

After successfully deploying the home health solution into your power platform environment, you can to execute the following post-deployment steps to enable additional functionality:

1. Patient Feedback with Dynamics 365 Customer Voice

   Dynamics 365 Customer Voice can be used to gather and track patient metrics. Healthcare-specific surveys are available out of the box and can be used to:

    * New Patient Survey: Check in on patient experience and monitor health.
    * Patient Service Center: Experience with patient service center.

   [Follow the steps described here](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/configure-customer-feedback#create-a-survey-project-from-a-template) to create surveys for your patients.

2. Patient and Provider analytics with Power BI

   Power BI dashboards can be used and embedded into the home health solution 


## Home health app


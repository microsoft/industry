# Patient outreach

Patient outreach is a patient campaign management application that helps organize and automate marketing and outreach to patients. Healthcare providers can communicate with their communities and patients in a targeted, efficient way. Providers can use email, text, regular mail, or a combination, to provide healthcare information to specific groups of patients and community members.

Key capabilities of Patient outreach include:

* **Patient segmentation**: Prebuilt patient segments to provide baseline patient cohorts.
* **Patient engagement campaigns**: Create healthcare-specific email campaigns that use prebuilt patient segments.
* **Event management**: Use provider/payor event management templates for event administration and registration.

Before you deploy and configure, verify you have implemented the [prerequisites](../../prereqs.md).

Specifically for patient outreach, you need:

* [Power Platform environments](../../../foundations/powerPlatform/)
  * Must be created upfront, in United States with Dataverse and D365 Apps enabled
  * D365 application dependencies, such as D365 Marketing

The implementation of the Patient Outreach solution can currently not be automated, and requires manual implementation and configuration across Solution Center, Power Platform Admin Center. See [Configure the Dynamics 365 Marketing app for Patient outreach](https://docs.microsoft.com/dynamics365/industry/healthcare/configure-marketing-patient-outreach) for detailed instructions.

## Planning guidelines for Patient Outreach

This section provide prescriptive guidance with design considerations and recommendations across the critical design areas for Patient Outreach for the teams that will deploy and manage the Patient Outreach capabilities within the Microsoft Cloud for Healthcare.

* [Identity and access](#identity-and-access)
* [Monitoring](#monitoring)
* [Security](#identity-and-access)

## Identity and access

### Design considerations

* The user who deploys and configures the D365 Marketing solution must either be Global Admin, Power Platform Admin, D365 Admin, or have sufficient permissions directly on the dedidacted Power Platform environment.
* If you are deploying to an Environment in Power Platform that previously had the Marketing solution deployed, then the *Service support admin* user must use the same user ID as was used for the initial install. If not, a user with Global Admin, Power Platform Admin, or D365 Admin must deploy it.
* The user deploying the D365 Marketing app must also have permissions to register applications in Azure AD.
* Due to technical constraints, the user deploying the D365 Marketing solution must be asociated with a D365 Marketing license.

### Design recommendations

* Ensure appropriate RBAC is assigned to the dedicated Environment in Power Platform, ideally as part of the Environment creation process for the persona who will deploy and operate the D365 Marketing solution as part of Patient Outreach scenario.
* 
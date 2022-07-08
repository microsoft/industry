# Teams for Frontline Workers (TFW)

TFW builds upon features of MS Teams. TFW is designed for frontline workers and builds upon MS Teams. It's not a separate application.

**Flexible fulfillment** solution enables set of technologies which allows customers to order goods through various channels (bricks and mortar, online) and from a retailer's perspective, fulfill via various methods such as in-store pickup; home delivery from a warehouse etc.

## TFW and flexible fulfillment scenarios

TFW enables retail frontline workers to collaborate through apps such as Walkie Talkie; Shifts; Tasks etc. and provides a building block which enables flexible fulfillment.

- An example where TFW enables flexible fulfillment is where a customer places an order for an item over online channel and then it gets fulfilled from the nearest store and gets delivered to the customer through a third-party logistics company.
- Through OOTB integration features such as [Teams integration with D365 Commerce](https://docs.microsoft.com/dynamics365/commerce/commerce-teams-integration), store managers and frontline workers create task lists, assign tasks to multiple stores, and track the status of tasks across stores, from either application. This can be extended to workers in the warehouses and fulfillment centers and give organizations flexibility to optimize order management and giving their customers a choice across channels.

For flexible fulfillment, we recommend enabling the following TFW apps.

- [Shifts for Teams](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/shifts-for-teams-landing-page)
- [Walkie Talkie](https://docs.microsoft.com/microsoftteams/walkie-talkie)
- [Tasks app](https://docs.microsoft.com/microsoftteams/manage-tasks-app)
- [Lists app](https://docs.microsoft.com/microsoftteams/manage-lists-app)
- [Approvals app](https://docs.microsoft.com/microsoftteams/approval-admin)

## Prequisites

- [Licensing and TFW deployment requirements](../../../../foundations/teams/solutions/tfw/README.md)

## Design Considerations

TFW builds upon MS Teams and inherits platform characterstics for scale; reliability; security; operational aspects; and extensibility from the underlying Teams deployment. Considerations and recommendations for [MS Teams](https://github.com/microsoft/industry/tree/main/foundations/teams) are available here.

The considerations listed here are for TFW apps in the context of flexible fulfillment.

- Consider using [Teams for Retail](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/teams-for-retail-landing-page) guidance.
  - [Retail-specific scenarios](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/teams-for-retail-landing-page#choose-your-scenarios). Common retail scenarios for frontline workers and types of frontline apps to enable are all listed here.
  - [Fundamental aspects in relation to managing accounts and devices](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/teams-for-retail-landing-page#set-up-the-fundamentals)
  - [Setting up teams and apps for retail](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/teams-for-retail-landing-page#set-up-teams-and-apps)

- Consider using [team templates](https://docs.microsoft.com/microsoftteams/get-started-with-retail-teams-templates) as they are designed to help organizations to deploy consistent teams across your organization. Templates also help staff to get oriented with how to effectively use Teams.
- [Shifts app](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/shifts-for-teams-landing-page)
  - [Managing Shifts app](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/shifts/manage-the-shifts-app-for-your-organization-in-teams)
  - Depending on platform (Windows desktop, Mac desktop etc.), features of [Shifts app](https://support.microsoft.com/office/shifts-1aa452d4-14cc-44e7-af2a-bc5a5f381686) may vary.
  - Shifts app ships with out of the box [connectors](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/shifts/shifts-connectors) that allow integration with third-party workflow management applications such as Blue Yonder; Reflexis.
  - Extensibility is enabled via [Shift Graph APIs](https://docs.microsoft.com/graph/api/resources/shift) and [Power Automate](https://github.com/OfficeDev/Microsoft-Teams-Shifts-Power-Automate-Templates).
  - Location and operational activities associated with handling of [Shifts data](https://docs.microsoft.com/microsoftteams/expand-teams-across-your-org/shifts/shifts-data-faq).

- [Walkie Talkie](https://docs.microsoft.com/microsoftteams/walkie-talkie)
  - Walkie Talkie works with Wi-Fi and cellular internet connectivity.
  - It is supported on Android devices with Google Mobile Services (GMS) and iOS.
  - [Networking considerations](https://docs.microsoft.com/microsoftteams/walkie-talkie#network-documentation)
  - [Devices](https://docs.microsoft.com/microsoftteams/walkie-talkie#walkie-talkie-devices) which have been validated to work with Teams Walkie Talkie.
  - Walkie Talkie app honours app policies and that can be used to control who has access to this app.
  - A network (either Wi-Fi or cellular) is required for Walkie Talkie app to work. The app won't work when there's no connectivity.
  - Walkie Talkie uses the same network method used by Teams. If Teams communicates over a cellular network, then Walkie Talkie will also use the same method.
  - One must be connected to a channel to hear any Walkie Talkie communications.
  - One-to-one communication is not available in Walkie Talkie app.

- [Tasks](https://docs.microsoft.com/microsoftteams/manage-tasks-app)
  - Users can access Tasks as an app on the left side of Teams and as a tab in a channel within individual teams. The tab experience displays just the team tasks.
  - Further [considerations](https://docs.microsoft.com/microsoftteams/manage-tasks-app#what-you-need-to-know-about-tasks) for deploying and managing **Tasks**.
  - Settings and policies that you configured for Planner will also apply to Tasks.
  - The Tasks is enabled by default for all Teams users in your organization, however you can [enable or disable it at org level](https://docs.microsoft.com/microsoftteams/manage-tasks-app#enable-or-disable-tasks-in-your-organization) via Microsoft Teams admin center.
  - Tasks can also be [enabled or disabled for specific users](https://docs.microsoft.com/microsoftteams/manage-tasks-app#enable-or-disable-tasks-for-specific-users-in-your-organization) via custom app permission policy.
  - Task publishing requires setting up team [targeting schema](https://docs.microsoft.com/microsoftteams/set-up-your-team-hierarchy).
  - Tasks supports [Power Automate for To Do](https://support.office.com/article/using-microsoft-to-do-with-power-automate-526e8f75-217b-46e0-9e06-44780b72c295) and [Graph APIs for Planner](https://docs.microsoft.com/graph/planner-concept-overview).

- [Lists](https://docs.microsoft.com/microsoftteams/manage-lists-app)
  - Lists is pre-installed for all Teams users and is available directly in the tab gallery of every team and channel.
  - Lists data is stored in the [SharePoint Online team site](https://docs.microsoft.com/microsoftteams/sharepoint-onedrive-interact).
  - Owner and member permissions in a team aren't linked in any way to permissions in the team site that govern the behavior of lists or the Lists App.
  - Considerations for Lists app limitations; administration; and integration with Power Platform and Graph API are listed [here](https://docs.microsoft.com/microsoftteams/manage-lists-app#what-you-need-to-know-about-lists).

- [Teams Approvals](https://docs.microsoft.com/microsoftteams/approval-admin)
  - **Approvals app has a dependency on Dataverse**. Considerations for deploying Power Platform environment at scale are published [here](https://github.com/microsoft/industry/tree/main/foundations/powerPlatform). As a result, if you are planning to use Approvals app, you'll need license for Power Platform in addition to Teams.
  - License for M365 to access MS Forms to design and deploy new approval templates.
  - The Approvals app is available as a personal app for all Microsoft Teams users.
  - The first approval created from the Approvals app will trigger the provisioning of the Approval Solution in the default Microsoft Dataverse environment. Approvals created from the Approvals app will be stored in the default Microsoft Dataverse environment.
  - Considerations for [licensing](https://docs.microsoft.com/microsoftteams/approval-admin#required-permissions-and-licenses); [storage with MS Dataverse](https://docs.microsoft.com/microsoftteams/approval-admin#storage-with-microsoft-dataverse); [app permissions](https://docs.microsoft.com/microsoftteams/approval-admin#storage-with-microsoft-dataverse); [retention policy](https://docs.microsoft.com/microsoftteams/approval-admin#retention-policy); [limitations](https://docs.microsoft.com/microsoftteams/approval-admin#data-limitations); and [auditing](https://docs.microsoft.com/microsoftteams/approval-admin#auditing) are available on Microsoft Docs.
  - Deploy scoped Approval templates. Scope could be at org-level (templates could be either available to everyone in an org or a subset of users across org) OR team-wide (templates will be accessible to members of a team).
  - Org-scoped templates share the same lifetime of the tenant and team-scoped templates share the same lifetime of the team.

## Deployment

There are two deployment experiences available to enable TFW and apps designed for frontline workers.

- [Scripted](https://docs.microsoft.com/microsoftteams/flw-scripted-deployment)

  > Note: The scripts in the link provided above are provided as-is by Microsoft, and must be modified for your individual needs.

- [Wizard](https://docs.microsoft.com/microsoftteams/flw-onboarding-wizard)

# Microsoft Teams for Healthcare

Microsoft Teams offers a number of useful telemedicine features and scenarios useful for hospitals and Healthcare organizations in the context of Microsoft Cloud for Healthcare.
This document outlines recommendations in order to leverage Microsoft Teams across the various *Healthcare* scenarios, as well as a reference architecture and implementation.

| Reference implementation | Description | Deploy |
|:----------------------|:------------|--------|
| Microsoft Teams for Healthcare | Microsoft Teams environment with recommended policies, templates and integrations enabled for Healthcare|[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)]()


## Prerequisites

> The content in this section assumes that you've already deployed Teams in your organization. If you haven't yet rolled out Teams, start by reading [How to roll out Microsoft Teams](https://docs.microsoft.com/en-us/microsoftteams/deploy-overview)
### Licensing
- [For licensing, see the prequisites](../prereqs.md)

### Permissions

The following [Azure AD roles](https://docs.microsoft.com/en-us/azure/active-directory/roles/permissions-reference) are required to configure the various healthcare scenarios:

-   Teams deployment/configuration: Teams administrator

-   [Enable Microsoft Bookings](https://docs.microsoft.com/en-us/microsoft-365/bookings/turn-bookings-on-or-off?view=o365-worldwide) (one-off tenant wide setting): Global Administrator

## Recommendations
### Policies

Before implementing any Teams related Healthcare scenario, it is recommended to review and apply relevant policy types as outlined below to control the Teams experience for different personas. Policies can be assigned to three different scopes, Global (org-wide default), group or user level. In line with general identity and access management best practices, it is always recommended to assign policies in Teams to Azure AD groups and not individual users. Thus, it is key to have well-defined groups for the different personas to be targeted by the various policies before starting with assignments.

Note: An individual user can only have one effective policy for each policy type - details about policy precedence can be found [here](https://docs.microsoft.com/en-us/microsoftteams/assign-policies#which-policy-takes-precedence).

To simplify policy assignment in Healthcare scenarios, Teams currently includes a number of [policy packages](https://docs.microsoft.com/en-us/microsoftteams/policy-packages-healthcare) aligned with typical Healthcare personas. A policy package is a collection of policies and settings that can be applied to a group of users. They can either be assigned as-is or customized to fit specific regulatory requirements etc.

#### Teams policies

Teams and channel policies are used to control what settings or features are available to users when they are using teams and channels. You can use the Global (Org-wide default) policy and customize it or create one or more custom policies for those people that are members of a team or a channel within your organization.

[Manage teams policies in Microsoft Teams - Microsoft Teams \| Microsoft Docs](https://docs.microsoft.com/en-US/microsoftteams/teams-policies?WT.mc_id=TeamsAdminCenterCSH)

#### Template policies

Teams template policies let you create and set up policies for people in your organization so they can see only certain templates -- for example the specific [Teams templates for healthcare organizations](https://docs.microsoft.com/en-us/microsoftteams/expand-teams-across-your-org/healthcare/teams-in-hc#teams-templates-for-healthcare-organizations).

[Manage team templates in the admin center - Microsoft Teams \| Microsoft Docs](https://docs.microsoft.com/en-us/microsoftteams/templates-policies)

#### Messaging policies

Messaging policies are used to control what chat and channel messaging features are available to users in Teams.

[Manage messaging policies in Teams - Microsoft Teams \| Microsoft Docs](https://docs.microsoft.com/en-US/microsoftteams/messaging-policies-in-teams?WT.mc_id=TeamsAdminCenterCSH)
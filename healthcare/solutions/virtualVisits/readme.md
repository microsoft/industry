# Virtual visits

A growing large number of patients prefer to visit their medical providers virtually rather than in person, whenever possible.
Virtual visits use the complete meetings platform in Teams to schedule, manage, and conduct virtual appointments with patients in scenarios such as:

- Scheduling virtual follow-ups to in person visits.
- Providing non-emergency medical guidance to patients while traveling.

| Reference implementation | Description | Deploy |
|:-------------------------|:------------|--------|
| Virtual visits              | Virtual visits scenario to schedule, manage, and conduct virtual appointments with patients |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://aka.ms/solutioncenter-healthcare) |

## Design Considerations

- If the organization already uses Electronic Health Records (EHR), Teams can be integrated with the EHR for a more seamless experience.
  - Currently only [Cerner](https://docs.microsoft.com/en-us/microsoftteams/expand-teams-across-your-org/healthcare/ehr-admin-cerner) and [Epic](https://docs.microsoft.com/en-us/microsoftteams/expand-teams-across-your-org/healthcare/ehr-admin) EHRs are supported.
- If the EHR is not supported, you can enable the scenario standalone using [Microsoft Bookings](https://docs.microsoft.com/en-us/microsoftteams/expand-teams-across-your-org/bookings-virtual-visits) and the Bookings app in Teams.
- All users of the Bookings app and all staff participating in meetings must have a [license](https://docs.microsoft.com/en-us/microsoftteams/bookings-app-admin#prerequisites-for-using-the-bookings-app-in-teams) that supports Teams Meeting scheduling.
- Bookings can be turned on or off for your entire organization or for specific users. Groups are not supported.
- Consider the [difference in feature set](https://docs.microsoft.com/en-us/microsoft-365/bookings/comparison-chart?view=o365-worldwide) in Bookings web vs. Bookings Teams app when selecting client for different personas.

## Design Recommendations

- Evalute if [social sharing](https://docs.microsoft.com/en-us/microsoft-365/bookings/turn-bookings-on-or-off?view=o365-worldwide#turn-bookings-on-or-off-for-individual-users) options should be enabled or not in Bookings.
- To enable the best experience for Bookings, create a [Teams meeting policy](https://docs.microsoft.com/en-us/microsoftteams/meeting-policies-participants-and-guests#automatically-admit-people) to automatically admit Everyone in your organization and assign the policy to your staff.
- Change the [default domain for Bookings mailboxes](https://docs.microsoft.com/en-us/microsoftteams/bookings-app-admin#changing-your-default-domain-when-setting-up-bookings-mailboxes) to ensure invitations do not end up in recipient's junk folder.
- Create a [Teams app setup policy](https://docs.microsoft.com/en-us/microsoftteams/teams-app-setup-policies) to pin the Bookings app in Teams.

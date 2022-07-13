# Microsoft Teams for Industries

Microsoft Teams is an integral component for many industry-specific scenarios in Healthcare, Retail, Government, etc.

Recommendations and guidance on Microsoft Teams deployment in the enterprise is documented in the [Teams documentation](https://docs.microsoft.com/en-us/microsoftteams/deploy-enterprise-overview)

| Reference implementation | Description | Deploy |
|:----------------------|:------------|--------|
| Microsoft Teams for Industries | Coming soon| Coming soon

## Expanding Teams across an organization

The following resources and integrations build upon the standard Teams deployment guidance and are designed to help you get the most out of Teams for specific organization types and industries. These are not separate applications but build upon capabilities of Microsoft Teams.

The table below provides a short summary of key differences and licensing requirements.

- [Teams for Frontline Workers](./solutions/tfw/README.md)
- [D365 Commerce integration with Teams](./solutions/d365commTeams/README.md)
- [D365 integration with Teams](./solutions/d365Teams/README.md)

||D365 Commerce Integration with MS Teams|Teams for Frontline Workers|D365 Integration with Teams|
|:-|:-|:-|:-|
|Goals|Dynamics 365 Commerce integration with Teams enables customers and their employees to improve productivity by synchronizing task management between the two applications.<br/><br/>The seamless task management that Commerce and Teams integration provides lets store managers and employees create task lists, assign tasks to multiple stores, and track the status of tasks across stores, from either application.<br/><br/>|Frontline workers are employees whose primary function is to work directly with customers or the general public providing services, support, and selling products, or employees directly involved in the manufacturing and distribution of products and services.<br/><br/>Microsoft 365 for frontline workers is optimized for a mobile workforce that primarily interacts with customers, but also needs to stay connected to the rest of your organization.|Enables 2-way integration of D365 apps with Teams and vice-versa.<br/><br/>Dynamics 365 and Microsoft Teams integration allows you to speed up the flow of work, enabling anyone in an organization to view and collaborate on Dynamics 365 records, from within the flow of work with Teams at no additional cost <br/><br/>Using Teams integration, you can invite anyone in the organization to view and collaborate on customer records right within a Teams chat or channel. You can also make and receive calls from within Dynamics 365 and get the work done more effectively.
|Prerequisites|Microsoft 365 Business Standard License (This license includes Teams.)<br/><br/>Azure Active Directory (Azure AD) accounts for all store managers and workers.<br/><br/>Point of sale (POS) systems that are configured with Azure AD authentication.|Teams licenses for Frontline workers listed below.|In addition to a Teams license, D365 app license for one of the supported apps.<br/><br/>Dynamics 365 Sales, Dynamics 365 Customer Service, Dynamics 365 Field Service, Dynamics 365 Marketing, and Dynamics 365 Project Service Automation
|Licensing requirements|Microsoft 365 Business Standard License (This license includes Teams). <br/><br/>D365 Commerce license.|M365 F1 or M365 F3 or O365 F3 licenses|Microsoft 365 Business Standard License (This license includes Teams.)<br/><br/> D365 licenses.|
|Features||Activity<br/>Chat<br/>Teams<br/>Walkie Talkie<br/>Tasks<br/>Shifts<br/>Approvals<br/>RealWear|Bidirectional integration between specific D365 apps and MS Teams.<br/><br/>Teams can be integrated with Dynamics 365 Sales, Dynamics 365 Customer Service, Dynamics 365 Field Service, Dynamics 365 Marketing, and Dynamics 365 Project Service Automation.<br/><br/>Full list of bidirectional features is published [here.](https://docs.microsoft.com/en-us/dynamics365/teams-integration/teams-integration)
|||

## Design areas

Use the guidelines in the following Teams design areas article series to help you translate your requirements to Teams constructs and capabilities.

* [Security, Privacy and Compliance](https://docs.microsoft.com/en-us/microsoftteams/security-compliance-overview)

* [Management and monitoring](https://docs.microsoft.com/en-us/microsoftteams/manage-teams-overview)

* [Chat, teams and channels](https://docs.microsoft.com/en-us/microsoftteams/deploy-chat-teams-channels-microsoft-teams-landing-page)

* [Meetings and conferencing](https://docs.microsoft.com/en-us/microsoftteams/deploy-meetings-microsoft-teams-landing-page)

* [Voice - Phone and PSTN Connectivity](https://docs.microsoft.com/en-us/microsoftteams/cloud-voice-landing-page)

* [Devices and rooms management](https://docs.microsoft.com/en-us/microsoftteams/rooms/)

* [Apps, bots and connectors](https://docs.microsoft.com/en-us/microsoftteams/deploy-apps-microsoft-teams-landing-page)

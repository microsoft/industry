# Patient service center

Patient service center enables your organization to engage with your patients in the way they want, by using chat, and monitor automatic conversations through the Microsoft Azure Healthbot service. Service agents can help your patients with information and setting up appoints.

Patient service center builds on Power Platform, Dynamics 365 Customer Service and its Digital Messaging Add-in to provide healthcare-specific capabilities.

Further, Patient service center can be integrated with [Patient access portal](../patientAccess) to create a direct channel for your patients and automate conversations using the Healthbot.

| Reference implementation | Description | Deploy |
|:----------------------|:------------|--------|
| Compliant Azure Healthbot | End-to-end deployment and configuration of a compliant Azure Healthbot for integration with Omnichannel and Patient service center, and Patient Access portal |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2FhealthcareArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2Fhealthcare-portal.json)

>Note: The implementation of the Patient service center solution can currently not be automated, and requires manual implementation and configuration across Solution Center, Power Platform Admin Center, and portal for Power Apps. See the [implementation guide](#implementation-guide-for-patient-service-center) for detailed instructions.

![PatientSerivceCenter](./images/overview.png)

Before you deploy and configure, verify you have implemented the [prerequisites](../../prereqs.md).

Specifically for Patient service center, you need:

* [Power Platform environments](../../../foundations/powerPlatform/)
  * Must be created upfront, in United States with Dataverse and D365 Apps enabled
  * If you plan to integrate with Patient Access Portal, see the [pre-requisites](../patientAccess/) for this scenario.
  * Dynamics 365 Customer Service
  * Digital Messaging add-in for Dynamics 365 Customer Service

## Planning guidelines for Patient service center

This section provide prescriptive guidance with design considerations and recommendations across the critical design areas for Patient service center scenario for the teams that will deploy and manage these specific capabilities within the Microsoft Cloud for Healthcare.

* [Identity and access](#identity-and-access)
* [Monitoring](#monitoring)
* [Security](#identity-and-access)

## Identity and access

### Design considerations

* For a complete setup of the Patient service center scenario, the persona(s) doing the setup and configuration requires permissions across Azure AD, Azure (landing zone subscription), Power Platform, and Microsoft teams.
* Azure Healthbot is an Azure resource provided by the "Microsoft.Healthbot" Resource Provider. To register this resource provider, the user must at least be *Contributor* (RBAC) on the landing zone subscription(s).
* Users accessing the Healthcare applications - such as the Patient service center need to be explicitly added to the security group in the Power Platform environments.
* Healthcare Bot and Omnichannel integration requires an AD Application with read permissions to several MS Graph APIs.
* To configure and manage Omnichannel, the user/group/application must be added explicitly to the built-in roles for Omnichannel once the solution has been deployed, in the Power Platform environment

### Design recommendations

* Ensure the right permission are assigned upfront before installing and enabling the Patient service center solution. If there's clear separation of concerns within the organization to carry out these tasks across Power Platform, Azure, and Microsoft Teams, ensure the required personas are involved and engaged to adhere to the required deployment sequence.
* Create dedicated Azure AD Groups to maintain access to the Healthcare applications such as Patient service center. This AAD group must be mapped towards the built-in *Healthcare users* role in the Power Platform environments.
* For Omnichannel configuration and management, users, groups, and applications (e.g., chat bots etc.) should be mapped directly to the built-in Omnichannel security roles in the environment, such as Administrator, Agent, or Operator.
* Create a dedicated AD Application for Healthcare Bot and Omnichannel integration. For dev, test, and production scenarios, ensure you are using dedicated applications for this.

## Monitoring

### Design considerations

* Microsoft Azure Health Bot does not provide a diagnostic setting similar to other Azure resources.
* All writes (create, update, and delete) operations towards the Healthcare Bot service from an Azure control plane perspective is logged in the Azure Activity log for 90 days
* Azure AD sign-ins and operations are logged to the Azure AD logs.

### Design recommendations

* Use dedicated Application Insights instances per Healthcare Bot environment, and persist the data in an associated Log Analytics workspace.
* Capture Azure Activity Logs from the subscription into the dedicated Log Analytics workspace.
* Enable Data export from the Power Platform environment to capture diagnostics for the Dataverse instance in the Environment for Healthcare solutions, into the dedicated Application Insights instance.
* If integrating with Patient access portal app, ensure the portal is also ingesting metrics and logs to the dedicated Application Insights instance.

## Security

### Design considerations

* Azure Health Bot is a multi-tenant service in Azure, where the infrastructure and runtime is being managed by Microsoft and is HIPAA compliant alongside with multiple other certifications.
* Azure Health Bot stores customer data in Azure storage and Azure Cosmos DB and is always encrypted at rest, where the encryption keys are managed by Microsoft.
* All communication (inbound and outbound) with the Health Bot service happens over HTTPS, ensuring data in transit is also always encrypted.

### Design recommendations

* The Application Id for the Healthcare Bot integration must be added to the 'Omnichannel agent' built-in security role in the Environment where the Healthcare solution is deployed.
* Map Azure AD Group to the requisite built-in roles for Omnichannel in the Power Platform environment where the Healthcare solutions are deployed.
* For Patient access integration, ensure portal authentication is configured to your chosen identity provider.
* Use Azure AD PIM to ensure no standing access to the Azure Health Bot service.
* Create an Azure AD Group with users who should have access to the Azure Health Bot Service.
* For Patient access integration, restrict portal access from a list of IP addresses and CIDR ranges to limit portal access as described on this [article](https://docs.microsoft.com/powerapps/maker/portals/admin/ip-address-restrict).
* For Patient access integration, create required policies and flows for user sign-up if integrating the portal application with Azure AD B2C

## Implementation guide for Patient Service Center

The following instructions will guide you to how to install and configure the Patient service center across Azure, Power Platform, and Microsoft Teams.

1. Patient service center will be deployed from the Microsoft Solution Center, but prior to that an environment with the pre-requisites must be deployed. Please refer to the [North Star Architecture for Power Platform](../../../foundations/powerPlatform) to ensure you have a compliant, production ready environment before you start.
Further, Dynamics 365 Customer Service and Digital Messaging add-in for Dynamics 365 Customer Service must be pre-provisioned and configured into the target environment(s).

2. For the environment you will enable the Patient service center scenario, you must first enable the *Customer Service Hub (CRM Hub)* solution as this is a pre-requisite for the Omnichannel setup you will complete later.

>Note: If your environment has been created after October 1st 2021, this is already pre-loaded in your environment and this step is not required. If the enviornment was created before this date, you must navigate to [Admin portal for Power Platform](https://admin.powerplatform.com), select *Resources* --> *D365 Apps* --> and install *Microsoft Dynamics 365 CRM Hub*

3. To configure Omnichannel for Customer Service, you must [provide data access consent](https://go.microsoft.com/fwlink/p/?linkid=2070932) as a user being Global Tenant Admin and select *Consent on behalf of your organization* checkbox.

![consent](./images/consent.png)

4. When the consent has been granted, navigate to [Admin portal for Power Platform](https://admin.powerplatform.com), select *Resources* --> *D365 Apps* --> and locate *Omnichannel for Customer Service*

![omnichannel](./images/omnichannel.png)

Click on the *...* button and select *Manage*. This will take you to the Dynamics 365 apps admin page to start the setup.

![d365](./images/d365.png)

5. In the *Dynamics 365 Administration Center*, select *+Add environment* and ensure you are using the same environment you will be using for the Patient Service Center deployment later. Once selected, you can enable the capabilities you require for your setup. For now, we are enabling *Chat*, *SMS*, and *Microsoft Teams*. You can visit the *Dynamics 365 Administration Center* later if you want to enable further capabilities.

![omnisetup](./images/omnisetup.png)

Once you have confirmed the selection, Omnichannel setup will start and can take a few hours to complete.

![setupstatus](./images/setupstatus.png)

6. Once the setup has completed, you need to start the deployment of the *Patient service center* solution using the [Microsoft Cloud Solution Center](https://solutions.microsoft.com). Ensure you are targeting the same Power Platform environment as used for Customer Service and omnichannel. The deployment can take one or more hours.

![solution](./images/solution.png)

## Integrate chat in Omnichannel with Patient Access Portal

When the *Patient service center* has deployed, additional configuration is required to configure chat functionality and integrate this with the *Patient access portal*.

### Configure RBAC for Omnichannel agents

1. Ensure RBAC is configured for the agents that will interact with patients over chat in the Power Platform environment by accessing the *users* in the settings of the environment in the [admin center](https://admin.powerplatform.com).

![settings](./images/settings.png)

Locate the user(s), and map them to the required security roles. *Omnichannel agent* security role is required to use the integrated chat functionality. For other admin purposes, you can map this as required. Note that the user who need to perform the remaining steps of the configuration must have the *Omnichannel administrator* role in the environment.

![agent](./images/agent.png)

### Create and configure queues

2. In the [maker portal](https://make.powerapps.com), select the environment you have deployed the Patient access solution to, and you should see the following apps related to Omnichannel:

![omniapps](./images/omniapps.png)

To configure the chat functionality, open the *Omnichannel Administration* app and go to *Users* in the *Queues & Users* section and verify that the users you mapped to the *Omnichannel agent* security role in the environment is listed. Note: it can take 10-15 minutes before the security role mapping has propagated into Dataverse.

![users](./images/users.png)

3. After verifying that the users are present, you can either use the default messaging queue in Omnichannel, or create a new one. In this guide, we will use the default. Open the default messaging queues, and click on *Add existing User* to add the users who will act as agents and save.

![exusers](./images/exusers.png)

### Create chat widget

4. All the channels you created when deploying Omnichannel is listed under the *Channels* section in the portal. Go to *Chat* and create a new.

5. Provide a name, and open the *Live chat workstream* in the *Work distribution* section.

![workstream](./images/workstream.png)

6. Go to *Routing Rules* and create a new routing rule. This will determine where the chats will be routed when initiated by the patients. Provide a name, and select the queue created earlier and click save (or use the default messaging queue if you are following this specific guidance).
For additional scenarios such as leveraging a bot and hand over to an agent (depending on how the bot is being configured), this is where you will have additional routes that acts based on the conditions you specify in each routing rule.

![route](./images/route.png)

7. Once saved, you should see the *Code snippet* to integrate with the Patient access portal.

### Update Patient access portal with chat functionality

8. Copy the code snippet, and open the *Site settings* of the Patient access portal in the [maker portal](https://make.powerapps.com).

![sitesettings](./images/sitesettings.png)

9. Go to *Content Snippets* and open the *Chat Widget Code* for the *Healthcare Patient Portal* website.

![widgetcontent](./images/widgetcontent.png)

10. Select *HTML* and paste the snippet from the Chat Widget you created earlier. Once done, you must save and reboot the portal.

![html](./images/html.png)

11. Reboot ther portal by opening the *Administration* settings from within the [maker portal](https://make.powerapps.com)

![adminsettings](./images/sitesettings.png)

Select *Portal Actions* and *Restart*. This will take a few minutes before the portal can start serving requests.

### Validate chat integration in Patient access portal and Omnichannel

Once the integration is completed, you can validate the chat functionality from the Patient access portal into the *Omnichannel for Customer Service* application.

1. First, open the *Omnichannel for Customer Service* application as a user who has the *Omnichannel agent* role to ensure that an agent is available before initiating the chat from the Patient acces portal. Once signed in, you should see the agent's availability. This is where agents can set their own status, and depending on how the Chat widget was configured, it can determine whether they should be available or not given their status.

![agentstatus](./images/agentstatus.png)

2. Access the Patient access portal (you can select *Browse* directly from within the maker portal to launch it) and verify you can see the *Let's Chat!* icon at the lower right corner. Open it and verify that a session is being initiated.

![patientchat](./images/patientchat.png)

When the session has started, the agents will see an incoming chat request in the *Omnichannel for Customer Service* application, and can determine if they will accept or reject the request. Once accepted, the chat between the patient and agent can start.

![request](./images/request.png)

## Integrate Patient service center with chat functionality using Microsoft Azure Health Bot

*Coming soon!*

<!-- Organization who want to leverage built-in AI functionality and integrate with the Microsoft Azure Health Bot to enable AI-powered virtual health assistants. This will provide an intelligent and personalized access to health-related information and interactions through a natural conversation experience.

The bot will handle simple patient questions in the portal of the [Patient access](../patientAccess) solution (or any other website). For complex questions you can instrument the Health bot service to hand off the conversation to professional care coordinators in the Patient service center.

1. Deploy a Microsoft Azure Health Bot into a compliant landing zone (Azure). You can use the reference implementation provided here to ensure it is fully configured, secured, and monitored.

2. Post deployment, navigate to the *management portal* of the Health bot, go to *Configuration*, *Conversation* and select *Human Handoff*. Here you must toggle the *Dynamics 365 OmniChannel* option to bridge messages.

![botconfig](./images/botconfig.png)

3. Create a Bot user, add the bot user to the queues in Dynamics 365 Omnichannel and set the escalation rules.

To create the bot user, navigate to channels in the *management portal* of your Healthcare Bot. Select *Integration*, *Channels*, and set *Microsoft Teams* to active if not done already, and click *View*. This will show the Bot id. Copy this id to your clipboard.

![botid](./images/botid.png)

In the Power Platform [admin center](https://admin.powerplatform.com), locate the enviornment where you have deployed the solutions, and open *Settings*, select *Security*, and *Users*.

Select *Application Users* and create a new, where you enter or select the following:

* User Name: User name of the Bot (this will not be displayed in the chat-widget)
* Application Id: An application ID for any valid (non-expired) application created in Azure Active Directory. -->

---

[Back to documentation root](../../../README.md)
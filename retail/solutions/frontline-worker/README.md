# Real-time store communications and collaboration

## Table of Contents

- [Microsoft Teams Integration with D356 Commerce](#microsoft-teams-integration-with-d365-commerce)
  - [Table of Contents](#table-of-contents)


## Microsoft Teams Integration with D356 Commerce

[Dynamics 365 Commerce is integrating with Microsoft Teams](https://docs.microsoft.com/en-us/dynamics365/teams-integration/teams-integration) to help customers and their employees improve productivity by synchronizing task management between the two applications. The seamless task management that Commerce and Teams integration provides let store managers and employees create task lists, assign tasks to multiple stores, and track the status of tasks across stores, from either application.

### Capabilities


Here are some of the key features that the Commerce and Microsoft Teams integration provides:

- Provision Teams by taking advantage of well-defined information from Commerce, such as the organizational structure and information about stores, workers, permissions, and business context.

- Easily synchronize ongoing changes (for example, the addition of new stores or hiring of new employees) between Commerce and Teams, but keep Commerce as the master source of organizational structure data.

- Integrate task management between Commerce and Teams to help store workers, store managers, regional managers, and communications managers handle task management from either application.

### Architecture

![Teams Integration Architecture](./retail/media/secret-value.pngTeamsIntegration-Architecture.png)

### Terminology



### Service flow

*Coming soon*

### FAQ

*Coming soon*

## Considerations

*Coming soon*

## Recommended Practices

*Coming soon*

## Deployment guide

This deployment guide provides detailed steps on how to setup the Microsoft Teams Integration with D365 Commerce. First you it will require a App registration with Azure Active Directory and the required set of permissions that will allow enabling the integration between D365 Commerce and Teams Task Management App. 

### Prerequisites 

* D365 Commerce 
* Microsoft Teams 
* Azure Active Directory App Registration


### App Registration and Permissions

* App Registration with Azure Active Directory

1. In the Azure Portal search bar, search for “Active Directory”, the Azure Active Directory will show up in the services. Choose it to Open Azure Active Directory. 

![Search Azure AD](./retail/media/secret-value.pngsearch-azure-ad.png)

2. In the Azure Active Directory, Click on App registrations

![Search Azure AD](./retail/media/secret-value.pngazure-ad-registration.png)

3. In the App registrations, click on add New registration. 

![New App Registration](./retail/media/secret-value.pngnew-registration.png)

4.	Name the App registration as “Microsoft Teams Commerce” 

5.	Under Supported account types: Choose “Accounts in this organizational directory only” (Microsoft only – Single tenant)

6.	Under Redirect URI: Select Web and provide the Commerce Finance and Operations URL and add the “oath” suffix.  The full URL should look like https://fabrikam.sandbox.operations.dynamics.com/oath

7.	Click in Register to complete. 

![App Registration Name](./retail/media/secret-value.pngapp-registration-name.png)

**Important**

8.	Save the Application (client) ID in the text editor of your preference. It will be used in later steps. 

![App Client ID](./retail/media/secret-value.pngapp-client-id.png)


### Add a Secret to the registered App

1. In the Microsoft Teams Commerce registered App. Click in Certificates & Secrets 

![App Secret](./retail/media/secret-value.pngapp-secret.png)

2. Click Add New Client Secret 

![New Secret](./retail/media/secret-value.pngnew-secret.png)

3. In the Description, provide a name of your choice for the client secret and click Add. 

![Secret Description](./retail/media/secret-value.pngsecret-description.png)

4. Copy the key value generated for the client secret and save it in and text editor of your choice. The client secret value will be used in future steps. After closing this window, it will not be possible to retrieve the key again and it will require generating a new client secret. 

![Secret-Value](./retail/media/secret-value.pngsecret-value.png)


### Adding API permissions to the registered App 

1.	Click on API permissions in the left tab, then click on + Add a permission

![Registered App Permissions](./retail/media/secret-value.pngregisteredapp-permissions.png)

2.	In the Request API permissions pop-up and select Microsoft Graph.

![request api permissions](./retail/media/secret-value.pngrequest-api-permissions.png)

3.	Select Delegated permissions, then in Select permission type Group to filter results. 

4.	Under Group and check Group.ReadWrite.All, then click Add permissions button.  

![graph-group-permissions](./retail/media/secret-value.pnggraph-group-permissions.png)

5.	Click on + Add permission again to add additional permissions. 

![App api permissions](./retail/media/secret-value.pngapp-api-permissions.png)

6.	In the Request API permissions pop-up and choose Microsoft Graph.

![msgraph API- Permissions](./retail/media/secret-value.pngmsgraph-api-permissions.png)

7.	Select Application permissions

![Application Permissions](./retail/media/secret-value.pngapplication-permissions.png)

8.	With Application permissions selected, then in Select permissions search field type Group to filter results. 

9.	Click in Group to expand and check Group.ReadWrite.All, then click Add permissions button.  


**** Working in Progress 


# Retail workforce management

## Table of Contents

- [Dynamics 365 Commerce and Microsoft Teams integration](#dynamics-365-commerce-and-microsoft-teams-integration)
  - [Table of Contents](#table-of-contents)

## Dynamics 365 Commerce and Microsoft Teams integration

[Dynamics 365 Commerce is integrated with Microsoft Teams](https://docs.microsoft.com/dynamics365/teams-integration/teams-integration) to help customers and their employees improve productivity by synchronizing task management between the two applications. Seamless integration between D365 Commerce and Microsoft Teams simplifies task management, and it enables store managers and employees create task lists, assign tasks to multiple stores, and track the status of tasks across stores, from either application.

## Prerequisites

- D365 Commerce
- Microsoft Teams - Microsoft 365 Business Standard License

### Key Capabilities and Architecture

D365 Commerce and Microsoft Teams Integration key features.

- Provision Teams by taking advantage of well-defined information from Commerce, such as the organizational structure and information about stores, workers, permissions, and business context.

- Easily synchronize ongoing changes (for example, the addition of new stores or hiring of new employees) between Commerce and Teams, but keep Commerce as the master source of organizational structure data.

- Integrate task management between Commerce and Teams to help store workers, store managers, regional managers, and communications managers handle task management from either application.

![Teams Integration Architecture](./media/TeamsIntegration-Architecture.png)

## Considerations and Recommendations

## Deployment Steps

This deployment guide provides detailed steps on how to setup the Microsoft Teams Integration with D365 Commerce. First you it will require a App registration with Azure Active Directory and the required set of permissions that will allow enabling the integration between D365 Commerce and Teams Task Management App.

- Azure Active Directory App Registration

### App Registration and Permissions

- App Registration with Azure Active Directory

1. In the Azure Portal search bar, search for “Active Directory”, the Azure Active Directory will show up in the services. Choose it to Open Azure Active Directory.

    ![Search Azure AD](./media/search-azure-ad.png)

1. In the Azure Active Directory, Click on App registrations

    ![Search Azure AD](./media/azure-ad-registration.png)

1. In the App registrations, click on add New registration.

![New App Registration](./media/new-registration.png)

1. Name the App registration as “Microsoft Teams Commerce”

1. Under Supported account types: Choose “Accounts in this organizational directory only” (Microsoft only – Single tenant)

1. Under Redirect URI: Select Web and provide the Commerce Finance and Operations URL and add the “oath” suffix.  The full URL should look like `https://fabrikam.sandbox.operations.dynamics.com/oath`

1. Click in Register to complete.

    ![App Registration Name](./media/app-registration-name.png)

1. Save the Application (client) ID in the text editor of your preference. It will be used in later steps.

    ![App Client ID](./media/app-client-id.png)

### Add a Secret to the registered App

1. In the Microsoft Teams Commerce registered App. Click in Certificates & Secrets

    ![App Secret](./media/app-secret.png)

1. Click Add New Client Secret.

    ![New Secret](./media/new-secret.png)

1. In the Description, provide a name of your choice for the client secret and click Add.

    ![Secret Description](./media/secret-description.png)

1. Copy the key value generated for the client secret and save it in and text editor of your choice. The client secret value will be used in future steps. After closing this window, it will not be possible to retrieve the key again and it will require generating a new client secret.

    ![Secret-Value](./media/)

### Adding API permissions to the registered App

1.Click on API permissions in the left tab, then click on + Add a permission

    ![Registered App Permissions](./media/registeredapp-permissions.png)

1. In the Request API permissions pop-up and select Microsoft Graph.

    ![request api permissions](./media/request-api-permissions.png)

1. Select Delegated permissions, then in Select permission type Group to filter results.

1. Under Group and check Group.ReadWrite.All, then click Add permissions button.  

    ![graph-group-permissions](./media/graph-group-permissions.png)

1. Click on + Add permission again to add additional permissions.

    ![App api permissions](./media/app-api-permissions.png)

1. In the Request API permissions pop-up and choose Microsoft Graph.

    ![msgraph API- Permissions](./media/msgraph-api-permissions.png)

1. Select Application permissions

    ![Application Permissions](./media/application-permissions.png)

1. With Application permissions selected, then in Select permissions search field type Group to filter results.

1. Click in Group to expand and check Group.ReadWrite.All, then click Add permissions button.  

    ![Group Read Write](./media/group_read_write.png)

1. In API permissions, click + Add Permission.

    ![API Permission](./media/api-permissions.png)

1. In the Request API permissions pop-up, select APIs my organization uses tab, then search for Microsoft Teams Retail Service and click on it.

    ![Request API permissions](./media/request-api-permissions.png)

1. Select **Delegated permissions**

     ![Delegated Permissions](./media/delegated-permissions.png)

1. Click on **TaskPublishing** to expand, check **TaskPublishing.ReadWrite.All**, then click **Add permissions** button.

  ![Delegated Permissions](./media/selectdelegatedpermissions.png)

### Configure registered application to expose a web API

1. In Azure Portal go to Azure Active Directory

1. App registrations, and then select your API's app registration.

  ![Owned Applications](./media/owned-applications.png)

1. Select Expose an API and then Add a scope.
     ![Owned Applications](./media/expose-api.png)

1. You can use the default value provided, which is in the form api://`<application-client-id>`, or specify a more readable URI like `https://contoso.com/api`.

    ![Owned Applications](./media/add-scope.png)

1. Click save and Continue
1. In Add a Scope page fill the form with the following values:

    ![Owned Applications](./media/add-scope-values.png)

1. Add another scope by clicking in Add Scope and use the following values.

| Property            | Value |
| ----------------- | ----------- |
| Scope name        | Employees.Write.All |
| Who can consent   | Admins only       |
| Admin consent display name   | Write access to records|
| Admin consent description   | Allow the application to have write access to all Employee data.      |

1. Leave the remaining fields empty and make sure the state is set to Enabled.
1. Click Add Scope

1. The final result should be similar to the picture below.

       ![Owned Applications](./media/final-scopes.png)

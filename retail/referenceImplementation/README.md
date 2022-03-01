# Microsoft Cloud for Retail User Guide

This guide goes through the details of the reference implementation of a set of services and products across Microsoft Cloud to enable retail use-cases. The documentation will cover in detail the considerations, recommendations and implementaion details in deploying cross-cloud landing zone for retail-specific scenarios.

## Table of Contents

- [Microsoft Cloud for Retail User Guide](#microsoft-cloud-for-retail-user-guide)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
    - [Azure](#azure)
      - [Elevate Access to manage Azure resources in the directory](#elevate-access-to-manage-azure-resources-in-the-directory)
    - [Microsoft Cloud Solution Center](#microsoft-cloud-solution-center)
  - [Deployment instructions](#deployment-instructions)
    - [Deploy Azure resources](#deploy-azure-resources)
    - [Enable MCR products and services via Microsoft Solution Center](#enable-mcr-products-and-services-via-microsoft-solution-center)

---

## Overview

The reference implementation of retail on Microsoft Cloud leverages products and services delpoyed across Azure and Microsoft Cloud for Retail (MCR).

For most part, the deployment experience for reference implementation is automated, however parts of the deployment require manual inputs from an administrator specifically products and services provisioned through [MCR Solution Center](https://docs.microsoft.com/en-us/industry/solution-center-deploy?toc=/industry/retail/toc.json&bc=/industry/retail/breadcrumb/toc.json).

## Prerequisites

There are two distinct parts of the deployment - Azure and Solution Center. The section talks to the privileges required to deploy the solution.

### Azure

The user making the deployment requires the "Owner" permission at the Azure tenant root scope. The following instructions explains how a Global Admin in the Azure Active Directory can elevate a role to the appropriate permissions prior to starting the deployment.

The pre-requisites requires the following:

- A user that is Global Admin in the Azure Active Directory where Azure landing zones for retail will be deployed.
- Elevation of privileges of a Global Admin to "User Access Administrator" role at the tenant root scope.
- An explicit role assignment (Azure RBAC) made at the tenant root scope via Azure CLI or Azure PowerShell (Note: There's currently no graphical user interface to make this role assignment).

#### Elevate Access to manage Azure resources in the directory

1.1 Sign into the Azure portal as the user being Global Admin.

1.2 Open Azure Active Directory.

1.3 Under 'Manage', select 'Properties'.

![properties](./media/properties.PNG)

1.4 Under 'Access management for Azure resources' set the toggle to *Yes.

![elevate](./media/elevate.PNG)

Grant explicit access to the User at the tenant root scope ("/") to deploy Azure for Healthcare

You can use either Bash (Azure CLI) or PowerShell (Az.Resources) to create the role assignment for user that will do the deployment.

Bash:

```bash
#sign  into AZ CLI, this will redirect you to a web browser for authentication, if required
az login

#assign Owner role to Tenant root scope  ("/") as a Owner (gets object Id of the current user (az login))
az role assignment create --scope '/'  --role 'Owner' --assignee-object-id $(az ad signed-in-user show --query "objectId" --output tsv)
```

Powershell:

```powershell
#sign in to Azure  from Powershell, this will redirect you to a web browser for authentication, if required
Connect-AzAccount

#get object Id of  the current user (that is used above)
$user = Get-AzADUser -UserPrincipalName (Get-AzContext).Account

#assign Owner  role to Tenant root scope ("/") as a User Access Administrator
New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId $user.Id
```

> Please note: it can take up to 15 minutes for permission to propagate at tenant root scope. It is therefore recommended that you log out and log back in to refresh the token before you proceed with the deployment.*

### Microsoft Cloud Solution Center

- You must have a Microsoft account.
- You must be a Microsoft Power Platform admin, Dynamics 365 admin, or a tenant admin.
- You must have licenses for the solutions and apps you’re deploying. If your organization doesn't have the necessary licenses, you’ll be notified during the deployment process.

## Deployment instructions

### Deploy Azure resources

*coming soon*

### Enable MCR products and services via Microsoft Solution Center

*coming soon*
# Linking Dataverse with Azure Data Lake Gen2 and Azure Synapse

In a data platform, disparate data sources and datasets are integrated onto a Data Lake in order to allow the development of new data products as well as the generation of new insights by using machine learning and other techniques. One of such data sources can be Dataverse, which is the standard storage option for all business applications running inside a Power Platform enviornment. Dataverse stores datasets in a tabular format and allows them to be extracted to a Data Lake Gen2 via a feature called "Azure Synapse Link for Dataverse".

Simply put, this feature sets up a connection between Dataverse and a Storage Account in Azure with Hierarchical Namespaces (HNS) enabled. In addition, it allows to automatically generate a the metadata for the extracted tables in a Synapse workspace. If this option is enabled, a Spark metastore with table definitions for the extracted datasets is generated and can be used for loading the datasets and further data processing. The "Azure Synapse Link" feature in Power Apps also allows users to configure how specific tables are extracted. Options include the specification of the partitioning mode and in-place vs. append-only writes. More details about these options can be found [here](https://docs.microsoft.com/en-us/powerapps/maker/data-platform/azure-synapse-link-advanced-configuration).

## Service Requirements

When setting this feature up, the Storage Account as well as the Synapse workspace must be configured correctly. Otherwise, the setup of the feature or the actual dataset extraction will fail. Therefore, the below sections will describe how the two services must be configured in order for the automatic data extraction to work.

### Storage Account

The storage Account must have hierarchical namespaces (HNS) enabled. This is a strict requirement, since the Power Platform uses the DFS endpoint of the storage account for data extraction. In addition, the firewall of the storage account needs to be opened so that the power platform can access the storage account and update datasets within the data lake file systems. Today, it is not possible to rely on private endpoints or service endpoints for the export feature to work. Hence, the `defaultAction` in the `networkAcls` property bag needs to be set to `Allow`. Enabling `AzureServices` to bypass the firewall was not sufficient when testing Azure Synapse Link for Dataverse.

The setup creates two storage account containers/file systems. One is used for the actual export of data and the second one is used for power platform dataflows. In addition to that, multiple role assignments are setup as outlined below:

| Service Principal                                  | Role Name                     | Scope                     |
|:---------------------------------------------------|:------------------------------|---------------------------|
| 'Microsoft Power Query' (Power Platform Dataflows) | Reader and Data Access        | Storage Account           |
| 'Microsoft Power Query' (Power Platform Dataflows) | Storage Blob Data Owner       | Storage Account Container |
| 'Export to data lake' (Dataverse)                  | Owner                         | Storage Account           |
| 'Export to data lake' (Dataverse)                  | Storage Blob Data Owner       | Storage Account           |
| 'Export to data lake' (Dataverse)                  | Storage Blob Data Contributor | Storage Account           |
| 'Export to data lake' (Dataverse)                  | Storage Account Contributor   | Storage Account           |
| 'Export to data lake' (Dataverse)                  | Storage Account Contributor   | Storage Account Container |
| 'Export to data lake' (Dataverse)                  | Owner                         | Storage Account Container |
| 'Export to data lake' (Dataverse)                  | Storage Blob Data Owner       | Storage Account Container |
| 'Export to data lake' (Dataverse)                  | Storage Blob Data Contributor | Storage Account Container |

### Synapse workspace

Our tests have shown that similar requirements exist for Synapse workspaces. Disabling traffic to Synapse's public endpoint or using private endpoints are not supported scenarios. The Synapse workspace firewall needs to be opened up to allow traffic from the Power Platform environment. The following role assignment are setup when creating a Azure Synapse Link for Dataverse connection:

| Service Principal                                  | Role Name                     | Scope                     |
|:---------------------------------------------------|:------------------------------|---------------------------|
| 'Export to data lake' (Dataverse)                  | Synapse Administrator         | Synapse Workspace         |

### Other

For Azure Synapse Link to work, the Storage Account, the Synapse Workspace and the Power Platform Environment must share the same region. Furthermore, all services must belong to the same tenant, subscription and Resource Group. If one of these requirements is not fulfilles, setup of "Azure Synapse Link" in Power Apps will fail.

The user creating the connection requires Owner or User Access Administrator rights on the two Azure resources and Synapse Administrator rights in the Synapse workspace in order to be able to assign RBAC roles to the Service Principals of the two Enterprise Applications. In addition, the user needs to have the Dataverse system administrator role in the environment to connect Azure and Dataverse successfully.

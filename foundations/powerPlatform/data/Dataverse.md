# Data in the Power Platform

## Dataverse

Dataverse is a low-code managed data platform for creating data pipelines to implement business logic and persisting data. Scaling, security, and networking features are managed and not exposed to the user. It provides solutions for data and business-related problems and is designed to be the prime data repository for Dynamics. Dataverse is integrated with Microsoft Dynamics 365, Power Automate, and support connectivity to Azure. Dataverse is formerly known as Common Data Service.

Dataverse has a column store database. All data is stored in rows in a predefined set of columns.
Each of these columns has a data type. Full list of data types:
[Column data types in Microsoft Dataverse](https://docs.microsoft.com/en-us/powerapps/maker/data-platform/types-of-fields)

Microsoft Docs Data in a column are limited to the data type of that column. Some columns can be converted into a different data type. This conversion does not change the data. A set of columns together defines a table, similar to what you find in a MS SQL database.

Dataverse has a transactional store. It is optimized for operational applications with frequent CRUD operations (Create Read Update Delete).
Fixed price pr allocated storage capacity disregarding of use (Tenant Entitlement).
Given the structure of tables, columns and rows, Dataverse requires a normalized data model. Managed service (backup, availability), easy to use with click through designers to create, edit, and interact with data.
Dataverse is tightly integrated with Biz Apps universe, Power Platform and Dynamics 365. Data is stored and accessible across the applications in that suite of products.
A Dataverse database currently is limited to 4TB in total size.
Highly centralized management and data storage. Management for all data in Dataverse is governed using the admin portal.
Storage capacity is pooled across your organization's tenant. You get a base 10GB then an additional 50 MB for every per app license you have. A per user license gives you an additional 250 MB, and Dynamics 365 per user license gives you an additional 1GB.
How its divided up between your organization is based on environments and how much each environment is using. Note that each sandbox and production environment you provision will reserve a minimum of 1GB. The Power Platform admin center has analytical storage reports for you to view how storage is being used in the Environments, such as a breakdown by each table.
Images used as part of an application, like icons, thumbnails, backgrounds etc. should be stored in Dataverse. Images that are subject to analytics like object detection, classification or unstructured text analytics, should be stored in Azure Data Lake Store. This would enable them to be available for analysis of more advanced tools and support a much larger quantity of images to be parallel processed.
When working with unstructured data like files and images Dataverse has two types of columns to use, File column and Image column. If a customer decides to encrypt the data using their own keys, there are some limitations applied to these two column types. Files are limited to a maximum size of 128MB per file.  

#### Design considerations

* Data can be integrated into Dataverse as a one-off activity or on a schedule. Alternatively, virtual tables can be used to map data in an external data source so that it appears to exist in Dataverse. Virtual tables do not support many of the security and auditing related features that are offered for non-virtual tables.
* Custom tables and/or standard, predefined tables can be used as a datasource when creating a Power Platform application.
* Ownership type of custom tables can't be changed after creation. Virtual tables are always owned at the organizational level.
* Row- and column-level security can be used to restrict access to data within tables.
* Dataverse provides the option of automatic and manual backups. Automatic backups are system-initiated and manual backups are user-initiated.
* Audit Logs can be enabled to track changes to tables and columns over time for security and analytical purposes.
* Data existing in Dataverse can be continuously integrated into an Azure Data Lake Gen2 for running analytical workloads on the data.
* App Makers can perform changes directly within Dataverse (Default Solution) or work within a custom Solution.
* Application data model must be defined including table structure, relationships between tables (one-to-many, many-to-one, many-to-many). Existing business data models should be resused to simplify data integration, data sharing and joins with other datasets.
  
#### Design recommendations

* Integrate required data sources into Dataverse to leverage a common datastore for your applications, simplify connectivity, reduce management overhead and reduce the point of failures within the architecture. In addition, users will also gain access to additional features such as queues, knowledge management, SLAs, duplicate detection, change tracking, mobile offline capability, column security, and Dataverse search.
* Securely integrate data using Power Platform dataflows and virtual network data gateways for Azure data sources or on-premises data gateways for data sources outside of Azure.
* Setup an automatic refresh schedule or an event-driven update workflow for imported data that changes frequently in the source system. Setup refresh failure notifications to get notified about synch errors. Use incremental refreshes to reduce the amount of data that needs to be processed by Power Platform dataflow or other integration tools.
* Split complex Power Platform dataflows into "Load" and "Transformation" dataflows or use computed entities. This will simplify readability and will allow reuse of the original loaded dataset across multiple transformation dataflows.
* Use standard tables, columns, and table relationships when they make sense for your organization to simplify the app development and reduce the risk of data replication within Dataverse.
* When creating a custom table, decide upfront whether the table and access control should be owned by the "Organization" or by a "User or team".
* Use column-level/field-level security for columns and fields that include sensitive data such as PII data.
* In general, rely on automatic system-initiated backups. Use manual user-initiated backups before updating the environment or before triggering application updates.
* Enable auditing for tables to log any data creation, changes, or deletion in the respective tables. All columns are audited by default, when turning the feature on and auditing must be turned on for the environment.
* For analytical workloads such as machine learning, reporting, data warehousing and other downstream integration processes, use Azure Synapse Link to export the data from Dataverse into the analytical data platform. This will reduce the impact on the transactional Dataverse database and allows multiple Data Product teams to consume the same consistent dataset at scale.
* Always, create and work within the context of a new solution as you add, edit and create components. For Dataverse in particular, [create a segmented solution with table assets](https://docs.microsoft.com/powerapps/maker/data-platform/create-solution#create-a-segmented-solution-with-table-assets). This makes it easy to export your solution so that it can be backed up or imported to another environment.
  
## Azure 

### *(Work in progress)

### Design recommendations 

Azure offers a much broader range of types of services to store data. Ranging from highly specified to more general purpose. All with a distinct set of features and capabilities, most of these services have connectors to Power Platform and are enabled to interact with Power Apps, Power Automate and Logic Apps.
Microsoft developed connectors for Azure storage solutions:
-	Azure Data Explorer
-	Azure Storage, Blob, Queues, Tables, Files
-	Azure Data Lake
-	Cosmos DB
-	Azure SQL Server
-	Synapse (formerly Azure SQL Datawarehouse)
Full list: List of all connectors published by Microsoft | Microsoft Docs
Design considerations
Data from Dynamics are stored in Dataverse. In the case of combining data from multiple sources you will encounter use cases where you have to transfer some of that data to be able to create joins. Dataverse supports Synapse link to create a replica of the selected tables in in Synapse or you can use Azure Data Factory /Data flow / Synapse data integration to extract the data in an ELT/ETL job.  
Structured and unstructured.
Specialized options PostgreSQL, CosmosDB (Mongo,  Gremlin, Cassandra)
Storage account – flexible size, low cost
Azure SQL – standard, wide set of integration
SLA – Availability, response time 
Governance, auditing, lineage, catalog 

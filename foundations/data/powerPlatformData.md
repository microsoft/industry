# Data in Power Platform

Work in progress

## Power BI Admin

Power BI is a visualization tool that can be used to present coherent, visually immersive, and interactive insights from various data sources across cloud environments and on-premises.

### Design considerations

* Available features in Power BI depend on the license that is assigned to the user and workspace. One free and two paid licenses are available (Pro and Premium (Gen2)). In an organization, admins purchase a license subscription (Billing administrator or Global administrator) and then assign licenses to workspaces, groups, and individual users (License administrator, User administrator, Global administrator).
* Self-service sign-up to Power BI licenses can be enabled or disabled within an organization.
* Power BI premium requires an organization to manage capacity and assign capacity to workspaces. Deleting Premium capacity won't result in the deletion of the assigned artifacts.
* Auto-scale in Premium Gen2 allows for automatically adding one v-core for 24-hour periods when the load on the capacity exceeds its limits. Additional v-cores are charged on a pay-as-you-go basis.
* Metadata scanning can be used to facilitates governance over your organization's Power BI data by making it possible to quickly catalog and report on all the metadata of your organization's Power BI artifacts.
* Sensitivity labels can be used to apply Microsoft 365 labels to Power BI artifacts.
* Default and mandatory label policies for Power BI can be defined in the Microsoft 365 compliance center (currently in preview).
* Sensitivity label inheritance can be used to have the label trickle down and be applied to content that is built from other labelled datasets or reports (currently in preview).
* Custom messages can be setup to guide users when creating artifacts within the Power BI tenant.
* Power BI premium allows storing dataflows in a customer owned ADLS Gen2 account. Optionally, workspaces owners can be allowed to configure their own datalake for Power BI dataflows.
* Audit logs can be used to track usage for all Power BI resources at the tenant level.
* Power BI Premium allows connecting workspaces to a Log Analytics Workspace.

### Design recommendations

* To make the most out of Power BI, purchase a Premium (Gen2) license. Large organizations should purchase a Premium capacity license as well as a set of Premium per user (PPU) licenses and assign licenses to the respective workspaces, content creators and user groups. Smaller organizations may only purchase a set of PPU licenses instead of Premium capacity.
  
  Premium licenses will enable a significant number of required functionalities for enterprises to securely access and share data. For instance, only a Premium license allows using the virtual network gateways to privately access data stored in private link enables Azure data services. In addition, workspaces with premium capacity will allow the usage of "Bring Your Own Key" (BYOK), will provide multi-region support, unlimited refresh concurrency, unlimited distributions, and reports on-premises. Premium Gen2 also simplifies the capacity monitoring, as users will in most cases no longer have to monitor the memory used but only the CPU time required to serve the load.

* Assign a free user license to all users who are just consuming content shared with them or who are exploring or learning Power BI through their own personal workspace.
* Create capacities from available v-cores and assign application owner(s) as capacity admin(s). This enables self-services, as it allows application teams within the tenant to manage their own capacity and assign workspaces to Premium capacity. Load testing may be required to select the right SKU and minimize the need for autoscale capacity. Use the [Power BI Premium Capacity Utilization and Metrics App](https://appsource.microsoft.com/product/power-bi/pbi_pcmm.pbipremiumcapacitymonitoringreport) to monitor the used capacity and overload events and decide about SKU upgrades.
* Configure a utilization notification for Power BI premium capacities to receive emails when approaching the the maximum capacity.
* Only assign shared workspaces and no personal workspaces to Premium capacity.
* Enable autoscale for shared workspaces within your organization to reduce the management overhead and the requirement to continuously monitor the required CPU time of each workspace. Set the maximum number of additional autoscale v-cores to a reasonable number between 1-4. If more capacity is required, evaluate whether a AKU upgrade is required. For more details about load evaluation in Power BI Premium Gen2 visit this [documentation page](https://docs.microsoft.com/power-bi/admin/service-premium-concepts). Assign the subscription and resource group of the application team to the autoscale settings for cross-charging purposes.
* Set up metadata scanning in the Power BI tenant to allow Azure Purview or other data catalogues to collect metadata and lineage.
* Enable sensitivity labels in Power BI to allow users to make use of existing Microsoft Information Protection sensitivity labels and to enable comprehensive protection and governance of sensitive data.
* Define a default label and enforce mandatory label policies for Power BI dashboards and datasets in the Microsoft 365 compliance center to enforce applying sensitivity labels.
* Configure sensitivity label inheritance from data sources as well as downstream inheritance in the Power BI tenant to simplify end-to-end information protection inside your organization. <!-- Use the "Downstream inheritance with user consent" mode, to allow users define more restrictive sensitivity labels when combining multiple data assets. --> Also, evaluate restricting highly confidential content from being shared within the organization via links.
* Define and present custom messages in the Power BI tenant to shows disclaimers and guide users before publishing artifacts to a workspace.
* Continuously export Power BI audit logs to an Azure storage account and build dashboards to track usage of Power BI artifacts. More details on how to setup the data export can be found [here](https://docs.microsoft.com/en-us/power-bi/admin/service-admin-auditing#use-the-activity-log).
* Consider restricting export paths that do not support label inheritance. Supported paths are [documented here](https://docs.microsoft.com/en-us/power-bi/admin/service-security-sensitivity-label-overview#supported-export-paths).
* Use Microsoft Cloud App Security to define conditional access policies for Power BI and restrict permissions for labelled artifacts.
* Once it is possible to connect multiple Power BI Premium workspaces to a single Log Analytics workspace, we recommend transferring all Power BI workspace activity logs to a central Azure Log Analytics workspace for further analysis.

## Data

### Data in Dataverse

Apps created in the Power Platform, whether they are canvas, model, or portal based, can all leverage the native database capability through Dataverse within a Power Platform environment. Dataverse is a transactional SaaS data platform that can be used to include data little code to be written inside a Power Platform application.

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

### Data in Power BI

Power BI is a visualization tool that can be used to present coherent, visually immersive, and interactive insights from various data sources across cloud environments and on-premises.

#### Design considerations

* When connecting to data sources you can import data into Power BI or connect directly to data in the original source repository (Direct Query).
* Data sources connected to a virtual network can be accessed using virtual network data gateways or on-premises data gateways.
* If datasets reside in Power BI, data can be refreshed through different mechanisms.

#### Design recommendations

* Import data into Power BI instead of using Direct Query whenever possible to take full advantage of the Power BI query engine.
* Use Direct Query only in the following cases:
  * The underlying data changes frequently (less than 1h) and/or near real-time reporting is required.
  * The required dataset is very large and importing just a subset or aggregation is not feasible.
  * The security rules are defined in the underlying data source.
  * Data sovereignty does not allow importing the dataset to Power BI.
  * The used connector and data source supports the produced load and can compute aggregations within a short window.
  * Rich data transformation capabilities via Power Query are not required.
  * The source is a multidimensional source containing measures.
  * More limitations can be found [here](https://docs.microsoft.com/power-bi/connect-data/desktop-directquery-about).
* Connect to data sources securely by using virtual network data gateways for Azure data sources or on-premises data gateways for data sources outside of Azure.
* Configure refresh schedules for Power BI datasets that refresh frequently within the source system. Depending on the Power BI license, you will be limited to a predefined number of refreshed per day (8 per day for datasets on a shared capacity, 48 per day for datasets on a premium capacity). Also configure refresh failure notifications to get email updates when scheduled refreshed fail.
* If possible, use incremental data refreshes to speed up the refresh process, make it more reliable and consume less capacity.

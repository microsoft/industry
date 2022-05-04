# Flexible Fulfillment

Flexible fulfillment is targeted at optimizing order management and giving customers choice across channels. It leverages D365 Supply Chain Management (SCM) and D365 Intelligent Order Management (IOM).

The solution is composed of several components and due to complexity of the deployment, this guidance has been broken down into two parts to cover IOM and SCM separately.

The image below shows the composition of this solution.

![Flexible Fulfillment](./media/flexible-fulfillment.png)

The table below lists the building blocks for solution and contains a link to their respective deployment guidance. The full solution is broken down into smaller manageable deployments.

| Components | Description | Deploy |
|:----------------------|:------------|--------|
| D365 Intelligent Order Management (IOM) | The deployment experience | [End-to-end deployment and configuration of D365 IOM and BigCommerce](./iom/README.md)
| D365 Supply Chain Management (SCM) |*Coming soon* |
| D365 Commerce |*Coming soon* |
| Teams for Frontline Workers |*Coming soon* |

**Important Note about this deployment guidance**

- This guidance uses a single AAD tenant which is used across Azure, Power Platform etc. Please DO NOT use separate AAD tenants for end to end deployment of this solution.
- In context of Power Platform Environments, a solution which consists of multiple D365 apps which require access to a common Dataverse instance and other components such as Power Apps; Automate etc., we will use a a single Power Platform environment so that components belonging to an environment can be shared across application boundaries.
- The deployment experience of Flexible Fulfillment is not fully automated and it consists of manual steps which must be performed across Solution Center; Power Platform Admin Center (PPAC) and third-party (3P) BigCommerce platform. There are certain aspects of the deployment primarily those relating to Azure which have been automated for a programmatic and repeatable deployment.
- BigCommerce is a third-party ecommerce platform. For authoratative guidance on deploying BigCommerce and technical support, we recommend reaching out to [BigCommerce](https://www.bigcommerce.com/dm/microsoft/).
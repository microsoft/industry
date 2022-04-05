# Order lifecycle management with Intelligent Order Management

## Table of Contents

- [Order lifecycle management with Intelligent Order Management](#order-lifecycle-management-with-intelligent-order-management)
  - [Table of Contents](#table-of-contents)
  - [Intelligent Order Management (IOM)](#intelligent-order-management-iom)
    - [Order Lifecycle Management](#order-lifecycle-management)
    - [Architecture](#architecture)
  - [Considerations and Recommendations for IOM Deployment](#considerations-and-recommendations-for-iom-deployment)
    - [Intelligent Order Management](#intelligent-order-management)
  - [Deployment guide](#deployment-guide)

## Intelligent Order Management (IOM)

Dynamics 365 Intelligent Order Management (IOM) is built on a modern open platform and Dataverse.

It provides the flexibility companies need today to capture orders from any order source such as online e-commerce, marketplace, mobile apps, or traditional sources like EDI  and fulfill them from their own warehouse, 3PL , stores, or drop-ship with vendors or other delivery fulfillment partners.

It’s a common scenario for enterprises to have disparate systems for ecommerce, fulfillment, and shipping/delivery. IOM bridges these disparities and provides a single pane of glass to manage end-to-end lifecycle of an Order. [Extensibility features](https://docs.microsoft.com/en-us/dynamics365/intelligent-order-management/extensibility) allow customers to integrate IOM with their existing ecosystem of applications.

The system also helps organizations streamline the return processes. Whether returns are collected at a retail store, fulfillment center, or service center, returns can be initiated through an app, online, or at the store.

With low-code, no-code experience, IOM’s orchestration designer tools allow users to model and automate the response to fulfillment constraints and leverage machine learning to influence & optimize the flow of the orders.

![IOM capabilities](./media/iom-overview.png)

### Order Lifecycle Management

The lifecycle of an order in Order Management can be described as a series of states and actions. Some of these might be optional or might occur in different sequences, based on the system configuration. In addition, some actions might be configured to occur automatically or to be performed manually. The main stages of an order are – order intake/creation; fulfillment; and delivery.

Intelligent Order Management helps you make order fulfilment a competitive advantage. By orchestrating and automating fulfilment using real-time omnichannel stock data, AI, and machine learning, Dynamics 365 Intelligent Order Management lets you adapt quickly, fulfil efficiently, and deliver on your order promise.

### Architecture

Intelligent Order Management, built on Power Platform, seamlessly integrates with existing systems through the provider connector framework, providing order orchestration capabilities to help you deliver on your business strategy through order, orchestration, fulfillment, optimization, inventory visibility and fulfillment insights.

IOM shares the Common Data Model with Dynamics 365 applications to facilitate back-office application support for your customer service & sales representatives.

The core architecture of IOM has three main components:

- Data Pipeline
- Orchestration Engine
- Insights

![IOM architecture](./media/iom-conceptual-arch.png)

**Data pipeline** consists of integration services and Microsoft Power Query online, which is a transformation engine for the connectors and the orchestration engine. The data pipeline in Intelligent Order Management provides the foundation for the providers to move data in and out of the app.

A **pipeline** is composed of:

- Provider
- Connectors
- Connection
- Data transformations
- Business events
- Provider action

**Orchestration engine** orchestrates a business process flow. Order-to-fulfillment flow is complex to model in a single business app, but when combined with other cloud services and supply chain partner systems, the complexity grows. To help business users in the organization to visualize and manage this complexity, Intelligent Order Management ships with a business orchestration designer. Business process flows designed with the orchestration designer are compiled into Power Automate flows when the flow is published.

Components of orchestration engine:

- Designer
- Orchestration flow types – Order Flow and Inventory Flow
- Policies
- Step

The orchestration engine’s components uses an orchestration compiler to compile the business process flows into Power Automate. The orchestration builder offers low code, no code experience for building pipelines.

Under **fulfillment optimization** capabilities, you can construct unlimited fulfillment nodes, bring your own, configure the native distribution order management engine. You can set up flexible order validation rules for easy order routing. With the provider connector capabilities, you can work with warehouse management systems, 3PLs, or other fulfillment systems you’ve chosen for your supply chain needs, based on the connectors we will provide and also partners will provide.

In **inventory visibility**, we have a highly scalable microservice that enables real-time, on-hand inventory tracking with a global view of inventory visibility, external system access through restful APIs. And you can use it as a foundation to build available to promise processing for your business processes.

In fulfillment insights, analytics monitor order through to fulfillment supply chain, out-of-the-box, customizable dashboards to monitor key metrics. AI-based anomaly detection models provide the visibility the order from fulfillment through to delivery and communicate that to the people and the systems that need that visibility in your organization.

**Insights** is built on Power BI and AI Builder. Intelligent Order Management provides several dashboards to help the business user understand key order and fulfillment metrics. Machine learning is used to analyze data using models and uses advanced algorithms to find or predict patterns in data. Customers can build models using AI builder that use data from Intelligent Order Management, so that results are updated on entities used during the order and fulfillments flows. This will help decision making in orchestration flows.

## Considerations and Recommendations for IOM Deployment

### Intelligent Order Management

IOM is an application built on Power Platform and Dataverse, hence the key decisions related to identity, security, scale, resiliency etc. are dependent on the underlying platform. Recommendations and considerations for Power Platform are published [here](https://github.com/microsoft/industry/tree/main/foundations/powerPlatform).

## Deployment guide

***Coming soon***
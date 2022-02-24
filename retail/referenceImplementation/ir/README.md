# Intelligent Recommendations

Goal of this guidance is to provide prescriptive guidance for enterprise-scale deployment of Intelligent Recommendations (IR) service.

## Overview

[Intelligent Recommendations](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/overview) democratizes AI and machine learning recommendations through a codeless and powerful experience powered by the same technology that fuels Xbox, Microsoft 365, and Microsoft Azure. Businesses can now provide relevant discovery for customers with this new, innovative AI for personalization and recommendations.

Intelligent Recommendations IR) is one of the features included in Microsoft Cloud for Retail. While Microsoft Cloud for Retail is in Public Preview, Intelligent Recommendations is now generally available. Whilst the service as a standalone offering is new, the algorithm behind the service has been in use for a few years as part of Dynamics Commerce.

### Capabilities

The IR service uses input datasets and configuration parameters to determine the type of [recommendation scenarios](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/overview). These are:

- Personalized recommendations for end-users
- Similar items
- Real-time and session-based recommendations for users
- Basket completion

### Architecture

![ir detailed](./media/ir_detailed_process_flow.png)

### Terminology

- `Cooking process` is the backend process of reading; processing and modelling data according to business needs.
- `User interactions` are the interactions between users and items that Intelligent Recommendations models learn from and use to predict future interactions. Examples of user interactions include click streams, purchases etc. The data is stored in CSV format and shipped to IR as an input.

### Integration points for IR

IR is a scalable headless service and it has two key integration points:

1. ADLS Gen2 storage for storing input datasets and making them available for IR for processing.
2. Frontend APIs where the recommendations (or output) are made available for consumption via applications.

### Service flow

The recommendations process can be broken down into three key steps:

1. Read input datasets (user interactions such as purchase, downloads, views etc.) and configuration from an ADLS Storage Account. IR requires a specific data model and base configuration to build recommendations.These are defined as part of `model.json` file.
2. "Cooking process" is the backend process managed by IR service where datasets (user interactions) are read from ADLS and processed by IR service.
3. Data serving part where the results are made available to the customer through a set of published APIs.

![IR process flow](./media/ir_process_flow.png)

### FAQ

- Does IR support Private Endpoints?

    No. It's meant to be accessible over public internet. One of the use cases is to be able to integrate with eCommerce SaaS platforms such as Shopify, BigCommerce etc.

- Can users choose ML/AI models?

    IR is a PaaS and all model management related tasks are managed by Microsoft. As a result, customers do not have visibility of what model(s) were used to generate a set of recommendations. However, end-users can fine-tune the results through [Flexible Filtering](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/fine-tune-results#flexible-filtering) and [Top candidates for recommendation lists](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/fine-tune-results#show-top-candidates-for-recommendations-lists).

- Monitoring the `cooking process`?

    At the time of writing this document, IR does not have APIs or Azure Monitor integration. However, based on internal benchnarks, cooking process could take up to ~72 hours. There is no SLA in place as this service is still under preview.

- Availability of IR and data residency?

    At a bare minimum, IR deployment requires an instance of IR service and an ADLS account where `user interactions` and `model.json` are stored.

    ADLS keeps the data in the region where ADLS service is instantiated. If IR and ADLS share the same region, then data stays within the region. However, if the Data Lake Storage account and modelling resources are in different regions, data will be copied from the Data Lake Storage region to the modelling resource region that you selected. As of Jan 2022, Intelligent Recommendations is available in West US and West Europe (WEU).

    Customers can choose region of modelling resources at the time of creating a `Model Instance`. Once IR instance has been created, under click on (A) Modelling blade and then (B) `Create`. Customers can then choose the region from dropdown list.
    ![Choosing modelling region](./media/choosing_modelling_region.png)

- How to select supported scenarios/models which are computed by IR?
    Customers can choose the feature set to model at the time of creating a Modelling instance. In IR, type of scenarios one can model are tied to tier of Modelling instance one chooses to create.
    ![IR features](./media/ir_features.png)

    `Basic` tier includes modeling of:

        - People also buy
        - Frequently bought together
        - New
        - Trending
        - Best Selling

    `Standard` tier includes modeling scenaros under `Basic` plus:

        - Picks for you (personalization)

    `Premium` tier includes modeling scenarios under `Standard` plus:

        - Similar look (Visual similarity)
        - Similar description (NLP similarity)

- What format is supported for `user interactions` files?

    `User interactions` must be in CSV format. The definition of CSV files is available under [Data Contracts](https://docs.microsoft.com/en-us/industry/retail/intelligent-recommendations/data-contract).

- Does IR support delta for input datasets?

    No. The IR service cannot calculate delta for input datasets. When a dataset is provided to IR for processing, it will process all the records in the input file(s) and then generate a set of recommendations based on that data.

    One option to reduce operational overhead is to extract delta from the source using an ETL tool, however from IR perspective, it expects a full dataset which it must process to generate a set of recommendations.

- Does IR have an availability SLA?

    IR is in preview and currently does not have an availability SLA in place. However, this will be in place when service goes GA.

## Considerations

*Work in progress*

## Recommended Practices

*Work in progress*
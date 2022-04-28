# Shopper and operations analytics

## Table of Contents

- [Shopper and operations analytics](#shopper-and-operations-analytics)
  - [Table of Contents](#table-of-contents)
  - [Shopper and operations analytics Reference Implementations](#shopper-and-operations-analytics-reference-implementations)
  - [Azure for Healthcare Reference Architecture](#azure-for-healthcare-reference-architecture)
  - [Unlock omnichannel insights with advanced analytics](#unlock-omnichannel-insights-with-advanced-analytics)
    - [Design Recommendation](#design-recommendation)

## Shopper and operations analytics Reference Implementations

| Industry Architecture | Description | Deploy | Documentation
|:----------------------|:------------|--------|--------------|
| Shopper and operations analytics | Shopper and operations analytics provides a full, rich, compliant architecture for landing zones for retail industry scenarios |[![Deploy To Microsoft Cloud](./images/deploytomicrosoftcloud.svg)](https://aka.ms/afhRI) | [User Guide](./referenceImplementation/readme.md)

## Azure for Healthcare Reference Architecture

![Shopper and operations analytics Reference Architecture](./images/analytics.png)

## Unlock omnichannel insights with advanced analytics

There are 40 petabytes of data generated every hour in retail. This data is being collected through multiple customer touch points - from traditional sources like POS systems, inventory logs, and transaction logs, to more modern sources like in-store sensors, and even social media. In a single day, the same customer could interact with your ad on social media, open a marketing email, and also walk into your store to purchase an item.

Tapping into the data generated through all these customer touch points is key to better understanding your customers and staying ahead in an increasingly competitive retail landscape.

The data coming from those customer touch points are being stored on separate, legacy systems that often don’t speak the same language. Some of that data is in operational stores (like web click data, foot traffic, or coming from an assembly line) or it’s coming from your apps (like CRM, customer service solutions, tracking systems, etc.). This data is siloed and disconnected, and most retailers are only set up to leverage a fraction of it.

Because this data sits in different databases, speaking different languages, the exact same customer who completes a transaction on social media versus in-store may appear as two, three, or four different customers.

You need something that brings together these different data sources across the retail value chain so that you can derive actionable insights and deliver superior shopping experiences to your customers.

### Design Recommendation

With Microsoft Cloud for Retail, we recommend using data models to bring multiple systems and applications together by providing a shared language for your applications. This simplifies data management and app development by unifying data into common formats and applying consistency across multiple apps and deployments.

- Industry specificity: Leverage data models with retail-specific semantics
- Interoperability: Data models ingest, enrich, and unify data to break down data silos and ease interoperability through industry specific pre-built connectors
- Faster innovation: Extend the value of the platform with additional solutions, analytics, and predictions.

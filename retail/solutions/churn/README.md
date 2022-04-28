# Retail channel churn predictive model

Unified customer profile is one of the key capabilities of Microsoft Cloud for Retail. In some ways, it’s where the data story comes together. So, what does it do? Unified customer profile helps you gain insights across the complete view of a shopper’s journey. 

With unified customer profile, you can gain a 360-degree perspective of the customer in a clear and intuitive way so that you can provide personalized experiences, reveal important opportunities, prevent potential loss, or churn, and improve customer satisfaction. 

Unified customer profile bolsters **unification**. You can: 

- Bring multiple identities together to create a 360 view of the customer through AI-powered identity resolution 

- Ingest multiple types of data, behaviors, and customer sentiment in real time via more than 500+ built-in connectors 

It also fosters **unique enrichment**: 

- Gain a 360 view of the customer with proprietary audience intelligence from Microsoft Graph 

- Leverage cross-channel behavior to complete the picture of your end-customer  

Furthermore, Unified customer profile also gives you better access to customer **insights**: 

- Gain more nuanced insights by combining digital analytics with customer profiles to create richer segments, and leverage churn models to understand churn risk at a glance 

- Observe customer progress through each defined step of the journey, quickly identifying obstacles and opportunities 

- Create custom reports and views based on real-time customer behavior data, leverage built-in web and mobile analytics to predict customer needs 


Microsoft Cloud for Retail Unified customer profile includes in the U.S. an AI-based churn predictive model, designed for omnichannel retail and built atop Customer Insights. Create a retail channel churn predictive model to fit your business needs, and gain cross-channel insights into the chance of retail customer churn. Run your company data through this model, training it to improve its predictions and identify the factors that contribute to churn, at the customer level.

You use three of your data entities to create and train your model: a customer entity, a session entity, and a transaction entity. The model uses inputs that you map to fields from these entities. When your model runs, it stores its churn predictions in an output entity, and provides explainability elements—factors with the most influence on churn risk predictions. It displays these factors along with their level of influence.


## Prerequisites

Retail components, available within Microsoft Cloud for Retail in Microsoft Cloud Solution Center. For more information about deploying these components, go to Deploy Unified customer profile in Microsoft Cloud for Retail.

At least Contributor permissions in Microsoft Dynamics 365 Customer Insights. For more information, go to User permissions.

An understanding of what churn means for your organization. A customer is considered to have churned if their purchase value or volume drop below thresholds that you define.

## Customer data

A customer entity has fields—also called attributes—that have data about customers, but not their visits or their purchases. A churn prediction model has one required input and ten optional inputs that you map to customer entity fields when you create your churn model. To prepare, make sure your customer entity has fields you can map to the model's inputs.

If your customer entity doesn't have all the attributes that you want to include in your churn model, you may be able map, match, and merge the missing attributes so that they're available as churn model inputs. For more information, go to Data unification overview.

If you can't find suitable attributes in your source data, you may be able to add data sources, and then map, match, and merge them.


## Session data

A session entity has fields that have data about customer visits, but not their purchases. The churn model has four required and five optional inputs for session data. Providing optional inputs will improve the accuracy of predictions.

If your session entity doesn't have all the attributes that you want to include in your churn model, you may be able map, match, and merge the missing attributes so that they're available as churn model inputs—if your source dataset includes suitable attributes to use. For more information, go to Data unification overview.

If you can't find suitable attributes in your source data, you may be able to add data sources, and then map, match, and merge them.

### Architecture

***Coming soon***

![Churn architecture](./media/churn.png)

## Considerations and Recommendations for Churn Model Deployment

***Coming soon***

## Deployment guide

***Coming soon***
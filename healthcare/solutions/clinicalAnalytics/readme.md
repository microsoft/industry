# Coming soon
# Clinical Analytics

The solution for Clinical Analytics will harness data and discover clinical insights to deliver value-based care models. In this flow, we look at how you can persist data in an analytical store, enable large scale analytical query capabilities and leverage insights from AI assisted imaging analysis and population health metrics to determine course of care. The analytical solution enable you to search through large amounts of data from sources like electronic medical records, smart medical devices, patient and population demographics, and the public domain to find hidden patterns and trends and predict outcomes for individual patients. The care guidance can rely on AI learning models that become more precise when additional data and cases are introduced.

Key capabilities of Clinical Analytics include:

* **Provider Evaluation**: Reviews IoMT data, EHR and patient data.
* **Imaging AI**: DICOM images supported by an AI report, which indicates patient condition.
* **Population Health**: Leverage large datasets to compare effectiveness of different treatment options with patients of similar demographics.

| Reference implementation | Description | Deploy |
|:----------------------|:------------|--------|
| Healthcare Analytics | End-2-end deployment and configuration of analytics solution for healthcare |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2FhealthcareArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2Fhealthcare-portal.json)

## Reference architecture

![Healthcare - Clinical Analytics](./images/clinicalanalytics.png)

## Critical design areas for Clinical Analytics

>Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...

*"There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."*

* [Prerequisites](#Prerequisites)
* [Synapse for clinical analyticsl](#Synapse-for-clinical-analytics)
* [AI and Machine Learning for clinical analytics](#AI-and-Machine-Learning-for-clinical-analytics)
* [Observability and logging](#observability-and-logging)
* [Networking](#networking)
* [Regulatory compliance](#regulatory-compliance)

### Prerequisites

* **Azure platform**: ESLZ + ESA
* **Azure Healthcare APIs**: FHIR + DICOM + IOT Connector
* **Synapse**: Workspace + Spark
* **Azure ML**: Custom AI app or cognitive services Custom vision (TBD)

### Synapse for clinical analytics

#### Design considerations

#### Design recommendations

### AI and Machine Learning for clinical analytics

#### Design considerations

#### Design recommendations

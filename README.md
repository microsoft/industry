# Introduction

This repository provides holistic architecture design and reference implementation for industry cloud based on proven success of
large scale deployments and at-scale adoption with customers and partners. This guidance is built by active inner-source community
inside Microsoft to help customers and partners by providing prescriptive and actionable guidance and implementation to accelerate
deployment and adoption of industry cloud.

![Industry Cloud Overview](./docs/industry-cloud.png)

## Industry Cloud Reference Architectures

- [Healthcare](./healthcare/readme.md)
    - [Pre-requisites](./healthcare/prereqs.md)
        - [Healthcare APIs](./healthcare/solutions/healthcareApis)
        - [Power Platform](./healthcare/solutions/powerPlatform)
        - [Microsoft Teams for Healthcare](./healthcare/solutions/microsoftTeams)
    - [Personalized care](./healthcare/solutions/)
        - [Patient service center](./healthcare/solutions/patientServiceCenter)
        - [Patient access](./healthcare/solutions/patientAccess)
    - [Patient insights](./healthcare/solutions/)
        - [Patient outreach](./healthcare/solutions/patientOutreach)
    - [Virtual health](./healthcare/solutions)
        - [Virtual visits](./healthcare/solutions/virtualVisits)
    - [Care coordination](./healthcare/solutions)
        - [Care management](./healthcare/solutions/careMangement)
        - [Home health](./healthcare/solutions/homeHealth)
    - [Care collaboration](./healthcare/solutions)
        - [Health assistant](./healthcare/solutions/healthAssistant)
    - [Remote patient monitoring](./healthcare/solutions)
    - [Interoperability](./healthcare/solutions)
    - [Clinical analytics](./healthcare/solutions)
    - [Operational analytics](./healthcare/solutions)

- [Telecommunications](./telco/readme.md)

### Healthcare

The following reference architectures and reference implementations can be used to accelerate your journey on Microsoft Cloud for Healthcare industry, enabling your Microsoft tenant with the core foundations across the cloud platforms, and instantiate proven architectures for Healthcare specific solutions.

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Microsoft Cloud for Healthcare Industry | Cloud Foundation that spans across Azure, Power Platform, and Microsoft 365 for Healthcare|[![Deploy To Microsoft Cloud](./docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealth%2Fri%2FhealthArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealth%2Fri%2Fhealth-portal.json)|
| Healthcare APIs | Healthcare APIs solution including FHIR, Dicom, IoT, and sync agent with D365 | [![Deploy To Microsoft Cloud](./docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealth%2Fsolutions%2FhealthcareApis%2Fmc4h.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealth%2Fsolutions%2FhealthcareApis%2Fmc4hAzure.json)|

![Healthcare Industry Reference Architecture](./healthcare/docs/mc4h-reference-architecture.png)

### Telecommunications

The following reference architectures and reference implementations can be used to accelerate your journey on Microsoft Cloud for Telco industry, enabling your Microsoft tenant with the core foundations across the cloud platforms, and instantiate proven architectures for Telco specific solutions.

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Microsoft Cloud for Telco Industry | Cloud Foundation that spans across Azure, Power Platform, and Microsoft 365 for Telco industry and workloads |[![Deploy To Microsoft Cloud](./docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2Fri%2FtelcoArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Ftelco%2Fri%2Ftelco-portal.json)

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit <https://cla.opensource.microsoft.com>.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft
trademarks or logos is subject to and must follow
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.

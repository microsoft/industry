# Internet of Medical Things

Internet of Medical Things (IoMT) is a subcategory of Internet of Things (IoT) and focusses on the practical application of IoT in the area of healthcare. In IoMT scenarios medical data is collected and sometime pre-processed through the means of internet-connected medical devices and then sent to a datacenter in (near) real-time. The data can then be used for various data-driven applications and use-cases including:

- The prediction of medical states and incidents for device users as well as healthcare providers.
- Allowing healthcare professional to remotely monitor patients' key biometrics in (near) real-time.
- Shorter time to diagnosis, because of more efficient and quick data exchange, asynchronous analysis of datasets and analysis of mdeical data, before impactful medical incidents take place. No in-person visits required.

Classical IoT as well as IoMT scenarios share similar architectures. The most significant differences can be identified on the application and data-driven use case level. Also, there is a higher emphasis on the security aspect in the IoMT space and the compliance with legal regulations and standards. In the next paragraphs, we will look at the various layers of an IoMT architecture.




- security as key factor (HIPAA and otehr regulations)
- data must be processed to generate useful information and insights
- ml can be used to automate processes and is critical, because not all data can be analyzed and viwed manually


# Azure Healthcare APIs

This is a sample template for Azure Healthcare APIs. More details about the service can be found in [the official documentation](https://docs.microsoft.com/en-us/azure/healthcare-apis/).

## Deployment

Please use the following button to deploy the service into your resource group:

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](#TODO)

## Policies

Custom Policies for the industry specific services used in this solution can be found in the folder [`/Healthcare/HealthcareApi/Policies/PolicyDefinitions/HealthCareApis`](/Healthcare/HealthcareApi/Policies/PolicyDefinitions/HealthCareApis). These policies can be deployed using:

1. [ARM template for deployment to subscription scope](/Healthcare/HealthcareApi/Policies/PolicyDefinitions/deploy.policyDefinition.sub.json)
2. [ARM template for deployment to management group scope](/Healthcare/HealthcareApi/Policies/PolicyDefinitions/deploy.policyDefinition.mg.json)

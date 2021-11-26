# Internet of Medical Things

Internet of Medical Things (IoMT) is a subcategory of Internet of Things (IoT) and focusses on the practical application of IoT in the area of healthcare. In IoMT scenarios medical data is collected and sometime pre-processed through the means of Internet Connected medical devices and then sent to a datacenter in (near) real-time. The data can then be used for various data-driven applications and use-cases including:

- The prediction of medical states and incidents for device users as well as healthcare providers.
- Allowing healthcare professional to remotely monitor patients' key biometrics in (near) real-time.
- Shorter time to diagnosis, because of more efficient and quick data exchange, asynchronous analysis of datasets and analysis of medical data, before impactful medical incidents take place. No in-person visits required.

Classical IoT as well as IoMT scenarios share similar architectures. The most significant differences can be identified on the application and data-driven use-case level. Also, there is a higher emphasis on the security aspect in the IoMT space and the compliance with legal regulations and standards. In the next paragraphs, we will look at the various layers of an IoMT architecture.

## IoMT Architecture

The architecture diagram depicts a typical IoMT scenario, where practical-connected devices collect protected health information (PHI) of patients and then transmit the data points over one or multiple gateways to the cloud.

![Internet of Medical Things Architecture](./docs/IoMT.png)

After the data has reached the Azure datacenter, data can be further processed by using tools such as Azure Functions, Azure Synapse or Azure Stream Analytics. Finally, data usually gets persisted onto one of the various data services inside Azure like Azure Cosmos DB, Azure Storage, Azure Synapse SQL Pool or Azure Healthcare APIs.

Except for the data persistence layer, the Microsoft Cloud for Healthcare does not offer any industry-specific solutions for realizing such end-to-end scenarios. Today, standard Azure services including Azure IoT Edge, Azure IoT Hub or Azure Synapse must be used by customers to realize such architectures. Only for the storage layer, the industry-specific Azure Healthcare APIs service is available, which supports standards such as Fast Healthcare Interoperability Resources (FHIR), Digital Imaging and Communications in Medicine (DICOM) and conversion of multiple other data standards into FHIR.

Due to sensitivity of the data being transmitted, security is a key factor and various kinds of regulations have to be fulfilled by companies when realizing IoMT scenarios. However, a key factor of success of such solutions depends on the use of Machine Learning and integrated Dashboards, as the sheer size of data makes it impossible to review all data points.

## Dynamics 365 Integration

Within Dynamics 365, the Microsoft Cloud for Healthcare offers a comprehensive set of solutions for the healthcare market to expedite a healthcare organization’s ability to roll out solutions. Patients, providers, and care coordinators can perform daily duties in a modern yet familiar user-interface that provides robust functionality. An overview of the ever-growing list of Dynamics 365 healthcare solutions can be found [here](https://docs.microsoft.com/en-us/dynamics365/industry/healthcare/overview).

The healthcare data model for Dynamics 365 is also based on the FHIR framework, which makes it easier for customers and partners to develop new applications without redefining the healthcare data architecture.

In order to not end up with two disparate systems and datasets, customers can make use of a FHIR synch agent to synch data points and updates between Dataverse and Azure Healthcare APIs. The synch Agent consists of two components, the FHIR Synch Agent service and the FHIR Synch Agent Administration Application. Both components are required to synch data between Azure and the Power Platform. The synch must be setup by providing few application secrets as well as Service Bus Queue propertied.

Within the FHIR Synch Agent Administration Application, administrators can define entity maps, attribute maps and expansion maps. Sync Agent Logs can be used to validate synch operations and to understand why a certain data point is sent over the services bus and why others are not.

This allows customers to leverage datasets, collected in IoMT scenarios, in Dynamics 365 to further enhance the patients experience and quality of results. Additional applications and data-driven solutions can be built to simplify the end-to-end experience for all participants and reduce the time to diagnosis.

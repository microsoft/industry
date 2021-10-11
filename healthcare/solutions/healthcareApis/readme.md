# Healthcare APIs in Microsoft Cloud for Healthcare

Healthcare APIs with FHIR is essential in many of the Microsoft Cloud for Healthcare scenario, and strongly recommended to deploy into a landing zone in Azure to simplify and expedite the integration with Power Platform (Dataverse and Healthcare applications), and Microsoft Teams

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Healthcare APIs | Healthcare APIs architecture with FHIR, DICOM, IoT connectors, and requisite infrastructure for Healthcare solutions |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2FhealthcareArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2Fhealthcare-portal.json)


In the overall architecture for Microsoft Cloud for Healthcare, the Healthcare APIs components together with the FHIR Sync Agent enables organizations that uses data models based on the Fast Healthcare Interoperability Resources (FHIR) standards frameworks to simplify data synchronization between Azure and Microsoft Dataverse, powered by the Microsoft Healthcare solutions in Power Platform.

![Healthcare Industry Reference Architecture](./images/mc4h-reference-architecture.png)

## Critical design areas for Healthcare APIs

The core of enterprise-scale architecture for Healthcare APIs contains a critical design path comprised of fundamental design topics with heavily interrelated and dependent design decisions. This repo provides design guidance across these architecturally significant technical domains to support the critical design decisions that must occur to define the enterprise-scale architecture. For each of the considered domains, review the provided considerations and recommendations and use them to structure and drive designs within each area.

* [Identity and access](#identity-and-access)
* [Data-loss prevention](#data-loss-prevention)
* [Data ingress and egress](#data)
* [Observability, security, and logging](#observability-and-logging)
* [Networking](#azure-vnet-connectivity-for-power-platform)
* [Regulatory compliance](#regulatory-compliance)

## Azure Healthcare APIs

Azure Healthcare APIs (Preview) enables rapid exchange of data through FHIR APIs, backed by a managed Platform-as-a Service (PaaS) offering in the cloud. It makes it easier for anyone working with health data to ingest, manage, and persist protected health information (PHI) in the cloud. The FHIR API and compliant data store enable you to securely connect and interact with any system that uses FHIR APIs.

![Healthcare API architecture ](./images/healthcareapi.png "Healthcare API")

### FHIR Service

The FHIR service is a set of tools to combine and store disparate health datasets and standardize data in the cloud. The service offers a set of search options to query the persisted data or export for consumption by other services.

### DICOM Service

The DICOM Service enables the secure exchange of medical images and associated metadata with any DICOMweb™ enabled systems.
QIDO, WADO, and STOW supports query, retrieve, and store of DICOM objects.
Ingests and persists DICOM data from VNA, PACS and other medical imaging systems at thousands of images per second.
DICOM Custom Tags allows for user defined, searchable tags.​

### IOT Connector

The IOT Connector ingests streaming data from devices in real-time at millions of events per second.
Customized settings allow developers to manage device content, sample data rates, and set the desired capture thresholds.
Device data is normalized, grouped, and mapped to FHIR that can be sent via FHIR APIs to an EHR or other FHIR Service.

## Deployment instructions

Click this button to deploy the reference implementation for Healthcare APIs, and sign into your Azure tenant.

[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2FhealthcareArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2Fhealthcare-portal.json)

The deployment requires you to select the subscription you will create the Healthcare APIs into, and a location.

Once provided, navigate to the Healthcare APIs configuration tab, and provide inptu for the following:

* Resource group name. A resource group will be created to logically group all the Healthcare APIs resources and additional infrastructure, such as monitoring, storage accounts, managed identities etc.

* Region for the resources. Select one of the supported regions you will deploy Healthcare APIs into.

* Healthcare API (workspace) name. Provide a resource name for the Healthcare API workspace, which act as a logical container for the Healthcare API services.

* Azure AD user. You can optionally select a user that will be granted the required RBAC for the data plane operations for Healthcare APIs, across all services.

![healthApi](./images/setup1.png)

* Enable FHIR Service. Select whether FHIR should be created or not. By selecting yes, additional parameters are required.

* FHIR service name. Provide a unique name for the FHIR service name, that will also be used to construct the service endpoint name for your FHIR service.

* Select SKU. Select one of the supported SKUs for FHIR service, per your requirements.

* Create and integrate storage account with FHIR. FHIR service supports a secure export operation to Azure Storage account. If you select yes, the storage account will be created and associated with the FHIR service, and RBAC for the managed identity is assigned.

* Enable Managed Identity for FHIR. If you select yes, a system managed identity is created for the FHIR service.

![healthApi](./images/setup2.png)

* Enable DICOM service. Select if DICOM should be provisioned and configured as part of the Healthcare API setup.

* DICOM service name. Provide a unique name for the DICOM service name, that will also be used to construct the service endpoint for your DICOM service.

![healthApi](./images/setup3.png)

* Enable IoT connector. Select if IoT connector should be provisioned and configured as part of the Healthcare API setup.

IoT connector name. Provide a name for the IoT connector service name.

* Enable Managed Identity for IoT. If you select yes, a system managed identity is created for the IoT connector service.

* Enable Event Hub. If you select yes, an Event Hub with namespace is created and configured as part of the IoT connector service.

![healthApi](./images/setup4.png)

* Enable HealthBot. Select yes if you want to configur an Ai-powered health assistant.

* HealthBot name. Provide a name for the Health Bot service.

* HealthBot SKU. Select the required SKU for the Health Bot

![healthApi](./images/setup5.png)

* Enable Monitoring. Select yes if you want to enable end-to-end monitoring of the Healthcare APIs and all services that are being created.

* Use existing Log Analytics workspace. Select yes if you want to use an existing Log Analytics workspace to collect the diagnostics and metrics of the services, or select no if you want to create a new dedicated Log Analytics workspace for the Healthcare API services (application centric).

![healthApi](./images/setup6.png)

Once the configuration has been made, you can validate and review your input before deploying into the Azure subscription (landing zone) which will host the Healthcare APIs.

### Post deployment

Get the FHIR endpoint:
![FHIR screenshot of the endpoint](./images/fhir_url_screenshot.png "FHIR Endpoint")

### Validate the deployment

Ensure you are connected to the correct tenant and subscription

```powershell

Connect-AzAccount -Tenant "<<your_tenant_id>>" -Subscription "<<your_subscription_id>>"
```

$fhirservice is the endpoint you copied in the previous step.

```powershell

$fhirservice = 'https://<<your_healtcare_api_service>>'
$token = (Get-AzAccessToken -ResourceUrl $fhirservice).token

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/json")

$FhirGetMalePatients = Invoke-RestMethod "$fhirservice/Patient?gender:not=female" `
    -Method 'GET' `
    -Headers $headers 
Write-Host $FhirGetPatient
```

### Sample patient data

To simplify dowloading sample data and posting it to the API you can either clone this repo and run download.ps1 or you can run edit and paste this:

```powershell
$token = (Get-AzAccessToken -ResourceUrl $fhirservice).token

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/json")
function DownloadFilesFromRepo {
    Param(
        [string]$Owner,
        [string]$Repository,
        [string]$Path,
        [string]$fhirservice
        )
    
        $baseUri = "https://api.github.com/"
        $args = "repos/$Owner/$Repository/contents/$Path"
        $wr = Invoke-WebRequest -Uri $($baseuri+$args)
        $objects = $wr.Content | ConvertFrom-Json
        $files = $objects | where {$_.type -eq "file"} | Select -exp download_url
        $directories = $objects | where {$_.type -eq "dir"}
        
        $directories | ForEach-Object { 
            DownloadFilesFromRepo -Owner $Owner -Repository $Repository -Path $_.path -DestinationPath $($DestinationPath+$_.name)
        }

        foreach ($file in $files[0]) {
            $dlfile = Invoke-WebRequest -Uri $file
            try {

                $FhirGetPatient = Invoke-RestMethod "$fhirservice/" `
                -Method 'POST' `
                -Headers $headers `
                -Body $dlfile  

                Write-Host $file
            } catch {
                throw "Unable to download '$($file)' Patient: '$($FhirGetPatient)'"
            }
        }
    }

    DownloadFilesFromRepo -Owner 'esbran' -Repository 'CatHealthAPI' -Path 'sampledata/fhir/' -fhirservice 'https://{<<your_fhir_service>>}.azurehealthcareapis.com'
```

>**Remember to replace <<your_fhir_service>> in the last line before running the function DownloadFilesFromRepo.**

### Search the patients

Example of a search that returns all non-female patients:

```powershell
$FhirGetMalePatients = Invoke-RestMethod "$fhirservice/Patient?gender:not=female" `
    -Method 'GET' `
    -Headers $headers 
Write-Host $FhirGetPatient
```

Other examples can be found here: [FHIR Search](solutions/healthcareApis/sampledata/fhirget.ps1)

> ### Known issues
>
> There are a few known issues:
>
> - Existing storage account and existing workspace is currently not mapped
> - Container for storage account must be created post deployment (will be fixed shortly)
> - FHIR sync agent is coming shortly
> - FHIR proxy is coming shortly
>

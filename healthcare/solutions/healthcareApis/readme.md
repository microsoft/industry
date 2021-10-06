# Healthcare API industry architecture
Healthcare APIs with FHIR is essential in almost every Mircosoft Cloud for Healthcare scenario, and strongly recommended to deploy into a landing zone in Azure to simplify and expedite the integration with Power Platform (Dataverse and Healthcare applications), and Microsoft Teams

| Industry Architecture | Description | Deploy |
|:----------------------|:------------|--------|
| Healthcare APIs | Healthcare APIs architecture with FHIR, Dicom, IoT connectors, and requisite infrastructure for Healthcare solutions |[![Deploy To Microsoft Cloud](../../../docs/deploytomicrosoftcloud.svg)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2FhealthcareArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2Findustry%2Fmain%2Fhealthcare%2Fsolutions%2FhealthcareApis%2Fhealthcare-portal.json)

![Healthcare Industry Reference Architecture](./images/mc4h-reference-architecture.png)


## Overview

Add description and context
## Azure Healthcare API

![Healthcare API architecture ](./images/healthcareapi.png "Healthcare API")

## FHIR Service

The FHIR service is a set of tools to combine and store disparate health datasets and standardize data in the cloud. The service offers a set of search options to query the persisted data or export for consumption by other services.

## DICOM Service

The DICOM Service enables the secure exchange of medical images and associated metadata with any DICOMweb™ enabled systems.
QIDO, WADO, and STOW supports query, retrieve, and store of DICOM objects.
Ingests and persists DICOM data from VNA, PACS and other medical imaging systems at thousands of images per second.
DICOM Custom Tags allows for user defined, searchable tags.​

## IOT Connector

The IOT Connector ingests streaming data from devices in real-time at millions of events per second.
Customized settings allow developers to manage device content, sample data rates, and set the desired capture thresholds.
Device data is normalized, grouped, and mapped to FHIR that can be sent via FHIR APIs to an EHR or other FHIR Service.

## Deployment instructions

add screenshots and description
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

Exsample of a search that returns all non-femail patients:

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

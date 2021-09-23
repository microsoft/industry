# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# Define script arguments
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $PowerPlatformEnvironmentId,

    [Parameter(Mandatory = $true)]
    [String]
    $OrganizationUrl,

    [Parameter(Mandatory = $true)]
    [String]
    $OrganizationId,

    [Parameter(Mandatory = $true)]
    [String]
    $SynapseId,

    [Parameter(Mandatory = $true)]
    [String]
    $DataverseDataLakeFileSystemId,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [Array]
    $Entities,

    [Parameter(DontShow)]
    [String]
    $ExportDataLakeApplicationId = "7f15f9d9-cad0-44f1-bbba-d36650e07765",

    [Parameter(DontShow)]
    [String]
    $PowerPlatformApplicationId = "f3b07414-6bf4-46e6-b63f-56941f3f4128"
)

# Import Helper Functions
Write-Output "Importing Helper Functions"
. "$PSScriptRoot\Helper.ps1"

# Check existence of Enterprise Applications: 'Export to data lake' and 'Microsoft Power Query'
Write-Output "Checking existence of Enterprise Applications: 'Export to data lake' and 'Microsoft Power Query'"
$exportDataLakeServicePrincipal = Get-AzADServicePrincipal `
    -ApplicationId $ExportDataLakeApplicationId
Write-Output "'Expor Data Lake' Service Principle Details: '${exportDataLakeServicePrincipal}'"

$powerPlatformServicePrincipal = Get-AzADServicePrincipal `
    -ApplicationId $PowerPlatformApplicationId
Write-Output "'Microsoft Power Query' Service Principle Details: '${powerPlatformServicePrincipal}'"

# Add Synapse Role Assignment
Write-Output "Adding Synapse Role Assignment"
$synapseSubscriptionId = $SynapseId.Split("/")[2]
$synapseName = $SynapseId.Split("/")[-1]

Set-AzContext `
    -Subscription $synapseSubscriptionId

# More role details: "{"id": "6e4bf58a-b8e1-4cc3-bbf9-d73143322b78", "isBuiltIn": true, "name": "Synapse Administrator"},"
New-AzSynapseRoleAssignment `
    -WorkspaceName $synapseName `
    -RoleDefinitionName "Synapse Administrator" `
    -ObjectId $exportDataLakeServicePrincipal.Id

# Get Power App Access Token
Write-Output "Getting Power App Access Token"
$powerAppAccessToken = (Get-AzAccessToken -ResourceUrl "${ExportDataLakeApplicationId}").Token

# Update Organization Details
Write-Output "Updating Organization Details"
Update-OrganizationDetails `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -OrganizationUrl $OrganizationUrl `
    -OrganizationId $OrganizationId `
    -AccessToken $powerAppAccessToken

# Create New Data Lake Details
Write-Output "Creating New Data Lake Details"
$datalakeDetails = New-LakeDetails `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -DataLakeFileSystemId $DataverseDataLakeFileSystemId `
    -SynapseId $SynapseId `
    -AccessToken $powerAppAccessToken
Write-Output "New Data Lake Details: '${datalakeDetails}'"

# Sleep for X Seconds to give the Backend Process some time to Finish
$seconds = 10
Write-Host "Sleeping for ${seconds} Seconds to give the Backend Process some time to Finish"
Start-Sleep -Seconds $seconds

# Create New Data Lake Profile
Write-Output "Creating New Data Lake Profile"
$datalakeProfile = New-LakeProfile `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -DataLakeFileSystemId $DataverseDataLakeFileSystemId `
    -LakeDetailsId $datalakeDetails.Id `
    -Entities $Entities `
    -AccessToken $powerAppAccessToken
Write-Output "New Data Lake Profile: '${datalakeProfile}'"

# Sleep for X Seconds to give the Backend Process some time to Finish
$seconds = 10
Write-Host "Sleeping for ${seconds} Seconds to give the Backend Process some time to Finish"
Start-Sleep -Seconds $seconds

# Activate Lake Profile
Write-Output "Activating Lake Profile"
$datalakeProfileActivation = New-LakeProfileActivation `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -LakeDetailsId $datalakeDetails.Id `
    -AccessToken $powerAppAccessToken
Write-Output "New Data Lake Profile Activation: '${datalakeProfileActivation}'"

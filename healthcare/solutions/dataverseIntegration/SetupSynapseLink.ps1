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

New-AzSynapseRoleAssignment `
    -WorkspaceName $synapseName `
    -RoleDefinitionName "Workspace Admin" `  # More role details: "{"id": "6e4bf58a-b8e1-4cc3-bbf9-d73143322b78", "isBuiltIn": true, "name": "Workspace Admin"},"
    -ObjectId $exportDataLakeServicePrincipal.Id

# Create File Systems on Data Lake
Write-Output "Creating File Systems on Data Lake"
$dataLakeSubscriptionId = $DataLakeId.Split("/")[2]
$dataLakeName = $DataLakeId.Split("/")[-1]
$powerPlatformContainerName = "power-platform-dataflows"
$dataverseContainerName = "dataverse"

Set-AzContext `
    -Subscription $dataLakeSubscriptionId

$context = New-AzStorageContext `
    -StorageAccountName $dataLakeName

New-AzureStorageContainer `
    -Context $context `
    -Name $powerPlatformContainerName

New-AzureStorageContainer `
    -Context $context `
    -Name $dataverseContainerName

#Add Role Assignments for 'Export to data lake' Enterprise Application
Write-Output "Adding Role Assignments for 'Export to data lake' Enterprise Application"
New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Owner" `
    -Scope $DataLakeId

New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Storage Blob Data Owner" `
    -Scope $DataLakeId

New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Storage Blob Data Contributor" `
    -Scope $DataLakeId

New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Storage Account Contributor" `
    -Scope $DataLakeId

New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Storage Account Contributor" `
    -Scope "${DataLakeId}/blobServices/default/containers/${dataverseContainerName}"

New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Owner" `
    -Scope "${DataLakeId}/blobServices/default/containers/${dataverseContainerName}"

New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Storage Blob Data Owner" `
    -Scope "${DataLakeId}/blobServices/default/containers/${dataverseContainerName}"

New-AzRoleAssignment `
    -ObjectId $exportDataLakeServicePrincipal.Id `
    -RoleDefinitionId "Storage Blob Data Contributor" `
    -Scope "${DataLakeId}/blobServices/default/containers/${dataverseContainerName}"

# Add Role Assignments for 'Microsoft Power Query' Enterprise Application
Write-Output "Adding Role Assignments for 'Microsoft Power Query' Enterprise Application"
New-AzRoleAssignment `
    -ObjectId $powerPlatformServicePrincipal.Id `
    -RoleDefinitionId "Reader and Data Access" `
    -Scope $DataLakeId

New-AzRoleAssignment `
    -ObjectId $powerPlatformServicePrincipal.Id `
    -RoleDefinitionId "Storage Blob Data Owner" `
    -Scope "${DataLakeId}/blobServices/default/containers/${powerPlatformContainerName}"

# Update Organization Details
Write-Output "Creating New Data Lake Details"
Update-OrganizationDetails `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -OrganizationUrl $OrganizationUrl `
    -OrganizationId $OrganizationId

# Create New Data Lake Details
Write-Output "Creating New Data Lake Details"
$datalakeDetails = New-LakeDetails `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -DataLakeFileSystemId $DataverseDataLakeFileSystemId `
    -SynapseId $SynapseId
Write-Output "New Data Lake Details: '${datalakeDetails}'"

# Create New Data Lake Profile
Write-Output "Creating New Data Lake Profile"
$datalakeProfile = New-LakeProfile `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -DataLakeFileSystemId $DataverseDataLakeFileSystemId `
    -LakeDetailsId $datalakeDetails.Id `
    -Entities $Entities
Write-Output "New Data Lake Profile: '${datalakeProfile}'"

# Activate Lake Profile
Write-Output "Activating Lake Profile"
$datalakeProfileActivation = New-LakeProfileActivation `
    -PowerPlatformEnvironmentId $PowerPlatformEnvironmentId `
    -LakeDetailsId $datalakeDetails.Id
Write-Output "New Data Lake Profile Activation: '${datalakeProfileActivation}'"

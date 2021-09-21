function Update-OrganizationDetails {
    <#
    .SYNOPSIS
        Updates Organization details for the Power Platform environment.
    .DESCRIPTION
        Update-OrganizationDetails creates a new Data Lake configuration in the Power Platform environment.
    .PARAMETER PowerPlatformEnvironmentId
        Function expects the power platform environment id in which the Data Lake configuration
        will be created.
    .PARAMETER OrganizationUrl
        Function expects the organization url (e.g. 'https://org111aa111.crm.dynamics.com/').
    .PARAMETER OrganizationId
        Function expects the organization Id (e.g. 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa').
    .EXAMPLE
        Update-OrganizationDetails -PowerPlatformEnvironmentId "<your-power-platform-environment-id>" -OrganizationUrl "<your-organization-url>" -OrganizationId "<your-organization-id>"
    .NOTES
        Author:  Marvin Buss
        GitHub:  @marvinbuss
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $PowerPlatformEnvironmentId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $OrganizationUrl,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $OrganizationId
    )
    # Set Graph API URI
    Write-Verbose "Setting Power Platform URI"
    $powerPlatformUri = "https://athenawebservice.eus-il105.gateway.prod.island.powerapps.com/environment/${PowerPlatformEnvironmentId}/updateorganizationdetails?organizationUrl=${OrganizationUrl}&organizationId=${OrganizationId}"

    # Define parameters based on input parameters
    Write-Verbose "Defining parameters based on input parameters"
    $azureAccessToken = (Get-AzAccessToken).Token

    # Set header for REST call
    Write-Verbose "Setting header for REST call"
    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer ${azureAccessToken}"
    }

    # Define parameters for REST method
    Write-Verbose "Defining parameters for pscore method"
    $parameters = @{
        "Uri"         = $powerPlatformUri
        "Method"      = "Post"
        "Headers"     = $headers
        "ContentType" = "application/json"
    }

    # Invoke REST API
    Write-Verbose "Invoking REST API"
    try {
        $response = Invoke-RestMethod @parameters
        Write-Verbose "Response: ${response}"
    }
    catch {
        Write-Error "REST API call failed"
        throw "REST API call failed"
    }
    return $response
}


function New-LakeDetails {
    <#
    .SYNOPSIS
        Creates New Lake Configuration in the Power Platform environment.
    .DESCRIPTION
        New-LakeDetails creates a new Data Lake configuration in the Power Platform environment.
    .PARAMETER PowerPlatformEnvironmentId
        Function expects the power platform environment id in which the Data Lake configuration
        will be created.
    .PARAMETER DataLakeFileSystemId
        Function expects the data lake file system resource id which should be
        connected to the power platform.
    .EXAMPLE
        New-LakeDetails -PowerPlatformEnvironmentId "<your-power-platform-environment-id>" -DataLakeFileSystemId "<your-datalake-filesystem-id>"
    .NOTES
        Author:  Marvin Buss
        GitHub:  @marvinbuss
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $PowerPlatformEnvironmentId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $DataLakeFileSystemId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $SynapseId
    )
    # Set Graph API URI
    Write-Verbose "Setting Power Platform URI"
    $powerPlatformUri = "https://athenawebservice.eus-il105.gateway.prod.island.powerapps.com/environment/${PowerPlatformEnvironmentId}/lakedetails"

    # Define parameters based on input parameters
    Write-Verbose "Defining parameters based on input parameters"
    $azureAccessToken = (Get-AzAccessToken).Token
    $tenantId = (Get-AzTenant).Id
    $dataLakeSubscriptionId = $DataLakeId.Split("/")[2]
    $dataLakeResourceGroupName = $DataLakeId.Split("/")[4]
    $dataLakeName = $DataLakeId.Split("/")[8]
    $dataLakeFileSystemName = $DataLakeId.Split("/")[-1]

    $synapseSubscriptionId = $SynapseId.Split("/")[2]
    $synapseResourceGroupName = $SynapseId.Split("/")[4]
    $synapseName = $SynapseId.Split("/")[-1]

    if (($synapseSubscriptionId -ne $dataLakeSubscriptionId) -or ($synapseResourceGroupName -ne $dataLakeResourceGroupName)) {
        Write-Error "Synapse workspace and Data Lake are not in the same Subscription and/or Resource Group"
        throw "Synapse workspace and Data Lake are not in the same Subscription and/or Resource Group"
    }

    # Set header for REST call
    Write-Verbose "Setting header for REST call"
    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer ${azureAccessToken}"
    }

    # Set body for REST call
    Write-Verbose "Setting body for REST call"
    $body = @{
        "TenantId"             = $tenantId
        "SubscriptionId"       = $dataLakeSubscriptionId
        "ResourceGroupName"    = $dataLakeResourceGroupName
        "StorageAccountName"   = $dataLakeName
        "BlobEndpoint"         = "https://${dataLakeName}.blob.core.windows.net/"
        "FileEndpoint"         = "https://${dataLakeName}.file.core.windows.net/"
        "QueueEndpoint"        = "https://${dataLakeName}.queue.core.windows.net/"
        "TableEndpoint"        = "https://${dataLakeName}.table.core.windows.net/"
        "FileSystemEndpoint"   = "https://${dataLakeName}.dfs.core.windows.net/"
        "FileSystemName"       = $dataLakeFileSystemName
        "SqlODEndpoint"        = "${synapseName}-ondemand.sql.azuresynapse.net"
        "WorkspaceDevEndpoint" = "https://${synapseName}.dev.azuresynapse.net"
        "IsDefault"            = $true
    } | ConvertTo-Json

    # Define parameters for REST method
    Write-Verbose "Defining parameters for pscore method"
    $parameters = @{
        "Uri"         = $powerPlatformUri
        "Method"      = "Post"
        "Headers"     = $headers
        "Body"        = $body
        "ContentType" = "application/json"
    }

    # Invoke REST API
    Write-Verbose "Invoking REST API"
    try {
        $response = Invoke-RestMethod @parameters
        Write-Verbose "Response: ${response}"
    }
    catch {
        Write-Error "REST API call failed"
        throw "REST API call failed"
    }
    return $response
}


function New-LakeProfile {
    <#
    .SYNOPSIS
        Creates New Lake Profile based on the Data Lake Configuration in the Power Platform environment.
    .DESCRIPTION
        New-LakeProfile creates a new Data Lake profile in the Power Platform environment.
    .PARAMETER PowerPlatformEnvironmentId
        Function expects the power platform environment id in which the Data Lake configuration
        will be created.
    .PARAMETER DataLakeFileSystemId
        Function expects the data lake file system resource id which should be
        connected to the power platform.
    .PARAMETER LakeDetailsId
        Function expects the ID of the Lake Details/Lake configuration object.
    .PARAMETER Entities
        Function expects a definition of the entities that should be synched to the Data Lake.
    .EXAMPLE
        New-LakeProfile -PowerPlatformEnvironmentId "<your-power-platform-environment-id>" -DataLakeFileSystemId "<your-datalake-filesystem-id>" -LakeDetailsId "<your-lake-details-id>" -Entities @[@{"Type": "msdyn_actual", "RecordCountPerBlock": 0, "PartitionStrategy": "Month", "AppendOnlyMode": false, "Settings": @{}}]
    .NOTES
        Author:  Marvin Buss
        GitHub:  @marvinbuss
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $PowerPlatformEnvironmentId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $DataLakeFileSystemId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $LakeDetailsId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Array]
        $Entities  # Sample Input: [{"Type": "msdyn_actual", "RecordCountPerBlock": 0, "PartitionStrategy": "Month", "AppendOnlyMode": false, "Settings": {}}, {"Type": "adx_ad", "RecordCountPerBlock": 0, "PartitionStrategy": "Month", "AppendOnlyMode": false, "Settings": {}}]
    )
    # Set Graph API URI
    Write-Verbose "Setting Power Platform URI"
    $powerPlatformUri = "https://athenawebservice.eus-il105.gateway.prod.island.powerapps.com/environment/${PowerPlatformEnvironmentId}/lakedetails/${LakeDetailsId}"

    # Define parameters based on input parameters
    Write-Verbose "Defining parameters based on input parameters"
    $azureAccessToken = (Get-AzAccessToken).Token
    $dataLakeName = $DataLakeId.Split("/")[8]

    # Set header for REST call
    Write-Verbose "Setting header for REST call"
    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer ${azureAccessToken}"
    }

    # Set body for REST call
    Write-Verbose "Setting body for REST call"
    $body = @{
        "DestinationType"            = 4
        "Entities"                   = $Entities
        "IsOdiEnabled"               = $false
        "Name"                       = $dataLakeName
        "RetryPolicy"                = @{
            "IntervalInSeconds" = 5
            "MaxRetryCount"     = 12
        }
        "SchedulerIntervalInMinutes" = 60
        "WriteDeleteLog"             = $true
    } | ConvertTo-Json

    # Define parameters for REST method
    Write-Verbose "Defining parameters for pscore method"
    $parameters = @{
        "Uri"         = $powerPlatformUri
        "Method"      = "Post"
        "Headers"     = $headers
        "Body"        = $body
        "ContentType" = "application/json"
    }

    # Invoke REST API
    Write-Verbose "Invoking REST API"
    try {
        $response = Invoke-RestMethod @parameters
        Write-Verbose "Response: ${response}"
    }
    catch {
        Write-Error "REST API call failed"
        throw "REST API call failed"
    }
    return $response
}


function New-LakeProfileActivation {
    <#
    .SYNOPSIS
        Activates previously created Lake Profile in the Power Platform environment.
    .DESCRIPTION
        New-LakeProfileActivation activates a Data Lake profile in the Power Platform environment.
    .PARAMETER PowerPlatformEnvironmentId
        Function expects the power platform environment id in which the Data Lake configuration
        will be created.
    .PARAMETER LakeDetailsId
        Function expects the ID of the Lake Details/Lake configuration object.
    .EXAMPLE
        New-LakeProfileActivation -PowerPlatformEnvironmentId "<your-power-platform-environment-id>" -LakeDetailsId "<your-lake-details-id>"
    .NOTES
        Author:  Marvin Buss
        GitHub:  @marvinbuss
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $PowerPlatformEnvironmentId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $LakeDetailsId
    )
    # Set Graph API URI
    Write-Verbose "Setting Power Platform URI"
    $powerPlatformUri = "https://athenawebservice.eus-il105.gateway.prod.island.powerapps.com/environment/${PowerPlatformEnvironmentId}/lakedetails/${LakeDetailsId}/activate"

    # Define parameters based on input parameters
    Write-Verbose "Defining parameters based on input parameters"
    $azureAccessToken = (Get-AzAccessToken).Token

    # Set header for REST call
    Write-Verbose "Setting header for REST call"
    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer ${azureAccessToken}"
    }

    # Define parameters for REST method
    Write-Verbose "Defining parameters for pscore method"
    $parameters = @{
        "Uri"         = $powerPlatformUri
        "Method"      = "Post"
        "Headers"     = $headers
        "ContentType" = "application/json"
    }

    # Invoke REST API
    Write-Verbose "Invoking REST API"
    try {
        $response = Invoke-RestMethod @parameters
        Write-Verbose "Response: ${response}"
    }
    catch {
        Write-Error "REST API call failed"
        throw "REST API call failed"
    }
    return $response
}

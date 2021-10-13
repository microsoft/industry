[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]
    $EnvironmentPrefix,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('unitedstates', 'europe', 'asia', 'australia', 'india', 'japan', 'canada', 'unitedkingdom', 'unitedstatesfirstrelease', 'southamerica', 'france', 'switzerland', 'germany', 'unitedarabemirates')]
    [String]
    $Location
)

$Environments = @()
$Environments += "$($EnvironmentPrefix)-prod"
$Environments += "$($EnvironmentPrefix)-dev"
$Environments += "$($EnvironmentPrefix)-test"

# Get token to authenticate to Power Platform

$Token = (Get-AzAccessToken).Token

# Power Platform API base Uri
$BaseUri = "https://api.bap.microsoft.com"

# Power Plaform HTTP Get Environment Uri
$GetEnvironment = '/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments?$expand=permissions&api-version=2016-11-01'

# Power Platform HTTP Post Environment Uri
$PostEnvironment = '/providers/Microsoft.BusinessAppPlatform/environments?api-version=2019-05-01&ud=/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments'

# Power Platform HTTP Get DLP Policy Uri
$GetPolicies = "https://api.bap.microsoft.com/providers/Microsoft.BusinessAppPlatform/scopes/admin/apiPolicies?api-version=2016-11-01"

# Declare Rest headers
$Headers = @{
    "Content-Type"  = "application/json"
    "Authorization" = "Bearer $($Token)"
}

foreach ($Env in $Environments) {
    Write-host "Creating Environment $($Env)"

    # Form the request body to create new Environments in Power Platform
    # Declaring the HTTP Post request

    $PostBody = @{
        "properties" = @{
            "linkedEnvironmentMetadata" = @{
                "baseLanguage" = ''
                "domainName"   = "$($Env)"
                "templates"    = @("D365_DeveloperEdition")
            }
            "databaseType"              = "CommonDataService"
            "displayName"               = "$($Env)"
            "environmentSku"            = "Production"
        }
        "location"   = "$($Location)"
    }

    $PostParameters = @{
        "Uri"         = "$($baseUri)$($postEnvironment)"
        "Method"      = "Post"
        "Headers"     = $headers
        "Body"        = $postBody | ConvertTo-json -Depth 100
        "ContentType" = "application/json"
    }

    Write-Host "Invoking the request to create $($Env)"

    try {
        $response = Invoke-RestMethod @PostParameters
        Write-Host "Environment $($Env) is being created..."
    }
    catch {
        Write-Error "Creation of Environment $($Env) failed`r`n$_"
        throw "REST API call failed drastically"
    }

    # Get newly created environments
    
    $GetParameters = @{
        "Uri"         = "$($BaseUri)$($GetEnvironment)"
        "Method"      = "Get"
        "Headers"     = $headers
        "ContentType" = "application/json"
    }

    Write-Host "Checking environment status for $($Env)"
    Start-Sleep -Seconds 30
    try {
        $response = Invoke-RestMethod @GetParameters
    }
    catch {
        Write-Host "Retrieving the environment failed.`r`n$_"
        throw "Ouch...."
    }
    $response.value.properties | Where-Object { $_.displayName -eq $($Env) } | Sort-Object -Property createdTime -Descending | Foreach-Object -Process {
        [PSCustomObject]@{
            Name              = $_.displayName
            environmentType   = $_.environmentType
            provisioningState = $_.provisioningState
            azureRegionHint   = $_.azureRegionHint
            createdTime       = $_.createdTime
            resourceId        = $_.linkedEnvironmentMetadata.resourceId
        }
    }
}

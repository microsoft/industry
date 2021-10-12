[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]
    $EnvironmentPrefix,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
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
                "domainName" = "$($Env)"
                "templates" = ''
            }
            "databaseType" = "CommonDataService"
            "displayName" = "$($Env)"
            "environmentSku" = "Production"
        }
        "location" = "$($Location)"
    }

    $PostParameters = @{
        "Uri"         = "$($baseUri)$($postEnvironment)"
        "Method"      = "Post"
        "Headers"     = $headers
        "Body"        = $postBody | ConvertTo-json
        "ContentType" = "application/json"
    }

    Write-Host "Invoking REST API to create $($Env)"
    
    try {
        $response = Invoke-RestMethod @PostParameters
        Write-Host "Environment $($Env) is being created..."
    }
    catch {
        Write-Error "Creation of Environment $($Env) failed"
        throw "REST API call failed drastically"
    }

    # Get newly created environments
    Start-Sleep -Seconds 10

    $GetParameters = @{
        "Uri"         = "$($BaseUri)$($GetEnvironment)"
        "Method"      = "Get"
        "Headers"     = $headers
        "ContentType" = "application/json"
    }

    Write-Host "Checking environment status for $($Env)"
    try {
        $response = Invoke-RestMethod @GetParameters
        Write-Host $response
    }
    catch {
        Write-Host "Retrieving the environment failed.."
        throw "Ouch...."
    }
    return $response.value.properties | where-object {$_.displayName -eq $($Env)} | Select-Object -Property displayname, environmentType, provisioningState, azureRegionHint  #| convertto-json -depth 100
    ## [Newtonsoft.Json.Linq.JObject]::Parse($response.content).ToString()
}
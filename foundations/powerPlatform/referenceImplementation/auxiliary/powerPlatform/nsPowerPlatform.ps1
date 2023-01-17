<#
    PowerShell script to bootstrap/configure Power Platform from the North Star Reference Implementation. (aka.ms/ppnorthstar)
    Note: The script is designed and optimized to run as a deploymentScript invoked from Azure Resource Manager.
    Refer to https://github.com/microsoft/industry/blob/main/foundations/powerPlatform/referenceImplementation/auxiliary/powerPlatform/ppDeploymentScript.json for details around the input parameters.
#>
[CmdletBinding()]
param (
    #Security, govarnance and compliance
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPGuestMakerSetting,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPAppSharingSetting,
    #Admin environment and settings
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPEnvCreationSetting,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPTrialEnvCreationSetting,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPEnvCapacitySetting,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPTenantIsolationSetting,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPTenantDLP,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPTenantIsolationDomains,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPAdminEnvNaming,
    [ValidateSet('unitedstates', 'europe', 'asia', 'australia', 'india', 'japan', 'canada', 'unitedkingdom', 'unitedstatesfirstrelease', 'southamerica', 'france', 'switzerland', 'germany', 'unitedarabemirates', 'norway')][Parameter(Mandatory = $false)][string]$PPAdminRegion,
    [Parameter(Mandatory = $false)][string]$PPAdminBilling,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPAdminCoeSetting,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPAdminDlp,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPAdminEnvEnablement,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPAdminManagedEnv,
    #Landing Zones
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPDefaultRenameText,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPDefaultDLP,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPDefaultManagedEnv,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPDefaultManagedSharing,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizen,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenCount,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenNaming,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenRegion,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenDlp,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenBilling,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenManagedEnv,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenAlm,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenDescription,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenCurrency,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPCitizenLanguage,
    [Parameter(Mandatory = $false)]$PPCitizenConfiguration,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPPro,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProCount,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProNaming,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProRegion,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProDlp,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProBilling,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProManagedEnv,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProAlm,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProDescription,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProCurrency,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPProLanguage,
    [Parameter(Mandatory = $false)]$PPProConfiguration,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPSelectIndustry,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPIndustryNaming,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPIndustryRegion,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPIndustryBilling,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPIndustryAlm,
    [Parameter(Mandatory = $false)][string][AllowEmptyString()][AllowNull()]$PPIndustryManagedEnv
)

$DeploymentScriptOutputs = @{}
#Install required modules
Install-Module -Name PowerOps -AllowPrerelease -Force

#Default ALM environment tiers
$envTiers = 'dev', 'test', 'prod'

#region supporting functions
function New-EnvironmentCreationObject {
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'ARMInputString')]$ARMInputString,
        [Parameter(Mandatory = $true, ParameterSetName = 'EnvCount')][int]$EnvCount,
        [Parameter(Mandatory = $true, ParameterSetName = 'EnvCount')]$EnvNaming,
        [Parameter(Mandatory = $true, ParameterSetName = 'EnvCount')]$EnvRegion,
        [Parameter(Mandatory = $true, ParameterSetName = 'EnvCount')]$EnvLanguage,
        [Parameter(Mandatory = $true, ParameterSetName = 'EnvCount')]$EnvCurrency,
        [Parameter(Mandatory = $true, ParameterSetName = 'EnvCount')]$EnvDescription,
        [Parameter(Mandatory = $false)][switch]$EnvALM,
        [Parameter(Mandatory = $false, ParameterSetName = 'EnvCount')][switch]$EnvDataverse
    )
    if (-not [string]::IsNullOrEmpty($ARMInputString)) {
        foreach ($env in ($ARMInputString -split 'ppEnvName:')) {
            if ($env -match ".") {
                $environment = $env.TrimEnd(',')
                if ($EnvALM) {
                    foreach ($envTier in $envTiers) {
                        [PSCustomObject]@{
                            envRegion      = ($environment -split (','))[2].Split(':')[1]
                            envLanguage    = ($environment -split (','))[3].Split(':')[1]
                            envCurrency    = ($environment -split (','))[4].Split(':')[1]
                            envDescription = ($environment -split (','))[1].Split(':')[1]
                            envRbac        = ($environment -split (','))[5].Split(':')[1]
                            envName        = '{0}-{1}' -f ($environment -split (','))[0], $envTier
                        }
                    }
                }
                else {
                    [PSCustomObject]@{
                        envName        = ($environment -split (','))[0]
                        envRegion      = ($environment -split (','))[2].Split(':')[1]
                        envLanguage    = ($environment -split (','))[3].Split(':')[1]
                        envCurrency    = ($environment -split (','))[4].Split(':')[1]
                        envDescription = ($environment -split (','))[1].Split(':')[1]
                        envRbac        = ($environment -split (','))[5].Split(':')[1]
                    }
                }
            }
        }
    }
    else {
        1..$EnvCount | ForEach-Object -Process {
            $environmentName = "{0}-{1:d3}" -f $EnvNaming, $_
            if ($true -eq $EnvALM) {
                foreach ($envTier in $envTiers) {
                    [PSCustomObject]@{
                        envName        = "{0}-{1}" -f $environmentName, $envTier
                        envRegion      = $EnvRegion
                        envDataverse   = $EnvDataverse
                        envLanguage    = $envLanguage
                        envCurrency    = $envCurrency
                        envDescription = $envDescription
                        envRbac        = ''
                    }
                }
            }
            else {
                [PSCustomObject]@{
                    envName        = $environmentName
                    envRegion      = $EnvRegion
                    envDataverse   = $EnvDataverse
                    envLanguage    = $envLanguage
                    envCurrency    = $envCurrency
                    envDescription = $envDescription
                    envRbac        = ''
                }
            }
        }
    }
}
function New-DLPAssignmentFromEnv {
    param (
        [Parameter(Mandatory = $true)][string[]]$Environments,
        [Parameter(Mandatory = $true)][string]$EnvironmentDLP
    )
    #DLP Template references
    $dlpPolicies = @{
        baseUri          = 'https://raw.githubusercontent.com/microsoft/industry/main/foundations/powerPlatform/referenceImplementation/auxiliary/powerPlatform/'
        tenant           = @{
            low    = 'lowTenantDlpPolicy.json'
            medium = 'mediumTenantDlpPolicy.json'
            high   = 'highTenantDlpPolicy.json'
        }
        defaultEnv       = 'defaultEnvDlpPolicy.json'
        adminEnv         = 'adminEnvDlpPolicy.json'
        citizenDlpPolicy = 'citizenDlpPolicy.json'
        proDlpPolicy     = 'proDlpPolicy.json'
    }

    # Get base template from repo
    $templateFile = if ($EnvironmentDLP -in 'low', 'medium', 'high') { $dlpPolicies['tenant'].$EnvironmentDLP } else { $dlpPolicies["$EnvironmentDLP"] }
    if ([string]::IsNullOrEmpty($templateFile)) {
        throw "Cannot find DLP template $EnvironmentDLP"
    }
    try {
        $template = (Invoke-WebRequest -Uri ($dlpPolicies['BaseUri'] + $templateFile)).Content | ConvertFrom-Json -Depth 100
        Write-Output "Using base DLP template $templatefile"
    }
    catch {
        throw "Failed to get template $templatefile from $($dlpPolicies['baseUri'])"
    }

    # Handle environment inclusion
    if (($Environments -contains 'AllEnvironments' -and $Environments.count -gt 1) -or ($Environments -ne 'AllEnvironments')) {
        $environmentsToIncludeorExclude = $Environments | Where-Object { $_ -notlike 'AllEnvironments' } | ForEach-Object -Process {
            $envDisplayName = $_
            $envDetails = ''
            $envDetails = Get-PowerOpsEnvironment | Where-Object { $_.properties.displayName -eq $envDisplayName }
            [PSCustomObject]@{
                id   = $envDetails.id
                name = $envDetails.name
                type = 'Microsoft.BusinessAppPlatform/scopes/environments'
            }
        }
        if ($environmentsToIncludeorExclude.count -eq 1) {
            $template.environments | Add-Member -Type NoteProperty -Name id -Value $environmentsToIncludeorExclude.id -Force
            $template.environments | Add-Member -Type NoteProperty -Name name -Value $environmentsToIncludeorExclude.name -Force
        }
        else {
            $template.environments = $environmentsToIncludeorExclude
        }
        if ($Environments -contains 'AllEnvironments') {
            $template.environmentType = 'ExceptEnvironments'
        }
        else {
            $template.environmentType = 'OnlyEnvironments'
        }
    }
    # Convert template back to json and
    $template | ConvertTo-Json -Depth 100 -EnumsAsStrings | Set-Content -Path $templateFile -Force
    try {
        $null = New-PowerOpsDLPPolicy -TemplateFile $templateFile -Name $template.displayName -ErrorAction Stop
        Write-Output "Created Default $EnvironmentDLP DLP Policy"
    }
    catch {
        Write-Warning "Created Default $EnvironmentDLP DLP Policy`r`n$_"
    }
}
#endregion supporting functions

#region set tenant settings
# Only change tenant settings if "Setting" parameters have been provided
if ($PSBoundParameters.Keys -match "Setting") {
    # Get existing tenant settings
    #TODO - add condition so script can be used without changing tenant settings
    $existingTenantSettings = Get-PowerOpsTenantSettings
    # Update tenant settings
    $tenantSettings = $existingTenantSettings
    $tenantSettings.disableTrialEnvironmentCreationByNonAdminUsers = $PPTrialEnvCreationSetting -eq 'Yes'
    $tenantSettings.powerPlatform.powerApps.enableGuestsToMake = $PPGuestMakerSetting -eq 'No'
    $tenantSettings.powerPlatform.powerApps.disableShareWithEveryone = $PPAppSharingSetting -eq 'Yes'
    $tenantSettings.disableEnvironmentCreationByNonAdminUsers = $PPEnvCreationSetting -eq 'Yes'
    $tenantSettings.disableCapacityAllocationByEnvironmentAdmins = $PPEnvCapacitySetting -eq 'Yes'

    # Update tenant settings

    try {
        $tenantRequest = @{
            Path        = '/providers/Microsoft.BusinessAppPlatform/scopes/admin/updateTenantSettings'
            Method      = 'Post'
            RequestBody = ($tenantSettings | ConvertTo-Json -Depth 100)
        }
        $null = Invoke-PowerOpsRequest @tenantRequest
        Write-Output "Updated tenant settings"
    }
    catch {
        throw "Failed to set tenant settings"
    }
}

# Tenant Isolation settings
if ($PPTenantIsolationSetting -in 'inbound', 'outbound', 'both') {
    $tenantIsolationSettings = @{
        Enabled = $true
    }
    if ($PPTenantIsolationDomains) {
        $tenantIsolationSettings.TenantId = $PPTenantIsolationDomains
        if ($PPTenantIsolationSetting -eq 'both') {
            $tenantIsolationSettings.AllowedDirection = 'InboundAndOutbound'
        }
        else {
            $tenantIsolationSettings.AllowedDirection = $PPTenantIsolationSetting
        }
    }

    try {
        Set-PowerOpsTenantIsolation @tenantIsolationSettings
        Write-Output "Updated tenant isolation settings with $PPTenantIsolationSetting/$PPTenantIsolationDomains"
    }
    catch {
        throw "Failed to update tenant isolation settings"
    }
}
#endregion set tenant settings

#region default environment
# Get default environment
# Retry logic to handle green field deployments
$defaultEnvAttempts = 0
do {
    $defaultEnvAttempts++
    $defaultEnvironment = Get-PowerOpsEnvironment | Where-Object { $_.Properties.environmentSku -eq "Default" }
    if (-not ($defaultEnvironment)) {
        Write-Output "Getting default environment - attempt $defaultEnvAttempts"
        Start-Sleep -Seconds 15
    }
} until ($defaultEnvironment -or $defaultEnvAttempts -eq 15)

# Rename default environment if parameter provided
if (-not [string]::IsNullOrEmpty($PPDefaultRenameText)) {
    # Get old default environment name
    $oldDefaultName = $defaultEnvironment.properties.displayName
    if ($PPDefaultRenameText -ne $oldDefaultName) {
        $defaultEnvironment.properties.displayName = $PPDefaultRenameText
        $defaultEnvRequest = @{
            Path        = '/providers/Microsoft.BusinessAppPlatform/scopes/admin/environments/{0}' -f $defaultEnvironment.name
            Method      = 'Patch'
            RequestBody = ($defaultEnvironment | ConvertTo-Json -Depth 100)
        }
        try {
            Invoke-PowerOpsRequest @defaultEnvRequest
            Write-Output "Renamed default environment from $oldDefaultName to $PPDefaultRenameText"
        }
        catch {
            Write-Warning "Failed to rename Default Environment`r`n$_"
        }
    }
}
# Create DLP policy for default environment
if ($PPDefaultDLP -eq 'Yes') {
    # Get default recommended DLP policy from repo
    try {
        New-DLPAssignmentFromEnv -Environments $defaultEnvironment.properties.displayName -EnvironmentDLP 'defaultEnv'
    }
    catch {
        Write-Warning "Failed to create Default Environment DLP Policy`r`n$_"
    }
}
# Enable managed environment for default environment
if ($defaultEnvironment.properties.governanceConfiguration.protectionLevel -ne 'Standard' -and $PPDefaultManagedEnv -eq 'Yes') {
    try {
        Write-Output "Enabling managed environment for the default environment"
        Enable-PowerOpsManagedEnvironment -EnvironmentName $defaultEnvironment.name -GroupSharingDisabled ($PPDefaultManagedSharing -eq 'Yes')
    }
    catch {
        Write-Warning "Failed to enable managed environment for default environment"
    }

}
#endregion default environment

#region create admin environments and import COE solution
if ($PPAdminEnvEnablement -eq 'Yes' -and -not [string]::IsNullOrEmpty($PPAdminEnvNaming)) {
    # Create environment
    foreach ($envTier in $envTiers) {
        try {
            $adminEnvName = '{0}-admin-{1}' -f $PPAdminEnvNaming, $envTier
            $null = New-PowerOpsEnvironment -Name $adminEnvName -Location $PPAdminRegion -Dataverse $true -ManagedEnvironment ($PPAdminManagedEnv -eq 'Yes')
            Write-Output "Created environment $adminEnvName in $PPAdminRegion"
        }
        catch {
            throw "Failed to create admin environment $adminEnvName`r `n$_"
        }
    }

    # Assign DLP to created environments
    if ($PPAdminDlp -eq "Yes") {
        $adminEnvironments = Get-PowerOpsEnvironment | Where-Object { $_.properties.displayName -like "$PPAdminEnvNaming-admin*" }
        try {
            New-DLPAssignmentFromEnv -Environments $adminEnvironments.properties.displayName -EnvironmentDLP 'adminEnv'
            Write-Output "Created Default Admin Environment DLP Policy"
        }
        catch {
            Write-Warning "Created Default Admin Environment DLP Policy`r`n$_"
        }
    }
}
#endregion create admin environments and import COE solution

#region create default tenant dlp policies
if ($PPTenantDLP -in 'low', 'medium', 'high') {
    try {
        $null = New-DLPAssignmentFromEnv -Environments $defaultEnvironment.properties.displayName -EnvironmentDLP $PPTenantDLP
        Write-Output "Created Default Tenant DLP Policy - $PPTenantDLP"
    }
    catch {
        Write-Warning "Failed to create Default Tenant DLP Policy`r`n$_"
    }
}
#endregion create default tenant dlp policies

#region create landing zones for citizen devs
if ($PPCitizen -in "yes", "half" -and $PPCitizenCount -ge 1 -or $PPCitizen -eq 'custom') {
    if ($PPCitizenConfiguration -ne 'null') {
        try {
            $environmentsToCreate = New-EnvironmentCreationObject -ARMInputString ($PPCitizenConfiguration -join ',') -EnvALM:($PPCitizenAlm -eq 'Yes')
        }
        catch {
            throw "Failed to create environment object. Input data is malformed. '`r`n$_'"
        }
    }
    else {
        try {
            $envHt = @{
                EnvCount       = $PPCitizenCount
                EnvNaming      = $PPCitizenNaming
                EnvRegion      = $PPCitizenRegion
                envLanguage    = $PPCitizenLanguage
                envCurrency    = $PPCitizenCurrency
                envDescription = $PPCitizenDescription
                EnvALM         = $PPCitizenAlm -eq 'Yes'
                EnvDataverse   = $PPCitizen -eq 'Yes'
            }
            $environmentsToCreate = New-EnvironmentCreationObject @envHt
        }
        catch {
            throw "Failed to create environment object. Input data is malformed. '`r`n$_'"
        }
    }
    foreach ($environment in $environmentsToCreate) {
        try {
            $envCreationHt = @{
                Name               = $environment.envName
                Location           = $environment.envRegion
                Dataverse          = $true
                ManagedEnvironment = $PPCitizenManagedEnv -eq 'Yes'
                Description        = $environment.envDescription
                LanguageName       = $environment.envLanguage
                Currency           = $environment.envCurrency
                SecurityGroupId    = $environment.envRbac
            }
            $null = New-PowerOpsEnvironment @envCreationHt
            Write-Output "Created citizen environment $($environment.envName) in $($environment.envRegion)"
            if (-not [string]::IsNullOrEmpty($environment.envRbac) -and $environment.envDataverse -eq $false) {
                Write-Output "Assigning RBAC for principalId $($environment.envRbac) in citizen environment $($environment.envName)"
                $null = New-PowerOpsRoleAssignment -PrincipalId $environment.envRbac -RoleDefinition EnvironmentAdmin -EnvironmentName $environment.envName
            }
        }
        catch {
            Write-Warning "Failed to create citizen environment $($environment.envName) "
        }
    }
    if ($PPCitizenDlp -eq "Yes") {
        New-DLPAssignmentFromEnv -Environments $environmentsToCreate.envName -EnvironmentDLP 'citizenDlpPolicy'
    }
}
#endregion create landing zones for citizen devs

#region create landing zones for pro devs
if ($PPPro -in "yes", "half" -and $PPProCount -ge 1 -or $PPPro -eq 'custom') {
    if ($PPProConfiguration -ne 'null') {
        try {
            $environmentsToCreate = New-EnvironmentCreationObject -ARMInputString ($PPProConfiguration -join ',') -EnvALM:($PPProAlm -eq 'Yes')
        }
        catch {
            throw "Failed to create environment object. Input data is malformed. '`r`n$_'"
        }
    }
    else {
        try {
            $envHt = @{
                EnvCount       = $PPProCount
                EnvNaming      = $PPProNaming
                EnvRegion      = $PPProRegion
                EnvLanguage    = $PPProLanguage
                EnvCurrency    = $PPProCurrency
                EnvDescription = $PPProDescription
                EnvALM         = $PPProAlm -eq 'Yes'
                EnvDataverse   = $PPPro -eq 'Yes'
            }
            $environmentsToCreate = New-EnvironmentCreationObject @envHt
        }
        catch {
            throw "Failed to create environment object. Input data is malformed'`r`n$_'"
        }

    }
    foreach ($environment in $environmentsToCreate) {
        try {
            $envCreationHt = @{
                Name               = $environment.envName
                Location           = $environment.envRegion
                Dataverse          = $true
                ManagedEnvironment = $PPProManagedEnv -eq 'Yes'
                Description        = $environment.envDescription
                LanguageName       = $environment.envLanguage
                Currency           = $environment.envCurrency
                SecurityGroupId    = $environment.envRbac
            }
            $null = New-PowerOpsEnvironment @envCreationHt
            Write-Output "Created pro environment $($environment.envName) in $($environment.envRegion)"
            if (-not [string]::IsNullOrEmpty($environment.envRbac) -and $environment.envDataverse -eq $false) {
                Write-Output "Assigning RBAC for principalId $($environment.envRbac) pro environment $($environment.envName)"
                $null = New-PowerOpsRoleAssignment -PrincipalId $environment.envRbac -RoleDefinition EnvironmentAdmin -EnvironmentName $environment.envName
            }
        }
        catch {
            Write-Warning "Failed to create pro environment $($environment.envName) "
        }
    }
    if ($PPProDlp -eq "Yes") {
        New-DLPAssignmentFromEnv -Environments $environmentsToCreate.envName -EnvironmentDLP 'proDlpPolicy'
    }
}
#endregion create landing zones for pro devs

#region create industry landing zones
if (-not[string]::IsNullOrEmpty($PPIndustryNaming)) {
    #TODO Add template support for the different industries
    $environmentName = $PPIndustryNaming
    $PPIndustryRegion = $defaultEnvironment.location
    $indEnvHt = @{
        # Location always need to be set to default for environments with D365 templates
        Location           = $PPIndustryRegion
        Dataverse          = $true
        ManagedEnvironment = $PPIndustryManagedEnv -eq 'Yes'
        Templates          = 'D365_DeveloperEdition'
    }
    try {
        if ($PPIndustryAlm -eq 'Yes') {
            foreach ($envTier in $envTiers) {
                $almEnvironmentName = "{0}-{1}" -f $environmentName, $envTier
                $null = New-PowerOpsEnvironment -Name $almEnvironmentName @indEnvHt
                Write-Output "Created industry environment $almEnvironmentName in $PPIndustryRegion"
            }
        }
        else {
            $null = New-PowerOpsEnvironment -Name $environmentName @indEnvHt
            Write-Output "Created industry environment $environmentName in $PPIndustryRegion"
        }
    }
    catch {
        throw "Failed to deploy industry environment $environmentName`r`n$_"
    }
}
#endregion create industry landing zones
$DeploymentScriptOutputs['Deployment'] = 'Successful'

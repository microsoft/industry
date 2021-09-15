#Connect-AzAccount -Tenant "<Tenant ID >" -Subscription "<subscription ID>"

$token = (Get-AzAccessToken -ResourceUrl 'https://dicom.healthcareapis.azure.com').token

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/dicom")

$dicomimage = Invoke-RestMethod 'https://<<your dicom service>>.dicom.azurehealthcareapis.com/2021-06-01-preview/studies' `
    -Method 'GET' `
    -Headers $headers
Write-Verbose  $dicomimage | ConvertTo-Json
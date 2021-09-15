#Connect-AzAccount -Tenant "5663f39e-feb1-4303-a1f9-cf20b702de61" -Subscription "1f6c9a98-a387-420d-853c-9d27cfda0f33"
$dicomservice = 'https://eshealthapi-espenhealthdicom.dicom.azurehealthcareapis.com'
$diconversion = '2021-06-01-preview'
$token = (Get-AzAccessToken -ResourceUrl 'https://dicom.healthcareapis.azure.com').token
#https://<workspacename-dicomservicename>.dicom.azurehealthcareapis.com/v<version of REST API>/changefeed
#$token = (Get-AzAccessToken -ResourceUrl "$dicomservice/v2021-06-01-preview/changefeed").token


$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/dicom")


#$dicompostimage = Invoke-RestMethod "$dicomservice/$diconversion/studies" `
$dicomimage = Invoke-RestMethod 'https://eshealthapi-espenhealthdicom.dicom.azurehealthcareapis.com/2021-06-01-preview/studies' `
    -Method 'GET' `
    -Headers $headers 
Write-Host $dicomimage | ConvertTo-Json

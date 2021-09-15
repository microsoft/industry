#Connect-AzAccount -Tenant "5663f39e-feb1-4303-a1f9-cf20b702de61" -Subscription "1f6c9a98-a387-420d-853c-9d27cfda0f33"
$dicomservice = 'https://eshealthapi-espenhealthdicom.dicom.azurehealthcareapis.com'
$token = (Get-AzAccessToken -ResourceUrl 'https://dicom.healthcareapis.azure.com').token

#$token = (Get-AzAccessToken -ResourceUrl "$dicomservice/v2021-06-01-preview/changefeed").token
$file = 'C:\Users\espen\OneDrive - Microsoft\Code\CATHealth\CatHealthAPI\sampledata\dicom\blue-circle.dcm'
$filecontent =  Get-Content -Raw $file
$diconversion = '2021-06-01-preview'
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/dicom")
$headers.Add("data-binary", "C:`\Users`\espen`\OneDrive - Microsoft`\Code`\CATHealth`\CatHealthAPI`\sampledata`\dicom`\blue-circle.dcm")
#https://<workspacename-dicomservicename>.dicom.azurehealthcareapis.com/v<version of REST API>/changefeed

#$dicompostimage = Invoke-RestMethod "$dicomservice/$diconversion/studies" `
$dicompostimage = Invoke-RestMethod 'https://eshealthapi-espenhealthdicom.dicom.azurehealthcareapis.com/2021-06-01-preview/studies' `
    -Method 'POST' `
    -Headers $headers `
    -Body "<file-contents-here>"
Write-Host $dicompostimage | ConvertTo-Json

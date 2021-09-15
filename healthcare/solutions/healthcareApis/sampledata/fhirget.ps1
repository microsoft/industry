
$fhirservice = 'https://eshealthapi-espenhealthfhir.fhir.azurehealthcareapis.com'
$token = (Get-AzAccessToken -ResourceUrl $fhirservice).token

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/json")

$FhirGetMalePatients = Invoke-RestMethod "$fhirservice/Patient?gender:not=female" `
    -Method 'GET' `
    -Headers $headers 
Write-Host $FhirGetPatient

$FhirGetPatientName = Invoke-RestMethod "$fhirservice/Patient?name:exact=Espen" `
    -Method 'GET' `
    -Headers $headers
$FhirGetPatientName | ConvertTo-Json 
Write-Host $FhirGetPatientName | ConvertTo-Json 

$FhirGetPatientId = Invoke-RestMethod "$fhirservice/Patient/8fee45ff-cc41-4b22-a8d2-252d39f22b2e" `
    -Method 'GET' `
    -Headers $headers 
    $FhirGetPatientId | ConvertTo-Json  
Write-Host $FhirGetPatientId

$FhirGetPatientId = Invoke-RestMethod "$fhirservice/$export?_container='https://eshealthapiyroratzfvoj4w.blob.core.windows.net/lake'" `
    -Method 'GET' `
    -Headers $headers 
    $FhirGetPatientId | ConvertTo-Json  
Write-Host $FhirGetPatientId

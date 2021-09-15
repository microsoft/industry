#Connect-AzAccount -Tenant "5663f39e-feb1-4303-a1f9-cf20b702de61" -Subscription "1f6c9a98-a387-420d-853c-9d27cfda0f33"
$fhirservice = 'https://eshealthapi-espenhealthfhir.fhir.azurehealthcareapis.com'
$token = (Get-AzAccessToken -ResourceUrl $fhirservice).token
$file = "sampledata\fhir\Adolph80_Runolfsson901_89b38456-3ee1-40cb-a541-2918bda7cc84.json"
$filecontent =  Get-Content -Raw $file

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/json")


$FhirGetPatient = Invoke-RestMethod "$fhirservice/" `
    -Method 'POST' `
    -Headers $headers `
    -Body $filecontent
Write-Host $FhirGetPatient | ConvertTo-Json


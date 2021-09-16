#Connect-AzAccount -Tenant "<Tenant ID >" -Subscription "<subscription ID>"

$fhirservice = 'https://<<yourhealthapi>>.fhir.azurehealthcareapis.com'
$token = (Get-AzAccessToken -ResourceUrl $fhirservice).token
$file = "sampledata\Adolph80_Runolfsson901_89b38456-3ee1-40cb-a541-2918bda7cc84.json"
$filecontent =  Get-Content -Raw $file

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/json")

$FhirGetPatient = Invoke-RestMethod "$fhirservice/" `
    -Method 'POST' `
    -Headers $headers `
    -Body $filecontent

    Write-Verbose $FhirGetPatient | ConvertTo-Json
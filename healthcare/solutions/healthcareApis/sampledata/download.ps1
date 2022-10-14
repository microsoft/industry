#Connect-AzAccount -Tenant "<Tenant ID >" -Subscription "<subscription ID>"
$fhirservice = 'https://yourfhirservice.fhir.azurehealthcareapis.com/'
$token = (Get-AzAccessToken -ResourceUrl $fhirservice).token

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $($token)")
$headers.Add("Content-Type", "application/json")
function DownloadFilesFromRepo {
    Param(
        [string]$Owner,
        [string]$Repository,
        [string]$Path
        )
        $baseUri = "https://api.github.com/"
        $exurl = "repos/$Owner/$Repository/contents/$Path"
        $wr = Invoke-WebRequest -Uri $($baseuri+$exurl)
        $objects = $wr.Content | ConvertFrom-Json
        $files = $objects | Where-Object {$_.type -eq "file"} | Select-Object -exp download_url
        foreach ($file in $files) {
            $dlfile = Invoke-WebRequest -Uri $file
            try {

                $FhirGetPatient = Invoke-RestMethod "$fhirservice/" `
                -Method 'POST' `
                -Headers $headers `
                -Body $dlfile

                Write-Verbose $file
            } catch {
                throw "Unable to download '$($file)' Patient: '$($FhirGetPatient)'"
            }
        }
    }
    DownloadFilesFromRepo -Owner 'yourGitHub' -Repository 'yourRepo' -Path 'sampledata/fhir/'

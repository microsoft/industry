# Define script arguments
[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [Switch]
    $GitHub
)

function New-Password {
    <#
        .SYNOPSIS
            Generate pseudo-random passwords based on templates
    
        .PARAMETER Template
            The template for the password you want to generate. (Defaults to a totally random 16-20 character password)
    
            This defines which types of characters are generated for each character in the password.
            IMPORTANT: the US English alphabet is hardcoded ... (we make no apologies, but thought you should know that)
    
            NOTE: The template has changed somewhat from v1 (to more closely resemble the pattern used by KeePass)
    
            Char | Type                        | Actual character set
            -----|-----------------------------|---------------------
            a    | Lower-Case Alphanumeric     | abcdefghijklmnopqrstuvwxyz 0123456789
            A    | Mixed-Case Alphanumeric     | ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz 0123456789
            U    | Upper-Case Alphanumeric     | ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789
            d    | Digit                       | 0123456789
            h    | Lower-Case Hex Character    | 0123456789 abcdef
            H    | Upper-Case Hex Character    | 0123456789 ABCDEF
            l    | Lower-Case Letter           | abcdefghijklmnopqrstuvwxyz
            L    | Mixed-Case Letter           | ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz
            u    | Upper-Case Letter           | ABCDEFGHIJKLMNOPQRSTUVWXYZ
            v    | Lower-Case Vowel            | aeiou
            V    | Mixed-Case Vowel            | AEIOU aeiou
            Z    | Upper-Case Vowel            | AEIOU
            c    | Lower-Case Consonant        | bcdfghjklmnpqrstvwxyz
            C    | Mixed-Case Consonant        | BCDFGHJKLMNPQRSTVWXYZ bcdfghjklmnpqrstvwxyz
            z    | Upper-Case Consonant        | BCDFGHJKLMNPQRSTVWXYZ
            p    | Punctuation                 | ,.;:
            b    | Bracket                     | ()[]{}<>
            s    | Printable 7-Bit Punctuation | !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
            S    | Printable 7-Bit ASCII       | A-Z, a-z, 0-9, !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
    
            \    | Escape (Fixed Char)         | Use following character as is.
            0-9  | Repeat                      | Repeat the previous character n times.
    
            Using a number, you can define how many times the previous placeholder should occur:
                * d4 is equivalent to dddd
                * dH4a is equivalent to dHHHHa
                * Hda1dH is equivalent to HdadH
                * S16 is equivalent to SSSSSSSSSSSSSSSS (this is the default password pattern)
    
            To define custom character sets, you pass a hashtable to -CustomCharacterSets which maps one character to an array of characters, then you can use that character in your template.
            Note you cannot overwrite characters that are already in the character map (as listed above).
    
        .PARAMETER CustomCharacterSet
            A hashtable mapping single characters to an array of characters for a custom character set.
    
            For example, to use numbers without zero or 1 (avoiding confusion with the letters O and L), you can define:
    
            -CustomCharacterSet @{ n = "23456789" }
    
        .EXAMPLE
        New-Password "zvcvcdd"
    
        Description
        -----------
        Generates a "pronounceable" 7 character password consisting of alternating consonants and vowels followed by a 2-digit number
    
        .EXAMPLE
        New-Password A16
    
        Description
        -----------
        Generates a 16 character alpha-numeric password
    
        .EXAMPLE
        -split "Cvcvcdd " * 8 | New-Password
    
        Description
        -----------
        Demonstrates that the function can take pipeline input. Passing multiple templates via the pipeline will generate multiple passwords.
        In this case, we generate EIGHT "pronounceable" 7 character password consisting of alternating consonants and vowels followed by a 2-digit number
    
        .EXAMPLE
        New-Password "zvvcpzvvcdd"
    
        Description
        -----------
        Generates a password which starts with an upper-case consonant, followed by two lower-case vowels, followed by a punctuation mark, followed by an upper-case consonant, followed by two lower-case vowels, followed by two numbers.
    
    
        .EXAMPLE
        New-Password "Get-zvcvvc"
    
        Description
        -----------
        Generates a password which looks like a strange PowerShell command, starting with "Get-" and ending with an uppercase consonant, a vowel, a consonant, two vowels, and a final consonant.
    
        .INPUTS
        [String]
            A string template for a password
    
        .OUTPUTS
        [SecureString]
            A password, as secure as we can make it
    
        .NOTES
            HISTORY
            2.0   Change random number generator
                Return a SecureString
            1.1   Bugfix for the \ escape character
                + added a hex option (H for upper) and (h for lower)
                + changed the '#' to 'd' for digits so you can write the patterns without quotes.
            1.0   First release
    #>
    [OutputType([SecureString])]
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Position = 0)]
        [string]$Template = "A16",
    
        [hashtable]$CustomCharacterSet = @{}
    )
    begin {
        $CharacterSets = [System.Collections.Generic.Dictionary[char, char[]]]::new()
        @{
            [char]'a' = [char[]]"abcdefghijklmnopqrstuvwxyz0123456789"
            [char]'A' = [char[]]"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            [char]'U' = [char[]]"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            [char]'d' = [char[]]"0123456789"
            [char]'h' = [char[]]"0123456789abcdef"
            [char]'H' = [char[]]"0123456789ABCDEF"
            [char]'l' = [char[]]"abcdefghijklmnopqrstuvwxyz"
            [char]'L' = [char[]]"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
            [char]'u' = [char[]]"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            [char]'v' = [char[]]"aeiou"
            [char]'V' = [char[]]"AEIOUaeiou"
            [char]'Z' = [char[]]"AEIOU"
            [char]'c' = [char[]]"bcdfghjklmnpqrstvwxyz"
            [char]'C' = [char[]]"BCDFGHJKLMNPQRSTVWXYZbcdfghjklmnpqrstvwxyz"
            [char]'z' = [char[]]"BCDFGHJKLMNPQRSTVWXYZ"
            [char]'p' = [char[]]",.;:"
            [char]'b' = [char[]]"()[]<>"
            [char]'s' = [char[]]"!`#$%&()*+,-./:;<=>?@[\]^_``|~"
            [char]'S' = [char[]]"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!`#$%&()*+,-./:;<=>?@[\]^_``|~"
        }.GetEnumerator().ForEach{ $CharacterSets.Add($_.Key, $_.Value) }
    
        $CustomCharacterSet.GetEnumerator().ForEach{ $CharacterSets.Add($_.Key, $_.Value) }
    
        # This returns a RNGCryptoServiceProvider
        $cryptoRNG = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    }
    process {
        # Create the return object
        $securePassword = [System.Security.SecureString]::new()
    
        # Expand the template
        $Template = [regex]::replace($Template, "(.)(\d+)", { param($match) $match.Groups[1].Value * [int]($match.Groups[2].Value) })
    
        Write-Verbose "Template: $Template"
    
        $b = [byte[]]0
        for ($c = 0; $c -lt $Template.Length; $c++) {
            $securePassword.AppendChar($(
                    if ($Template[$c] -eq '\') {
                        $Template[(++$c)]
                    }
                    else {
                        $cryptoRNG.GetBytes($b)
                        $char = $Template[$c]
                        if ($Set = $CharacterSets[$char]) {
                            $Index = [int]$b[0] % $Set.Length
                            $Set[$Index]
                        }
                        else {
                            $char
                        }
                    }
                ))
        }
    
        return $securePassword
    }
}


# Generate password
Write-Output "Generating password"
$Password = New-Password -Template "lusdA16dlu" | ConvertFrom-SecureString -AsPlainText

if ($GitHub) {
    # Mask password
    Write-Output "Masking password"
    Write-Output "::add-mask::$Password"

    # Set output
    Write-Output "Setting output"
    Write-Output "::set-output name=password::$Password"
}
else {
    # Set output
    Write-Output "Setting output"
    Write-Output "##vso[task.setvariable variable=password;issecret=true]$Password"
}

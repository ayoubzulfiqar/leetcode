# Create Folder in Directory

## Use: ./Create-Folder.ps1 -folderName "ayoub ali"     

param (
    [Parameter(Mandatory=$true)]
    [string]$folderName
)

# Function to capitalize the first letter of each word
function Capitalize-FirstLetter {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string]$string
    )

    $cultureInfo = (Get-Culture).TextInfo
    $cultureInfo.ToTitleCase($string.ToLower())
}

# Split the folder name into individual words
$words = $folderName -split ' '

# Remove spaces from each word and capitalize the first letter
$capitalizedWords = foreach ($word in $words) {
    $word = $word -replace '\s', ''
    Capitalize-FirstLetter -string $word
}

# Join the capitalized words back into a single string
$folderName = $capitalizedWords -join ''

# Check if the folder already exists
if (Test-Path $folderName) {
    Write-Host "Folder '$folderName' already exists."
    exit 1
}

# Create the folder
New-Item -ItemType Directory -Path $folderName -Force | Out-Null

Write-Host "Folder '$folderName' created successfully."

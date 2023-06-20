# Create File in a directory

# Use: ../Create-File.ps1 -FileName "Your_File_Name.extention"

Param(
    [Parameter(Mandatory=$true)]
    [string]$FileName
)

# Convert the file name to lowercase
$NewFileName = $FileName.ToLower()

# Replace spaces with underscores
$NewFileName = $NewFileName -replace '\s', '_'

# Check if the file already exists
if (Test-Path -Path $NewFileName -PathType Leaf) {
    Write-Output "File '$NewFileName' already exists."
    # You can choose to skip the creation of the new file or rename the existing file here.
}
else {
    # Create a new file with the modified name
    $NewFile = New-Item -ItemType File -Path $NewFileName -ErrorAction Stop
    # Output the new file name
    Write-Output "New file created: $NewFileName"
}

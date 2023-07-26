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

# Create an array of extensions to use
$extensions = @('.md', '.go', '.dart')

foreach ($ext in $extensions) {
    $fullFileName = $NewFileName + $ext

    # Check if the file already exists
    if (Test-Path -Path $fullFileName -PathType Leaf) {
        Write-Output "File '$fullFileName' already exists."
        # You can choose to skip the creation of the new file or rename the existing file here.
    }
    else {
        # Create a new file with the modified name and extension
        $NewFile = New-Item -ItemType File -Path $fullFileName -ErrorAction Stop
        # Output the new file name
        Write-Output "New file created: $fullFileName"
    }
}

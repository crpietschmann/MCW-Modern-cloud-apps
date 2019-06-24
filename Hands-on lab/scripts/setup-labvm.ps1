param($labFilesUri="")

# Install SSMS
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')) 
choco install sql-server-management-studio -y

# Download Lab Files
$labFilesFolder = ""
if ([string]::IsNullOrEmpty($labFilesUri) -eq $false)
{
    # Ensure folder exists
    if ((Test-Path $labFilesFolder) -eq $false)
    {
        New-Item -Path $labFilesFolder -ItemType directory
    }

    # Parse file name
    $filePathParts = $labFilesUri.Split("/")
    $fileName = $filePathParts($filePathParts.Length - 1)

    # Download .ZIP file
    (New-Object Net.WebClient).DownloadFile($labFilesUri, $labFilesFolder)

    # Extract .ZIP file
    (New-Object -com shell.application).namespace($labFilesFolder).CopyHere((New-Object -com shell.application).namespace($labFilesFolder).Items(), 16)
}
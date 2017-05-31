<#
.Synopsis
   This function will download a Github Repository without using Git
.DESCRIPTION
   This function will download files from Github without using Git.  You will need to know the Owner, Repository name, branch (default master),
   and FilePath.  The Filepath will include any folders and files that you want to download.
.EXAMPLE
   Get-GithubRepository -Owner MSAdministrator -Repository WriteLogEntry -Verbose -FilePath `
        'WriteLogEntry.psm1',
        'WriteLogEntry.psd1',
        'Public',
        'en-US',
        'en-US\about_WriteLogEntry.help.txt',
        'Public\Write-LogEntry.ps1'
#>
function Get-GithubRepository
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Please provide the repository owner
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$Owner,

        # Please provide the name of the repository
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [string]$Repository,

        # Please provide a branch to download from
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [string]$Branch = 'master',

        # Please provide a list of files/paths to download
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [string[]]$FilePath
    )

    Begin
    {
        $modulespath = ($env:psmodulepath -split ";")[0]
        
        $PowerShellModule = "$modulespath\$Repository"

        Write-Verbose "Creating module directory"

        New-Item -Type Container -Force -Path $PowerShellModule | out-null

        Write-Verbose "Downloading and installing"

        $wc = New-Object System.Net.WebClient

        $wc.Encoding = [System.Text.Encoding]::UTF8

    }
    Process
    {
        foreach ($item in $FilePath)
        {
            Write-Verbose -Message "$item in FilePath"

            if ($item -like '*.*')
            {
                Write-Debug -Message "Attempting to create $PowerShellModule\$item"

                New-Item -ItemType File -Force -Path "$PowerShellModule\$item" | Out-Null

                $url = "https://raw.githubusercontent.com/$Owner/$Repository/$Branch/$item"

                Write-Debug -Message "Attempting to download from $url"

                ($wc.DownloadString("$url")) | Out-File "$PowerShellModule\$item"
            }
            else
            {
                Write-Debug -Message "Attempting to create $PowerShellModule\$item"

                New-Item -ItemType Container -Force -Path "$PowerShellModule\$item" | Out-Null

                $url = "https://raw.githubusercontent.com/$Owner/$Repository/$Branch/$item"

                Write-Debug -Message "Attempting to download from $url"
            }
        }
    }
    End
    {
    }
}
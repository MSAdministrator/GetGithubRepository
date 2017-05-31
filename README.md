# GetGithubRepository
This PowerShell function will download Github files without using Git

## Synopsis
This function will download a Github Repository without using Git
## DESCRIPTION
This function will download files from Github without using Git.  You will need to know the Owner, Repository name, branch (default master), and FilePath.  The Filepath will include any folders and files that you want to download.
## EXAMPLE
```
   Get-GithubRepository -Owner MSAdministrator -Repository WriteLogEntry -Verbose -FilePath `
        'WriteLogEntry.psm1',
        'WriteLogEntry.psd1',
        'Public',
        'en-US',
        'en-US\about_WriteLogEntry.help.txt',
        'Public\Write-LogEntry.ps1'
```
# GetGithubRepository
This PowerShell function will download Github files without using Git

## Synopsis
This function will download a Github Repository without using Git
## DESCRIPTION
This function will download files from Github without using Git.  You will need to know the Owner, Repository name, branch (default master), targeted folder and FilePath. The targeted path is where you wan to download the files,  If it is not given a default path will be used (ex. C:\Users\{UserName}\Documents\WindowsPowerShell\Modules\).  The Filepath will include any folders and files that you want to download.
## EXAMPLE
```
   Get-GithubRepository -Owner MSAdministrator -Repository WriteLogEntry -Target "C:\\downloadPath" -Verbose -FilePath `
        'WriteLogEntry.psm1',
        'WriteLogEntry.psd1',
        'Public',
        'en-US',
        'en-US\about_WriteLogEntry.help.txt',
        'Public\Write-LogEntry.ps1'
```
function Get-MacmonReport
{
  <#
    .SYNOPSIS
    Get result of report as object or as file from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get result of report as object or as file from the macmon NAC via RESTAPI.
    If Parameter Path is provided, a file is created, without the Path the Result is provided as object.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the report (e.g. 'authorizedMacs0cbc6611f5540bd0809a388dc95a615b')

    .PARAMETER Format
    Format of the Result ('csv', ('pdf' or 'xlsx' does not work atm)), (Default: 'csv').

    .PARAMETER Path
    Path to Folder to save File to. If Path is provided, a file is created, without the Path the Result is provided as object.

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonReport -Hostname 'MACMONSERVER' -Credential $Credential -ID 'authorizedMacs0cbc6611f5540bd0809a388dc95a615b'
    #Ask for credential then get result of the report with ReportID 'authorizedMacs0cbc6611f5540bd0809a388dc95a615b' from macmon NAC using provided credential

    .EXAMPLE
    'unauthorisedMacs' | Get-MacmonReport -Hostname 'MACMONSERVER' -Format 'csv' -Path 'C:\Temp'
    'unauthorisedMacs' | Get-MacmonReport -Hostname 'MACMONSERVER' -Format 'pdf' -Path 'C:\Temp'
    'unauthorisedMacs' | Get-MacmonReport -Hostname 'MACMONSERVER' -Format 'xlsx' -Path 'C:\Temp'
    #Get result of report with ReportID 'unauthorisedMacs' as file to 'C:\Temp\unauthorisedMacs.csv'

    .LINK
    https://github.com/falkheiland/PSmacmon

    .LINK
    https://<MACMONSERVER>/man/index.php?controller=ApiDocuController

    #>

  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string]
    $HostName,

    [ValidateRange(0, 65535)]
    [Int]
    $TCPPort = 443,

    [ValidateSet('1.0')]
    [string]
    $ApiVersion = '1.0',

    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = (Get-Credential -Message 'Enter your credentials'),

    [Parameter(Mandatory, ValueFromPipeline)]
    [string]
    $ID,

    [ValidateSet('csv', 'pdf', 'xlsx')]
    [string]
    $Format = 'csv',

    [ValidateScript( {
        if (-Not ($_ | Test-Path) )
        {
          throw "File or folder does not exist"
        }
        return $true
      })]
    [System.IO.FileInfo]$Path
  )

  begin
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $UriArray = @($HostName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/reports' -f $UriArray)
    $FunctionStringParams = [ordered]@{
      Format = $Format
    }
    $FunctionString = Get-MacmonFunctionString @FunctionStringParams
    $Params = @{
      Credential = $Credential
      Method     = 'Get'
    }
  }
  process
  {
    $params.Add('Uri', ('{0}/{1}{2}' -f $BaseURL, $ID, $FunctionString))
    if ($Path)
    {
      $params.Add('OutFile', ('{0}\{1}.{2}' -f $Path, $ID, $Format))
      Invoke-MacmonRestMethod @Params
    }
    else
    {
      Invoke-MacmonRestMethod @Params | ConvertFrom-Csv -Delimiter ';'
    }
  }
  end
  {
  }
}
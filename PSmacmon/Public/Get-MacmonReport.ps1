function Get-MacmonReport
{
  <#
    .SYNOPSIS
    Get User report from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get User report from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the User report

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonReport -Hostname 'MACMONSERVER' -Credential $Credential -ID 23
    #Ask for credential then get User reports from macmon NAC using provided credential

    .EXAMPLE
    5 | Get-MacmonReport -Hostname 'MACMONSERVER'
    #Get User report with ID 5

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
    [int]
    $ID,

    [string]
    [ValidateSet('csv','pdf','xlxs')]
    $Format = 'csv'
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $BaseURL = ('https://{0}:{1}/api/v{2}/reports' -f $HostName, $TCPPort, $ApiVersion)
    $SessionURL = ('{0}/{1}' -f $BaseURL, $ID)
    Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get'
  }
  end
  {
  }
}
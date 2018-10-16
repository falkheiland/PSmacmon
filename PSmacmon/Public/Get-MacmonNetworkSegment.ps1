function Get-MacmonNetworkSegment
{
  <#
    .SYNOPSIS
    Get network segment from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get network segment from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the network segment ('192.168.80.0/255.255.255.0')

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonNetworkSegment -Hostname 'MACMONSERVER' -Credential $Credential
    #Ask for credential then get network segments from macmon NAC using provided credential

    .EXAMPLE
    '192.168.80.0/255.255.255.0' | Get-MacmonNetworkSegment -Hostname 'MACMONSERVER'
    #known bug: Get network segment with ID '192.168.80.0/255.255.255.0'

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

    [Parameter(ValueFromPipeline)]
    [string]
    $ID
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $BaseURL = ('https://{0}:{1}/api/v{2}/networksegments' -f $HostName, $TCPPort, $ApiVersion)
    Switch ($ID)
    {
      ''
      {
        $SessionURL = ('{0}' -f $BaseURL)
        (Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get').SyncRoot
      }
      default
      {
        $SessionURL = ('{0}/{1}' -f $BaseURL, ($ID -replace '/', '%2F'))
        $SessionURL
        Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get'
      }
    }
  }
  end
  {
  }
}
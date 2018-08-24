function Get-MacmonEndpoint
{
  <#
    .SYNOPSIS
    Get Endpoint from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get Endpoint from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER MACAddress
    MAC Address of the endpoint group

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonEndpoint -Hostname 'MACMONSERVER' -Credential $Credential
    #Ask for credential then get Endpoint from macmon NAC using provided credential

    .EXAMPLE
    '00-00-FF-FF-FF-FF' | Get-MacmonEndpoint -Hostname 'MACMONSERVER'
    #Get Endpoint with MACAddress '00-00-FF-FF-FF-FF'

    .EXAMPLE
    (Get-MacmonEndpoint -Hostname 'MACMONSERVER').where{$_.endpointGroupId -eq 10}
    #Get Endpoint with endpointGroupId 10

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
    [ValidatePattern('(([0-9A-Fa-f]{2}[-:]){5}[0-9A-Fa-f]{2})|(([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4})')]
    [string]
    $MACAddress
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $BaseURL = ('https://{0}:{1}/api/v{2}/endpoints' -f $HostName, $TCPPort, $ApiVersion)
    Switch ($MACAddress)
    {
      ''
      {
        $SessionURL = ('{0}' -f $BaseURL)
        (Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get').SyncRoot
      }
      default
      {
        $SessionURL = ('{0}/{1}' -f $BaseURL, $MACAddress)
        Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get'
      }
    }
  }
  end
  {
  }
}
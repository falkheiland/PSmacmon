function Get-MacmonNetworkDevice
{
  <#
    .SYNOPSIS
    Get Network Devices from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get Network Devices from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the network device

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonNetworkDevice -Hostname 'MACMONSERVER' -Credential $Credential
    #Ask for credential then get Network Devices from macmon NAC using provided credential

    .EXAMPLE
    1 | Get-MacmonNetworkDevice -Hostname 'MACMONSERVER'
    #Get Network Devices with ID 1

    .EXAMPLE
    (Get-MacmonNetworkDevice -Hostname 'MACMONSERVER').where{$_.networkDeviceClassId -eq 63}
    #Get Network Devices with networkDeviceClassId 63

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
    [int]
    $ID = -1
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $BaseURL = ('https://{0}:{1}/api/v{2}/networkdevices' -f $HostName, $TCPPort, $ApiVersion)
    Switch ($ID)
    {
      -1
      {
        $SessionURL = ('{0}' -f $BaseURL)
        (Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get').SyncRoot
      }
      default
      {
        $SessionURL = ('{0}/{1}' -f $BaseURL, $ID)
        Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get'
      }
    }
  }
  end
  {
  }
}
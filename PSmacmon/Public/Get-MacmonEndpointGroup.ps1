function Get-MacmonEndpointGroup
{
  <#
    .SYNOPSIS
    Get Endpoint Group from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get Endpoint Group from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 8443)

    .PARAMETER ApiVersion
    API Version to use (Default: 3)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the endpoint group

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonEndpointGroup -Hostname 'MACMONSERVER' -Credential $Credential
    #Ask for credential then get Endpoint Group from macmon NAC using provided credential

    .EXAMPLE
    0 | Get-MacmonEndpointGroup -Hostname 'MACMONSERVER' | Select-Object -Property name, description
    #Get name and description from Endpoint Group with ID 0

    .EXAMPLE
    (Get-MacmonEndpointGroup -Hostname 'MACMONSERVER').where{$_.obsoleteEndpointExpire} |
      Select-Object -Property name, obsoleteEndpointExpire |
      Sort-Object obsoleteEndpointExpire, name
    #Get name and obsoleteEndpointExpire from Endpoint Group with obsoleteEndpointExpire, sorted by obsoleteEndpointExpire and name

    .NOTES
    n.a.

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
    $BaseURL = ('https://{0}:{1}/api/v{2}/endpointgroups' -f $HostName, $TCPPort, $ApiVersion)
    $SessionURL = ('{0}' -f $BaseURL)
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
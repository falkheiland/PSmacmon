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
    $Params = @{
      Hostname = 'MACMONSERVER'
      Fields   = 'mac,endpointDeviceStatus.lastIp'
      Sort     = '-mac'
      Limit    = 1
      Offset   = 10
      Filter   = 'endpointGroupId==150'
    }
    Get-MacmonEndpoint @Params
    Get mac and lastIP address from 11th endpoint from endpointgroup with ID 150 sorted by mac descending

    .EXAMPLE
    '00-00-FF-FF-FF-FF' | Get-MacmonEndpoint -Hostname 'MACMONSERVER'
    #Get Endpoint with MACAddress '00-00-FF-FF-FF-FF'

    .EXAMPLE
    (Get-MacmonEndpoint -Hostname 'MACMONSERVER').where{$_.endpointGroupId -eq 150}
    #Get Endpoint with endpointGroupId 10

    .LINK
    https://github.com/falkheiland/PSmacmon

    .LINK
    https://<MACMONSERVER>/man/index.php?controller=ApiDocuController

    #>

  [CmdletBinding(DefaultParameterSetName = 'All')]
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

    [Parameter(ValueFromPipeline, ParameterSetName = 'MAC')]
    [ValidatePattern('(([0-9A-Fa-f]{2}[-:]){5}[0-9A-Fa-f]{2})|(([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4})')]
    [string]
    $MACAddress,

    [string]
    $Fields,

    [Parameter(ParameterSetName = 'All')]
    [string]
    $Sort,

    [Parameter(ParameterSetName = 'All')]
    [int]
    $Limit,

    [Parameter(ParameterSetName = 'All')]
    [int]
    $Offset,

    [Parameter(ParameterSetName = 'All')]
    [string]
    $Filter
  )

  begin
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $UriArray = @($HostName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/endpoints' -f $UriArray)
    $FunctionStringParams = [ordered]@{
      Fields = $Fields
      Sort   = $Sort
      Limit  = $Limit
      Offset = $Offset
      Filter = $Filter
    }
    $FunctionString = Get-MacmonFunctionString @FunctionStringParams
    $Params = @{
      Credential = $Credential
      Method     = 'Get'
    }
  }
  process
  {
    Switch ($PsCmdlet.ParameterSetName)
    {
      'All'
      {
        $params.Add('Uri', ('{0}{1}' -f $BaseURL, $FunctionString))
        (Invoke-MacmonRestMethod @Params).SyncRoot
      }
      'MAC'
      {
        $params.Add('Uri', ('{0}/{1}{2}' -f $BaseURL, $MACAddress, $FunctionString))
        Invoke-MacmonRestMethod @Params
      }
    }
  }
  end
  {
  }
}
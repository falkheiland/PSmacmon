function Get-MacmonNetworkDeviceClass
{
  <#
    .SYNOPSIS
    Get Network Device Classes from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get Network Device Classes from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the network device class

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonNetworkDeviceClass -Hostname 'MACMONSERVER' -Credential $Credential
    #Ask for credential then get Network Device Classes from macmon NAC using provided credential

    .EXAMPLE
    760 | Get-MacmonNetworkDeviceClass -Hostname 'MACMONSERVER'
    #Get Network Device Classes with ID 760

    .EXAMPLE
    (Get-MacmonNetworkDeviceClass -Hostname 'MACMONSERVER').where{$_.description -match '^Template.*'}
    #Get Network Device Classes with description starting with 'Template'

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

    [Parameter(ValueFromPipeline, ParameterSetName = 'ID')]
    [int]
    $ID,

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
    $BaseURL = ('https://{0}:{1}/api/v{2}/networkdeviceclasses' -f $UriArray)
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
      'ID'
      {
        $params.Add('Uri', ('{0}/{1}{2}' -f $BaseURL, $ID, $FunctionString))
        Invoke-MacmonRestMethod @Params
      }
    }
  }
  end
  {
  }
}
function New-MacmonEndpoint
{
  <#
    .SYNOPSIS
    Create Endpoint from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Create Endpoint from the macmon NAC via RESTAPI. Not all properties configurable per RESTAPI are available in this function.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER MACAddress
    MAC address of the endpoint

    .PARAMETER Comment
    Comments about the endpoint

    .PARAMETER Active
    An inactive (deactivated) corporate device is evaluated as unauthorized. (Default $true)

    .PARAMETER IPAddress
    Preset IP address(es) of the endpoint

    .PARAMETER Inventory
    Inventory number of the endpoint.


    .PARAMETER AuthorizedVlans
    Blank space separated list of permitted VLAN IDs or VLAN names

    .PARAMETER EndpointGroupId
    ID of the Group of the endpoint

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    New-MacmonEndpoint -Hostname 'MACMONSERVER' -Credential $Credential -MACAddress '00-11-22-33-44-55'
    #Ask for credential then create new endpoint with MAC address '00-11-22-33-44-55' (minimum requirement)

    .EXAMPLE
    $Properties = @{
      Hostname        = 'MACMONSERVER'
      mac             = '00-11-22-33-44-55'
      comment         = 'new Enpoint-Device'
      active          = $true
      staticIps       = '192.168.3.1', '192.168.1.2'
      inventory       = '012345'
      authorizedVlans = '10', '11'
      endpointGroupId = 0
    }
    New-MacmonEndpoint @Properties
    #Create new endpoint with all supported (by function) properties

    .OUTPUTS
    The MAC address of the new endpoint

    .LINK
    https://github.com/falkheiland/PSmacmon

    .LINK
    https://<MACMONSERVER>/man/index.php?controller=ApiDocuController

    #>

  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
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

    [Parameter(Mandatory)]
    [Alias('Identity')]
    [ValidatePattern('(([0-9A-Fa-f]{2}[-:]){5}[0-9A-Fa-f]{2})|(([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4})')]
    [string]
    $MACAddress,

    [string]
    $Comment,

    [bool]
    $Active = $true,

    [ValidateScript( {$_ -match [IPAddress]$_})]
    [Alias('StaticIps')]
    [string[]]
    $IPAddress,

    [string]
    $Inventory,

    [string[]]
    $AuthorizedVlans,

    [int]
    $EndpointGroupId
  )

  begin
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $UriArray = @($HostName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/endpoints' -f $UriArray)
    $Params = @{
      Credential = $Credential
      Method     = 'Post'
    }
  }
  process
  {
    $Body = @{
      mac    = $MACAddress
      active = $Active
    }
    if ($Comment)
    {
      $Body.add('comment', $Comment)
    }
    if ($Inventory)
    {
      $Body.add('inventory', $Inventory)
    }
    if ($IPAddress)
    {
      $Body.add('staticIps', $IPAddress)
    }
    if ($AuthorizedVlans)
    {
      $Body.add('authorizedVlans', @($AuthorizedVlans))
    }
    if ($EndpointGroupId)
    {
      $Body.add('endpointGroupId', $EndpointGroupId)
    }
    $params.Add('Body', (ConvertTo-Json $Body))
    $params.Add('Uri', ('{0}' -f $BaseURL))
    if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $Name))
    {
      Invoke-MacmonRestMethod @Params
    }
  }
  end
  {
  }
}
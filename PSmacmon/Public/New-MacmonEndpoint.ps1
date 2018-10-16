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

    .PARAMETER ExpireTime
    Defines the time after which the endpoint is automatically deactivated or deleted,
    depending on the scan engine setting endpoint_expire_action.

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
      staticIps       = '192.168.30.1', '192.168.1.2'
      inventory       = '012345'
      expireTime      = '2025-01-01T00:00:00Z'
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

    #'2018-08-23T10:05:00Z'
    [datetime]
    $ExpireTime,

    [string[]]
    $AuthorizedVlans,

    [int]
    $EndpointGroupId
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate

    $Body = [ordered]@{
      mac             = $MACAddress
      comment         = $Comment
      active          = $Active
      inventory       = $Inventory
      expireTime      = $ExpireTime
      authorizedVlans = $AuthorizedVlans
    }
    if ($IPAddress)
    {
      $Body.add('staticIps', $IPAddress)
    }
    if ($EndpointGroupId)
    {
      $Body.add('endpointGroupId', $EndpointGroupId)
    }
    $Body = $Body | ConvertTo-Json

    $BaseURL = ('https://{0}:{1}/api/v{2}/endpoints' -f $HostName, $TCPPort, $ApiVersion)
    $SessionURL = ('{0}' -f $BaseURL)
    if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $Name))
    {
      Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Body $Body -Method 'Post'
    }
  }
  end
  {
  }
}
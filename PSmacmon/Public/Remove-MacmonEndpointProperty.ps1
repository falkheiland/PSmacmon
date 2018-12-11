function Remove-MacmonEndpointProperty
{
  <#
    .SYNOPSIS
    Remove Endpoint Property from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Remove Endpoint Property from the macmon NAC via RESTAPI. Not all properties configurable per RESTAPI are available in this function.

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
    Remove comments about the endpoint

    .PARAMETER StaticIps
    Remove preset IP address(es) of the endpoint

    .PARAMETER Inventory
    Remove inventory number of the endpoint.

    .PARAMETER ExpireTime
    Remove the time after which the endpoint is automatically deactivated or deleted,
    depending on the scan engine setting endpoint_expire_action.

    .PARAMETER AuthorizedVlans
    Remove blank space separated list of permitted VLAN IDs or VLAN names

    .PARAMETER EndpointGroupId
    Remove ID of the group of the endpoint

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Remove-MacmonEndpointProperty -Hostname 'MACMONSERVER' -Credential $Credential -MACAddress '8C-73-6E-0B-33-6E' -Comment
    #Ask for credential then remove comment of endpoint with MACAddress '8C-73-6E-0B-33-6E'

    .EXAMPLE
    $Properties = @{
      Hostname               = 'MACMONSERVER'
      MACAddress             = '8C-73-6E-0B-33-6E'
      Comment                = $true
      StaticIps              = $true
      Inventory              = $true
      AuthorizedVlans        = $true
      EndpointGroupId        = $true
    }
    Remove-MacmonEndpointProperty @Properties
    #remove all supported properties from endpoint with MACAddress '8C-73-6E-0B-33-6E'

    .OUTPUTS
    none

    .LINK
    https://github.com/falkheiland/PSmacmon

    .LINK
    https://<MACMONSERVER>/man/index.php?controller=ApiDocuController

    #>

  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
  param (
    [Parameter(Mandatory)]
    [string]
    $HostName,

    [ValidateSet(0, 65535)]
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
    [ValidatePattern('(([0-9A-Fa-f]{2}[-:]){5}[0-9A-Fa-f]{2})|(([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4})')]
    [string]
    $MACAddress,

    [switch]
    $Comment,

    [switch]
    $StaticIps,

    [switch]
    $Inventory,

    [switch]
    $AuthorizedVlans,

    [switch]
    $EndpointGroupId
  )

  begin
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $UriArray = @($HostName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/endpoints' -f $UriArray)
    $Params = @{
      Credential = $Credential
      Method     = 'Patch'
    }
    $Body = @()
    $Op = 'remove'
  }
  process
  {
    if ($Comment)
    {
      $Body += @{
        op   = $Op
        path = '/comment'
      }
    }
    if ($StaticIps)
    {
      $Body += @{
        op   = $Op
        path = '/staticIps'
      }
    }
    if ($Inventory)
    {
      $Body += @{
        op   = $Op
        path = '/inventory'
      }
    }
    if ($AuthorizedVlans)
    {
      $Body += @{
        op   = $Op
        path = '/authorizedVlans'
      }
    }
    if ($EndpointGroupId)
    {
      $Body += @{
        op   = $Op
        path = '/endpointGroupId'
      }
    }
    $Params.Add('Body', (ConvertTo-Json $Body))
    $Params.Add('Uri', ('{0}/{1}' -f $BaseURL, $MACAddress))
    if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $MACAddress))
    {
      Invoke-MacmonRestMethod @Params
    }
  }
  end
  {
  }
}
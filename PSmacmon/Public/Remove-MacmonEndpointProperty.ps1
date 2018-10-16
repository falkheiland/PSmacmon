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
      ExpireTime             = $true
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
    $ExpireTime,

    [switch]
    $AuthorizedVlans,

    [switch]
    $EndpointGroupId
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    if ($Comment)
    {
      $BodyComment = [ordered]@{
        op   = 'remove'
        path = '/comment'
      } | ConvertTo-Json
    }
    if ($StaticIps)
    {
      $BodyStaticIps = [ordered]@{
        op   = 'remove'
        path = '/staticIps'
      } | ConvertTo-Json
    }
    if ($Inventory)
    {
      $BodyInventory = [ordered]@{
        op   = 'remove'
        path = '/inventory'
      } | ConvertTo-Json
    }
    if ($ExpireTime)
    {
      $BodyExpireTime = [ordered]@{
        op   = 'remove'
        path = '/expireTime'
      } | ConvertTo-Json
    }
    if ($AuthorizedVlans)
    {
      $BodyAuthorizedVlans = [ordered]@{
        op   = 'remove'
        path = '/authorizedVlans'
      } | ConvertTo-Json
    }
    if ($EndpointGroupId)
    {
      $BodyEndpointGroupId = [ordered]@{
        op   = 'remove'
        path = '/endpointGroupId'
      } | ConvertTo-Json
    }
    foreach ($item in ($BodyComment, $BodyStaticIps, $BodyInventory,
        $BodyExpireTime, $BodyAuthorizedVlans, $BodyEndpointGroupId))
    {
      if ($item)
      {
        $Body = $item.ToString(), $Body -join ",`r`n"
      }
    }
    $Body = $Body.TrimEnd() -replace ',$'
    if ($Body)
    {
      $BaseURL = ('https://{0}:{1}/api/v{2}/endpoints' -f $HostName, $TCPPort, $ApiVersion)
      $SessionURL = ('{0}/{1}' -f $BaseURL, $MACAddress)
      if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $MACAddress))
      {
        Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -BodyBrackets $Body -Method 'Patch'
      }
    }
  }
  end
  {
  }
}
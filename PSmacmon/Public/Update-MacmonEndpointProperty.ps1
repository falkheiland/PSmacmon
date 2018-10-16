function Update-MacmonEndpointProperty
{
  <#
    .SYNOPSIS
    Update Endpoint Property from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Update Endpoint Property from the macmon NAC via RESTAPI. Not all properties configurable per RESTAPI are available in this function.

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
    String, True or False. An inactive (deactivated) corporate device is evaluated as unauthorized.

    .PARAMETER StaticIps
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
    Update-MacmonEndpointProperty -Hostname 'MACMONSERVER' -Credential $Credential -MACAddress '8C-73-6E-0B-33-6E' -Comment 'New Comment'
    #Ask for credential then update comment of endpoint with MACAddress '8C-73-6E-0B-33-6E'

    .EXAMPLE
    $Properties = @{
      Hostname               = 'MACMONSERVER'
      MACAddress             = '8C-73-6E-0B-33-6E'
      Comment                = 'New Comment'
      Active                 = 'False'
      StaticIps              = '192.168.1.1', '10.10.10.11'
      Inventory              = '012345'
      #ExpireTime            = '2022-08-23T10:05:00Z' #API bug
      #AuthorizedVlans       = '10', '20', '30' #API bug
      EndpointGroupId        = 11
    }
    Update-MacmonEndpointProperty @Properties
    #update endpoint with MACAddress '8C-73-6E-0B-33-6E' (all provided properties)

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

    [string]
    $Comment,

    [string]
    [ValidateSet('True', 'False')]
    $Active,

    [string[]]
    [ValidateScript( {$_ -match [IPAddress]$_ })]
    $StaticIps,

    [string]
    $Inventory,

    #API bug
    #'2018-08-23T10:05:00Z'
    #[datetime]
    #$ExpireTime,

    #API bug
    #[string[]]
    #$AuthorizedVlans,

    [int]
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
        op    = 'replace'
        path  = '/comment'
        value = $Comment
      } | ConvertTo-Json
    }
    if ($Active)
    {
      $BodyActive = [ordered]@{
        op    = 'replace'
        path  = '/active'
        value = $Active
      } | ConvertTo-Json
    }
    if ($StaticIps)
    {
      $BodyStaticIps = [ordered]@{
        op    = 'replace'
        path  = '/staticIps'
        value = $StaticIps
      } | ConvertTo-Json
    }
    if ($Inventory)
    {
      $BodyInventory = [ordered]@{
        op    = 'replace'
        path  = '/inventory'
        value = $Inventory
      } | ConvertTo-Json
    }
    if ($ExpireTime)
    {
      $BodyExpireTime = [ordered]@{
        op    = 'replace'
        path  = '/expireTime'
        value = $ExpireTime
      } | ConvertTo-Json
    }
    if ($AuthorizedVlans)
    {
      $BodyAuthorizedVlans = [ordered]@{
        op    = 'replace'
        path  = '/authorizedVlans'
        value = $AuthorizedVlans
      } | ConvertTo-Json
    }
    if ($EndpointGroupId)
    {
      $BodyEndpointGroupId = [ordered]@{
        op    = 'replace'
        path  = '/endpointGroupId'
        value = $EndpointGroupId
      } | ConvertTo-Json
    }
    foreach ($item in ($BodyComment, $BodyActive, $BodyStaticIps, $BodyInventory,
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
function Update-MacmonEndpointGroupProperty
{
  <#
    .SYNOPSIS
    Update Endpoint Group Property from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Update Endpoint Group Property from the macmon NAC via RESTAPI. Not all properties configurable per RESTAPI are available in this function.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the group

    .PARAMETER Name
    Name of the group

    .PARAMETER Description
    Description of the group

    .PARAMETER macStatisticActive
    Enables the gathering of online statistics for this group. (Default $true)

    .PARAMETER MacValidity
    Validity duration of the MAC addresses in the group in days. (Default 0 =  no specification)

    .PARAMETER ObsoleteEndpointExpire
    Number of days until no longer discovered and not manually changed MAC addresses are deenabled or deleted in the group.
    A value of 0 disables the check of the obsolete_endpoint_expire for the group.
    In this case, the setting configured under Settings --> Scan engine is no longer taken into consideration for the group.
    If an value of -1 is specified in the group, then the obsolete_mac_expire configured in the settings is used.
    (0 = deactivated, default -1 = use global setting)

    .PARAMETER AuthorizedVlansLow
    Authorized VLANs for authentication only based on MAC address
    (e.g. MAC address detected when scanning the switch interface or MAB - MAC Authentication Bypass) (MAC address only)

    .PARAMETER PermissionLow
    Permission for authentication only based on MAC address
    (e.g. MAC address detected when scanning the switch interface or MAB - MAC Authentication Bypass) (MAC address only)
    (-1 Deny; 1 Accept only (without VLAN); 2 Accept with VLAN; 3 Accept and VLAN (Default))

    .PARAMETER AuthorizedVlansMedium
    Authorized VLANs for authentication with identity and password via 802.1X

    .PARAMETER PermissionMedium
    Permission for authentication with identity and password via 802.1X
    (-1 Deny; 1 Accept only (without VLAN); 2 Accept with VLAN; 3 Accept and VLAN (Default))

    .PARAMETER AuthorizedVlansHigh
    Authorized VLANs for authentication with certificate via 802.1X

    .PARAMETER PermissionHigh
    Permission for authentication with certificate via 802.1X
    (-1 Deny; 1 Accept only (without VLAN); 2 Accept with VLAN; 3 Accept and VLAN (Default))

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Update-MacmonEndpointGroupProperty -Hostname 'MACMONSERVER' -Credential $Credential -ID 187 -Name 'New Name'
    #Ask for credential then update name of endpointgroup with ID 187

    .EXAMPLE
    $Properties = @{
      Hostname               = 'MACMONSERVER'
      ID                     = 188
      name                   = 'New Name'
      description            = 'New Description'
      macStatisticActive     = $true
      macValidity            = 14
      obsoleteEndpointExpire = 180
      authorizedVlansLow     = '10', '20', '30'
      permissionLow          = 2
      authorizedVlansMedium  = '20', '30'
      permissionMedium       = 3
      authorizedVlansHigh    = '30'
      permissionHigh         = 1
    }
    Update-MacmonEndpointGroupProperty @Properties
    #update endpointgroup with ID 187 (all provided properties)

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
    [int]
    $ID,

    [string]
    $Name,

    [string]
    $Description,

    [string]
    $MacStatisticActive,

    [int]
    $MacValidity,

    [int]
    $ObsoleteEndpointExpire,

    [string[]]
    $AuthorizedVlansLow,

    [ValidateSet(-1, 1, 2, 3)]
    [int]
    $PermissionLow,

    [string[]]
    $AuthorizedVlansMedium,

    [ValidateSet(-1, 1, 2, 3)]
    [int]
    $PermissionMedium,

    [string[]]
    $AuthorizedVlansHigh,

    [ValidateSet(-1, 1, 2, 3)]
    [int]
    $PermissionHigh
  )

  begin
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $UriArray = @($HostName, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/api/v{2}/endpointgroups' -f $UriArray)
    $Params = @{
      Credential = $Credential
      Method     = 'Patch'
    }
    $Body = @()
    $Op = 'replace'
  }
  process
  {
    if ($Name)
    {
      $Body += @{
        op    = $Op
        path  = '/name'
        value = $Name
      }
    }
    if ($Description)
    {
      $Body += @{
        op    = $Op
        path  = '/description'
        value = $Description
      }
    }
    if ($MacStatisticActive)
    {
      $Body += @{
        op    = $Op
        path  = '/macStatisticActive'
        value = $MacStatisticActive
      }
    }
    if ($MacValidity)
    {
      $Body += @{
        op    = $Op
        path  = '/macValidity'
        value = $MacValidity * 86400
      }
    }
    if ($ObsoleteEndpointExpire)
    {
      $Body += @{
        op    = $Op
        path  = '/obsoleteEndpointExpire'
        value = $ObsoleteEndpointExpire * 86400
      }
    }
    if ($AuthorizedVlansLow)
    {
      $Body += @{
        op    = $Op
        path  = '/authorizedVlansLow'
        value = $AuthorizedVlansLow
      }
    }
    if ($PermissionLow)
    {
      $Body += @{
        op    = $Op
        path  = '/permissionLow'
        value = $PermissionLow
      }
    }
    if ($AuthorizedVlansMedium)
    {
      $Body += @{
        op    = $Op
        path  = '/authorizedVlansMedium'
        value = $AuthorizedVlansMedium
      }
    }
    if ($PermissionMedium)
    {
      $Body += @{
        op    = $Op
        path  = '/permissionMedium'
        value = $PermissionMedium
      }
    }
    if ($AuthorizedVlansHigh)
    {
      $Body += @{
        op    = $Op
        path  = '/authorizedVlansHigh'
        value = $AuthorizedVlansHigh
      }
    }
    if ($PermissionHigh)
    {
      $Body += @{
        op    = $Op
        path  = '/permissionHigh'
        value = $PermissionHigh
      }
    }
    $Params.Add('Body', (ConvertTo-Json $Body))
    $Params.Add('Uri', ('{0}/{1}' -f $BaseURL, $ID))
    if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $ID))
    {
      Invoke-MacmonRestMethod @Params
    }
  }
  end
  {
  }
}
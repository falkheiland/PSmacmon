function New-MacmonEndpointGroup
{
  <#
    .SYNOPSIS
    Get Endpoint Group from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get Endpoint Group from the macmon NAC via RESTAPI. Not all properties configurable per RESTAPI are available in this function.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 8443)

    .PARAMETER ApiVersion
    API Version to use (Default: 3)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER Name
    Unique name of the group

    .PARAMETER Description
    Description of the group

    .PARAMETER MacStatisticActive
    Enables the gathering of online statistics for this group. (Default $true)

    .PARAMETER MacValidity
    Validity duration of the MAC addresses in the group in days. (Default 0 =  no specification)

    .PARAMETER
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
    (1 Accept only (without VLAN); 2 Accept with VLAN; 3  Accept and VLAN (Default))

    .PARAMETER AuthorizedVlansMedium
    Authorized VLANs for authentication with identity and password via 802.1X

    .PARAMETER PermissionMedium
    Permission for authentication with identity and password via 802.1X
    (1 Accept only (without VLAN); 2 Accept with VLAN; 3  Accept and VLAN (Default))

    .PARAMETER AuthorizedVlansHigh
    Authorized VLANs for authentication with certificate via 802.1X

    .PARAMETER PermissionHigh
    Permission for authentication with certificate via 802.1X
    (1 Accept only (without VLAN); 2 Accept with VLAN; 3  Accept and VLAN (Default))

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    New-MacmonEndpointGroup -Hostname 'MACMONSERVER' -Credential $Credential -Name 'NewEndpointGroup'
    #Ask for credential then create new endpointgroup with name 'NewEndpointGroup' (minimum requirement)

    .EXAMPLE
    $Properties = @{
      Hostname               = 'MACMONSERVER'
      name                   = 'NewEndpointGroup'
      description            = 'new Endpoint-Group'
      macStatisticActive     = $true
      macValidity            = 14
      obsoleteEndpointExpire = 180
      authorizedVlansLow     = 10, 20, 30
      permissionLow          = 2
      authorizedVlansMedium  = 20, 30
      permissionMedium       = 3
      authorizedVlansHigh    = 30
      permissionHigh         = 1
    }
    New-MacmonEndpointGroup @Properties
    #Create new endpoinzgroup with all supported (by function) properties

    .OUTPUTS
    ID for the new endpointgroup

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
    [string]
    $Name,

    [string]
    $Description,

    [bool]
    $MacStatisticActive = $true,

    [int]
    $MacValidity = 0,

    [int]
    $ObsoleteEndpointExpire = -1,

    [ValidateRange(0, 4096)]
    [int[]]
    $AuthorizedVlansLow,

    [ValidateRange(1, 3)]
    [int]
    $PermissionLow,

    [ValidateRange(0, 4096)]
    [int[]]
    $AuthorizedVlansMedium,

    [ValidateRange(1, 3)]
    [int]
    $PermissionMedium,

    [ValidateRange(0, 4096)]
    [int[]]
    $AuthorizedVlansHigh,

    [ValidateRange(1, 3)]
    [int]
    $PermissionHigh
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate

    $Body = [ordered]@{
      name                  = $Name
      description           = $Description
      macStatisticActive    = $MacStatisticActive
      macValidity           = $MacValidity * 86400000
      authorizedVlansLow    = $AuthorizedVlansLow
      permissionLow         = $PermissionLow
      authorizedVlansMedium = $AuthorizedVlansMedium
      permissionMedium      = $PermissionMedium
      authorizedVlansHigh   = $AuthorizedVlansHigh
      permissionHigh        = $PermissionHigh
    }
    if ($ObsoleteEndpointExpire -ge 0)
    {
      $Body.add('obsoleteEndpointExpire', $ObsoleteEndpointExpire * 86400000)
    }
    $Body = $Body | ConvertTo-Json

    $BaseURL = ('https://{0}:{1}/api/v{2}/endpointgroups' -f $HostName, $TCPPort, $ApiVersion)
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
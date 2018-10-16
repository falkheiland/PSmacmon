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
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    if ($Name)
    {
      $BodyName = [ordered]@{
        op    = 'replace'
        path  = '/name'
        value = $Name
      } | ConvertTo-Json
    }
    if ($Description)
    {
      $BodyDescription = [ordered]@{
        op    = 'replace'
        path  = '/description'
        value = $Description
      } | ConvertTo-Json
    }
    if ($MacStatisticActive)
    {
      $BodyMacStatisticActive = [ordered]@{
        op    = 'replace'
        path  = '/macStatisticActive'
        value = $MacStatisticActive
      } | ConvertTo-Json
    }
    if ($MacValidity)
    {
      $BodyMacValidity = [ordered]@{
        op    = 'replace'
        path  = '/macValidity'
        value = $MacValidity * 86400
      } | ConvertTo-Json
    }
    if ($ObsoleteEndpointExpire)
    {
      $BodyObsoleteEndpointExpire = [ordered]@{
        op    = 'replace'
        path  = '/obsoleteEndpointExpire'
        value = $ObsoleteEndpointExpire * 86400
      } | ConvertTo-Json
    }
    if ($AuthorizedVlansLow)
    {
      $BodyAuthorizedVlansLow = [ordered]@{
        op    = 'replace'
        path  = '/authorizedVlansLow'
        value = $AuthorizedVlansLow
      } | ConvertTo-Json
    }
    if ($PermissionLow)
    {
      $BodyPermissionLow = [ordered]@{
        op    = 'replace'
        path  = '/permissionLow'
        value = $PermissionLow
      } | ConvertTo-Json
    }
    if ($AuthorizedVlansMedium)
    {
      $BodyAuthorizedVlansMedium = [ordered]@{
        op    = 'replace'
        path  = '/authorizedVlansMedium'
        value = $AuthorizedVlansMedium
      } | ConvertTo-Json
    }
    if ($PermissionMedium)
    {
      $BodyPermissionMedium = [ordered]@{
        op    = 'replace'
        path  = '/permissionMedium'
        value = $PermissionMedium
      } | ConvertTo-Json
    }
    if ($AuthorizedVlansHigh)
    {
      $BodyAuthorizedVlansHigh = [ordered]@{
        op    = 'replace'
        path  = '/authorizedVlansHigh'
        value = $AuthorizedVlansHigh
      } | ConvertTo-Json
    }
    if ($PermissionHigh)
    {
      $BodyPermissionHigh = [ordered]@{
        op    = 'replace'
        path  = '/permissionHigh'
        value = $PermissionHigh
      } | ConvertTo-Json
    }
    foreach ($item in ($BodyName, $BodyDescription, $BodyMacStatisticActive, $BodyMacValidity,
        $BodyObsoleteEndpointExpire, $BodyAuthorizedVlansLow, $BodyPermissionLow, $BodyAuthorizedVlansMedium,
        $BodyPermissionMedium, $BodyAuthorizedVlansHigh, $BodyPermissionHigh))
    {
      if ($item)
      {
        $Body = $item.ToString(), $Body -join ",`r`n"
      }
    }
    $Body = $Body.TrimEnd() -replace ',$'
    if ($Body)
    {
      $BaseURL = ('https://{0}:{1}/api/v{2}/endpointgroups' -f $HostName, $TCPPort, $ApiVersion)
      $SessionURL = ('{0}/{1}' -f $BaseURL, $ID)
      if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $ID))
      {
        Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -BodyBrackets $Body -Method 'Patch'
      }
    }
  }
  end
  {
  }
}
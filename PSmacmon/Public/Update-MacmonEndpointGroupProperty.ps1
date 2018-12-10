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

    .PARAMETER Property
    Property to update

    .PARAMETER Value
    Value to upgrade property to
    macStatisticActive: Enables the gathering of online statistics for this group. (Default $true)
    MacValidity: Validity duration of the MAC addresses in the group in days. (Default 0 =  no specification)
    ObsoleteEndpointExpire: Number of days until no longer discovered and not manually changed MAC addresses are deenabled or deleted in the group.
    A value of 0 disables the check of the obsolete_endpoint_expire for the group.
    In this case, the setting configured under Settings --> Scan engine is no longer taken into consideration for the group.
    If an value of -1 is specified in the group, then the obsolete_mac_expire configured in the settings is used.
    (0 = deactivated, default -1 = use global setting)
    AuthorizedVlansLow/AuthorizedVlansMedium/AuthorizedVlansHigh: Authorized VLANs for authentication only based on MAC address
    (e.g. MAC address detected when scanning the switch interface or MAB - MAC Authentication Bypass) (MAC address only)
    PermissionLow/PermissionMedium/PermissionHigh: for authentication only based on MAC address
    (e.g. MAC address detected when scanning the switch interface or MAB - MAC Authentication Bypass) (MAC address only)
    (-1 Deny; 1 Accept only (without VLAN); 2 Accept with VLAN; 3 Accept and VLAN (Default))

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Update-MacmonEndpointGroupProperty -Hostname 'MACMONSERVER' -Credential $Credential -ID 187 -Name 'New Name'
    Ask for credential then update name of endpointgroup with ID 187

    .EXAMPLE
    187, 188, 192 | Update-MacmonEndpointGroupProperty -Property Description -Value 'New Description'
    Update comment on endpointgroups with ID 187, 188 and 192 to 'New Description'

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

    [Parameter(ValueFromPipeline, Mandatory)]
    [int]
    $ID,

    [Parameter(Mandatory)]
    [ValidateSet('Name',
      'Description',
      'MacStatisticActive',
      'MacValidity',
      'ObsoleteEndpointExpire',
      'AuthorizedVlansLow',
      'PermissionLow',
      'AuthorizedVlansMedium',
      'PermissionMedium',
      'AuthorizedVlansHigh',
      'PermissionHigh')]
    [string]
    $Property,

    [Parameter(Mandatory)]
    [string]
    $Value
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
  }
  process
  {
    $Params.Add('Body', (Get-MacmonRestBody -Property $Property -Op 'replace' -Value $Value))
    if ($Params.Body)
    {
      $Params.Add('Uri', ('{0}/{1}' -f $BaseURL, $ID))
      if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $ID))
      {
        Invoke-MacmonRestMethod @Params
      }
    }
  }
  end
  {
  }
}
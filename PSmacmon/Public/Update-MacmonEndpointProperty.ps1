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

        .PARAMETER Property
    Property to update

    .PARAMETER Value
    Value to upgrade property to
    Comment: Comments about the endpoint
    Active: String, True or False. An inactive (deactivated) corporate device is evaluated as unauthorized.
    StaticIps: Preset IP address(es) of the endpoint
    Inventory: Inventory number of the endpoint.
    ExpireTime: Defines the time after which the endpoint is automatically deactivated or deleted,
    depending on the scan engine setting endpoint_expire_action.
    AuthorizedVlans: Blank space separated list of permitted VLAN IDs or VLAN names
    EndpointGroupId: ID of the Group of the endpoint

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Update-MacmonEndpointProperty -Hostname 'MACMONSERVER' -Credential $Credential -MACAddress '8C-73-6E-0B-33-6E' -Comment 'New Comment'
    Ask for credential then update comment of endpoint with MACAddress '8C-73-6E-0B-33-6E'

    .EXAMPLE
    $Properties = @{
      Hostname        = 'MACMONSERVER'
      AuthorizedVlans = 10,12
    }
    '8C-73-6E-0B-33-6E', '8C-73-6E-0D-31-4A' | Update-MacmonEndpointProperty @Properties
    Update AuthorizedVlans for endpoints with MACAddress '8C-73-6E-0B-33-6E' and '8C-73-6E-0D-31-4A'

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

    [Parameter(Mandatory)]
    [ValidateSet('Comment',
      'Active',
      'StaticIps',
      'Inventory',
      'AuthorizedVlans',
      'EndpointGroupId')]
    [string]
    $Property,

    [Parameter(Mandatory)]
    [string[]]
    $Value
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
  }
  process
  {
    $Params.Add('Body', (Get-MacmonRestBody -Property $Property -Op 'replace' -Value $Value))
    if ($Params.Body)
    {
      $Params.Add('Uri', ('{0}/{1}' -f $BaseURL, $MACAddress))
      if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $MACAddress))
      {
        #$Params.Uri
        #$Params.Body
        Invoke-MacmonRestMethod @Params
      }
    }
  }
  end
  {
  }
}
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

    .PARAMETER Property
    Property to remove ('Comment', 'StaticIps', 'Inventory', 'ExpireTime', 'AuthorizedVlans', 'EndpointGroupId')

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Remove-MacmonEndpointProperty -Hostname 'MACMONSERVER' -Credential $Credential -MACAddress '8C-73-6E-0B-33-6E' -Property Comment
    #Ask for credential then remove comment of endpoint with MACAddress '8C-73-6E-0B-33-6E'

    .EXAMPLE
    $Properties = @{
      Hostname = 'MACMONSERVER'
      Property = 'Comment'
    }
    '8C-73-6E-0B-33-6E', '8C-73-6E-0A-34-21'| Remove-MacmonEndpointProperty @Properties
    #remove comment from endpoints with MACAddress '8C-73-6E-0B-33-6E' and '8C-73-6E-0A-34-21'

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
    [ValidatePattern('(([0-9A-Fa-f]{2}[-:]){5}[0-9A-Fa-f]{2})|(([0-9A-Fa-f]{4}\.){2}[0-9A-Fa-f]{4})')]
    [string]
    $MACAddress,

    [Parameter(Mandatory)]
    [ValidateSet('Comment', 'StaticIps', 'Inventory', 'ExpireTime', 'AuthorizedVlans', 'EndpointGroupId')]
    [string]
    $Property
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
    $Params.Add('Body', (Get-MacmonRestBody -Property $Property -Op 'remove'))
    if ($Params.Body)
    {
      $Params.Add('Uri', ('{0}/{1}' -f $BaseURL, $MACAddress))
      if ($PSCmdlet.ShouldProcess('EndpointGroup: {0}' -f $MACAddress))
      {
        Invoke-MacmonRestMethod @Params
      }
    }
  }
  end
  {
  }
}
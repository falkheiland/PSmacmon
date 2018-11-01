function New-MacmonNetworkDevice
{
  <#
    .SYNOPSIS
    Create network device from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Create network device from the macmon NAC via RESTAPI. Not all properties configurable per RESTAPI are available in this function.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER Address
    IP address or DNS name used for the communication with the network device

    .PARAMETER Active
    True, if query for the network device active. (Default: True)

    .PARAMETER Nac
    True, if network access control active. (Default: False)

    .PARAMETER NetworkDeviceGroupId
    Device group ID. If no group is specified, only the SNMP basic data are queried from the network device.

    .PARAMETER Description
    Additional description of the network device. If no description is given,
    then it will be transferred from the corresponding SNMP property after the first scan of the network device.

    .PARAMETER Location
    Location of the network device. If no location is specified,
    the value from the SNMP property sysLocation is transferred after the network device first scan.

    .PARAMETER IgnoreHardwareChanges
    Activates the suppression of the generating of the device_changed event for this network device.
    This makes sense, for instance, in switch clusters, where the base MAC address (SNMP-dot1dBaseBridgeAddress)
    changes without the hardware having been changed. (Default: False)

    .PARAMETER EnabledProtocols
    Protocols allowed for scanning. (Default: 'snmpv3', 'snmpv2c', 'snmpv1', 'radius', 'ssh', 'telnet', 'http', 'ldap', 'dns')

    .PARAMETER InterfaceStatistic
    True, if interface statistics are generated. (Default: False)

    .PARAMETER WebInterfaceUrl
    URL to the web interface of the network device

    .PARAMETER CredentialIds
    IDs for directly assigned credentials

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    New-MacmonNetworkDevice -Hostname 'MACMONSERVER' -Credential $Credential -Address 'NEWSWITCH'
    #Ask for credential then create new network device with address 'NEWSWITCH' (minimum requirement)

    .EXAMPLE
    $Properties = @{
      Hostname              = 'MACMONSERVER'
      address               = '192.168.0.1'
      active                = $true
      nac                   = $false
      ignoreHardwareChanges = $true
      enabledProtocols      = ('snmpv3', 'snmpv2c')
      interfaceStatistic    = $true
      networkDeviceGroupId  = 14
      description           = 'New Device'
      location              = 'Cabinet 1'
      webInterfaceUrl       = 'https://NewDevice.acme.com'
      credentialIds         = 1, 2
    }
    New-MacmonNetworkDevice @Properties
    #Create new network device with all supported (by function) properties

    .OUTPUTS
    ID for the new network device

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
    $Address,

    [bool]
    $Active = $true,

    [bool]
    $Nac = $false,

    [int]
    $NetworkDeviceGroupId,

    [string]
    $Description,

    [string]
    $Location,

    [bool]
    $IgnoreHardwareChanges = $false,

    [string[]]
    $EnabledProtocols = ('snmpv3', 'snmpv2c', 'snmpv1', 'radius', 'ssh', 'telnet', 'http', 'ldap', 'dns'),

    [bool]
    $InterfaceStatistic = $false,

    $UserValues,

    [ValidatePattern("^[(http(s)?):\/\/].*")]
    [string]
    $WebInterfaceUrl,

    [int[]]
    $CredentialIds
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate

    $Body = @{
      address               = $Address
      active                = $Active
      nac                   = $Nac
      ignoreHardwareChanges = $IgnoreHardwareChanges
      enabledProtocols      = $EnabledProtocols
      interfaceStatistic    = $InterfaceStatistic
    }
    if ($NetworkDeviceGroupId)
    {
      $Body.add('networkDeviceGroupId', $NetworkDeviceGroupId)
    }
    if ($Description)
    {
      $Body.add('description', $Description)
    }
    if ($Location)
    {
      $Body.add('location', $Location)
    }
    if ($WebInterfaceUrl)
    {
      $Body.add('webInterfaceUrl', $WebInterfaceUrl)
    }
    if ($CredentialIds)
    {
      $Body.add('credentialIds', $CredentialIds)
    }
    $Body = $Body | ConvertTo-Json

    $BaseURL = ('https://{0}:{1}/api/v{2}/networkdevices' -f $HostName, $TCPPort, $ApiVersion)
    $SessionURL = ('{0}' -f $BaseURL)
    if ($PSCmdlet.ShouldProcess('network device: {0}' -f $Name))
    {
      Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Body $Body -Method 'Post'
    }
  }
  end
  {
  }
}
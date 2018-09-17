function Get-MacmonSystem
{
  <#
    .SYNOPSIS
    Get System Infos from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get System Infos from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 443)

    .PARAMETER ApiVersion
    API Version to use (Default: 1.0)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER Version
    Get the version of the system

    .PARAMETER Documentation
    Get the API docu as swagger JSON

    .PARAMETER IPs
    Get all local IP addresses of the system

    .PARAMETER Uptime
    Get up time of the system in milliseconds

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    Get-MacmonSystem -Hostname 'MACMONSERVER' -Credential $Credential
    #Ask for credential then get the version of the system using provided credential

    .EXAMPLE
    Get-MacmonSystem -Hostname 'MACMONSERVER' -Documentation
    #Get the API docu as swagger JSON

    .EXAMPLE
    Get-MacmonSystem -Hostname 'MACMONSERVER' -IPs
    #Get all local IP addresses of the system

    .EXAMPLE
    Get-MacmonSystem -Hostname 'MACMONSERVER' -Uptime
    #Get up time of the system in milliseconds

    .LINK
    https://github.com/falkheiland/PSmacmon

    .LINK
    https://<MACMONSERVER>/man/index.php?controller=ApiDocuController

    #>

  [CmdletBinding(DefaultParametersetname = 'Version')]
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

    [Parameter(ParameterSetName = 'Documentation')]
    [switch]
    $Documentation,

    [Parameter(ParameterSetName = 'IPs')]
    [switch]
    $IPs,

    [Parameter(ParameterSetName = 'Uptime')]
    [switch]
    $Uptime,

    [Parameter(ParameterSetName = 'Version')]
    [switch]
    $Version
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $BaseURL = ('https://{0}:{1}/api/v{2}/system' -f $HostName, $TCPPort, $ApiVersion)
    switch ($PsCmdlet.ParameterSetName)
    {
      'Version'
      {
        $SessionURL = ('{0}/version' -f $BaseURL)
      }
      'Documentation'
      {
        $SessionURL = ('{0}/docu' -f $BaseURL)
      }
      'IPs'
      {
        $SessionURL = ('{0}/ips' -f $BaseURL)
      }
      'Uptime'
      {
        $SessionURL = ('{0}/sys-up-time' -f $BaseURL)
      }
    }
    Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get'
  }
  end
  {
  }
}
function New-MacmonEndpointGroup
{
  <#
    .SYNOPSIS
    Get Endpoint Group from the macmon NAC via RESTAPI.

    .DESCRIPTION
    Get Endpoint Group from the macmon NAC via RESTAPI.

    .PARAMETER HostName
    IP-Address or Hostname of the macmon NAC

    .PARAMETER TCPPort
    TCP Port API (Default: 8443)

    .PARAMETER ApiVersion
    API Version to use (Default: 3)

    .PARAMETER Credential
    Credentials for the macmon NAC

    .PARAMETER ID
    ID of the endpoint group

    .EXAMPLE
    $Credential = Get-Credential -Message 'Enter your credentials'
    New-MacmonEndpointGroup -Hostname 'MACMONSERVER' -Credential $Credential
    #Ask for credential then get Endpoint Group from macmon NAC using provided credential

    .EXAMPLE
    0 | New-MacmonEndpointGroup -Hostname 'MACMONSERVER' | Select-Object -Property name, description
    #Get name and description from Endpoint Group with ID 0

    .EXAMPLE
    (New-MacmonEndpointGroup -Hostname 'MACMONSERVER').where{$_.obsoleteEndpointExpire} |
      Select-Object -Property name, obsoleteEndpointExpire |
      Sort-Object obsoleteEndpointExpire, name
    #Get name and obsoleteEndpointExpire from Endpoint Group with obsoleteEndpointExpire, sorted by obsoleteEndpointExpire and name

    .NOTES
    n.a.

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
    $MacStatisticActive,

    [int]
    $MacValidity = 0,

    [int]
    $ObsoleteEndpointExpire,

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
    $AuthorizedVlansHigh
  )

  begin
  {
  }
  process
  {
    Invoke-MacmonTrustSelfSignedCertificate
    $Body = [ordered]@{
      name                   = $Name
      description            = $Description
      macStatisticActive     = $MacStatisticActive
      macValidity            = $MacValidity
      obsoleteEndpointExpire = $ObsoleteEndpointExpire
      authorizedVlansLow     = $AuthorizedVlansLow
      permissionLow          = $PermissionLow
      authorizedVlansMedium  = $AuthorizedVlansMedium
      permissionMedium       = $PermissionMedium
      authorizedVlansHigh    = $AuthorizedVlansHigh
    } | ConvertTo-Json
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
function Invoke-MacmonRestMethod
{
  <#
    .SYNOPSIS
    Invoke-RestMethod Wrapper for macmon API

    .DESCRIPTION
    Invoke-RestMethod Wrapper for macmon API

    .EXAMPLE
    Invoke-MacmonRestMethod -Credential $Credential -Uri $Uri -Method 'Get'

    .NOTES
     n.a.
    #>

  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential,

    [Parameter(Mandatory)]
    [string]
    $Uri,

    [string]
    $Body,

    [Parameter(Mandatory)]
    [ValidateSet('Get', 'Post', 'Delete', 'Patch', 'Put')]
    [string]
    $Method
  )

  begin
  {
    $CredString = ("{0}:{1}" -f $Credential.UserName, $Credential.GetNetworkCredential().Password)
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($CredString))
  }
  process
  {
    try
    {
      [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
      $PSBoundParameters.Add('Headers', @{Authorization = ("Basic {0}" -f $base64AuthInfo)})
      $PSBoundParameters.Add('ContentType', 'application/json; charset=utf-8')
      $PSBoundParameters.Add('ErrorAction', 'Stop')
      $Null = $PSBoundParameters.Remove('Credential')
      Invoke-RestMethod @PSBoundParameters
    }
    catch [System.Net.WebException]
    {
      switch ($($PSItem.Exception.Response.StatusCode.value__))
      {
        200
        {
          Write-Warning -Message ('Success. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
        204
        {
          Write-Warning -Message ('Success, but no return. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
        400
        {
          Write-Warning -Message ('Request error. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
        404
        {
          Write-Warning -Message ('Page or object not found. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
        405
        {
          Write-Warning -Message ('Invalid method. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
        500
        {
          Write-Warning -Message ('Internal server error. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
        911
        {
          Write-Warning -Message ('Application error. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
        default
        {
          Write-Warning -Message ('Some error occured, see HTTP status code for further details. Uri: {0} Method: {1}' -f $Uri, $Method)
        }
      }
    }
  }
  end
  {
  }
}
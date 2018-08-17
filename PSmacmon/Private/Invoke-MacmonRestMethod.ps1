function Invoke-MacmonRestMethod
{
  <#
    .SYNOPSIS
    Invoke-RestMethod Wrapper for macmon API

    .DESCRIPTION
    Invoke-RestMethod Wrapper for macmon API

    .EXAMPLE
    Invoke-MacmonRestMethod -Credential $Credential -SessionURL $SessionURL -Method 'Get'

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
    $SessionURL,

    [Parameter(Mandatory)]
    [ValidateSet('Get', 'Post', 'Put', 'Delete')]
    [string]
    $Method
  )

  begin
  {
  }
  process
  {
    $Username = $Credential.UserName
    $Password = $Credential.GetNetworkCredential().Password
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username, $Password)))

    $Params = @{
      Uri         = $SessionURL
      Headers     = @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
      ContentType = 'application/json'
      Method      = $Method
    }
    try
    {
      Invoke-RestMethod @Params -ErrorAction Stop
    }
    catch [System.Net.WebException]
    {
      $PSItem
      switch ($($PSItem.Exception.Response.StatusCode.value__))
      {
        400
        {
          Write-Warning -Message ('Error executing IMI RestAPI request. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        401
        {
          Write-Warning -Message ('Error logging in, it seems as you have entered invalid credentials. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        403
        {
          Write-Warning -Message ('Error logging in, it seems as you have not subscripted this version of IMI. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        default
        {
          Write-Warning -Message ('Some error occured see HTTP status code for further details. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
      }
    }
  }
  end
  {
  }
}
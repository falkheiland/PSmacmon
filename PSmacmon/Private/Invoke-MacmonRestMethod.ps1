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

  [CmdletBinding(DefaultParameterSetName = 'NoBody')]
  param (
    [Parameter(Mandatory)]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential,

    [Parameter(Mandatory)]
    [string]
    $SessionURL,

    [Parameter(ParameterSetName = 'Body')]
    [string]
    $Body,

    [Parameter(ParameterSetName = 'BodyBrackets')]
    [string]
    $BodyBrackets,

    [Parameter(Mandatory)]
    [ValidateSet('Get', 'Post', 'Delete', 'Patch', 'Put')]
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
    switch ($PSCmdlet.ParameterSetName)
    {
      Body
      {
        $Params = @{
          Uri         = $SessionURL
          Headers     = @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
          Body        = '{0}' -f $Body
          ContentType = 'application/json'
          Method      = $Method
        }
      }
      BodyBrackets
      {
        $Params = @{
          Uri         = $SessionURL
          Headers     = @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
          Body        = '[{0}]' -f $BodyBrackets
          ContentType = 'application/json'
          Method      = $Method
        }
      }
      NoBody
      {
        $Params = @{
          Uri         = $SessionURL
          Headers     = @{Authorization = ("Basic {0}" -f $base64AuthInfo)}
          ContentType = 'application/json'
          Method      = $Method
        }
      }
    }
    try
    {
      Invoke-RestMethod @Params -ErrorAction Stop
    }
    catch [System.Net.WebException]
    {
      switch ($($PSItem.Exception.Response.StatusCode.value__))
      {
        200
        {
          Write-Warning -Message ('Success. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        204
        {
          Write-Warning -Message ('Success, but no return. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        400
        {
          Write-Warning -Message ('Request error. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        404
        {
          Write-Warning -Message ('Page or object not found. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        405
        {
          Write-Warning -Message ('Invalid method. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        500
        {
          Write-Warning -Message ('Internal server error. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        911
        {
          Write-Warning -Message ('Application error. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
        default
        {
          Write-Warning -Message ('Some error occured, see HTTP status code for further details. SessionURL: {0} Method: {1}' -f $SessionURL, $Method)
        }
      }
    }
  }
  end
  {
  }
}
function Get-MacmonRestBody
{
  <#
  .EXAMPLE
  Get-MacmonRestBody -Property Comment -Op 'remove'
  Get-MacmonRestBody -Property Comment -Op 'replace' -Value 'New Comment'
  #>

  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string]
    $Property,

    [Parameter(Mandatory)]
    [string]
    $Op,

    [string]
    $Value
  )

  begin
  {
  }
  process
  {
    $Result = [ordered]@{
      op   = $Op
      path = ('/{0}{1}' -f $Property.Substring(0, 1).ToLower(), $Property.Substring(1))
    }
    if ($Value)
    {
      $Result.Add('value', $Value)
    }
    ConvertTo-Json -InputObject @($Result) -Depth 10
  }
  end
  {
  }
}
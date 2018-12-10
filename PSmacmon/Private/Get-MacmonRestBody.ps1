function Get-MacmonRestBody
{
  <#
  .EXAMPLE
  Get-MacmonRestBody -Property Comment -Op 'remove'
  Get-MacmonRestBody -Property staticIps -Op 'replace' -Value '192.168.3.3', '192.168.3.4'
  Get-MacmonRestBody -Property staticIps -Op 'replace' -Value '192.168.3.3'
  #>

  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string]
    $Property,

    [Parameter(Mandatory)]
    [string]
    $Op,

    [string[]]
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
      #[array]$ValueArray = foreach ($item in $Value)
      $ValueArray = foreach ($item in $Value)
      {
        $item
      }
      $Result.Add('value', $ValueArray)
    }
    ConvertTo-Json -InputObject @($Result) -Depth 10
  }
  end
  {
  }
}
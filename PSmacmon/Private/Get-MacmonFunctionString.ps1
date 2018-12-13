function Get-MacmonFunctionString
{
  <#
  .EXAMPLE
  $Params = [ordered]@{
    Filter = 'active==true and networkDeviceGroup.name == "Switch"'
    Fields = 'id,userValues.*.value'
    Limit = '10'
    Offset = '2'
    Sort   = 'active,address'
  }
  MacmonFunctionString @Params

  Get-MacmonFunctionString -Filter 'active==true and networkDeviceGroup.name == "Switch"' -Fields 'id,userValues.*.value' -Sort 'active,address'
  Get-MacmonFunctionString -Filter 'active==true and networkDeviceGroup.name == "Switch"'
  Get-MacmonFunctionString -Fields 'id,userValues.*.value' -Offset 10
  Get-MacmonFunctionString -Offset 0
  Get-MacmonFunctionString -Fields '' -Offset 0
  #>

  [CmdletBinding()]
  param (
    [string]
    $Fields,

    [string]
    $Sort,

    [int]
    $Limit,

    [int]
    $Offset,

    [string]
    $Filter,

    [string]
    $Format
  )

  begin
  {
  }
  process
  {
    foreach ($item in $PSBoundParameters.GetEnumerator())
    {
      if ($item.Value)
      {
        if ($item.Value -is [int])
        {
          $Value = ($item.Value).toString()
        }
        else
        {
          $Value = $item.Value
        }
        $FunctionString += ('&{0}={1}' -f $($item.Key).ToLower(), $Value)
      }
    }
    $FunctionString -replace ('^&', '?')
  }
  end
  {
  }
}
$Credential = Get-Credential
$RogueGroupName = '[rogue]'
$ExpiredGroupName = '[Expired]'
$Pattern = '([a-z,A-Z]{2}|_)(?<IV>0{1}\d{5})($|\D)'


$PSDefaultParameterValues = @{
  '*Macmon*:Credential' = $Credential
  '*Macmon*:HostName'   = 'SRVNAC01'
}

$EndPointColl = Get-MacmonEndpoint

foreach ($EndPoint in $EndPointColl)
{
  if (($EndPoint.inventory) -match $Pattern)
  {
    Update-MacmonEndpointProperty -MACAddress $EndPoint.mac -Inventory $($Matches.IV) -Confirm
  }
}

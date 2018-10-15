$Credential = Get-Credential
$RogueGroupName = '[rogue]'
$ExpiredGroupName = '[Expired]'


$PSDefaultParameterValues = @{
  '*Macmon*:Credential' = $Credential
  '*Macmon*:HostName'   = 'SRVNAC01'
}

$RogueGroupId = ((Get-MacmonEndpointGroup).where{$_.name -eq $RogueGroupName}).id
$ExpiredGroupId = ((Get-MacmonEndpointGroup).where{$_.name -eq $ExpiredGroupName}).id
$IncativeEndpointColl = (Get-MacmonEndpoint).where{($_.active -eq $False) -and ($_.endpointGroupId -ne $RogueGroupId) -and ($_.endpointGroupId -ne $ExpiredGroupId)}

foreach ($IncativeEndpoint in $IncativeEndpointColl)
{
  $IncativeEndpoint.mac
  Update-MacmonEndpointProperty -MACAddress $IncativeEndpoint.mac -EndpointGroupId $ExpiredGroupId -Confirm
}

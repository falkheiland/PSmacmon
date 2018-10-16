#$Credential = Get-Credential
$RogueGroupName = '[rogue]'
$ExpiredGroupName = '[Expired]'
$Pattern = '([a-z,A-Z]{2}|_|\b)(?<IV>0{1}\d{5})($|\D)'


$PSDefaultParameterValues = @{
  '*Macmon*:Credential' = $Credential
  '*Macmon*:HostName'   = 'SRVNAC01'
}

$EndPointColl = Get-MacmonEndpoint

foreach ($EndPoint in $EndPointColl)
{
  if ($EndPoint.inventory -and (($EndPoint.inventory) -notmatch $Pattern))
  {
    $Comment = ($EndPoint.comment).Trim()
    $Inventory = ($EndPoint.inventory).Trim()
    $Inventory = ($EndPoint.inventory).TrimEnd('.bfw.local')
    'Comment: {0} {1}' -f $Comment, ($Comment).Length
    'Inventory: {0} {1}' -f $Inventory, ($Inventory).Length
    if ($Comment -ne $Inventory)
    {
      if (!$Comment)
      {
        $NewComment = '{0}' -f $Inventory
      }
      else
      {
        $NewComment = '{0}; {1}' -f $Inventory, $Comment
      }
      'new Comment: {0}' -f $NewComment
      Update-MacmonEndpointProperty -MACAddress $EndPoint.mac -Comment $NewComment
    }
    Remove-MacmonEndpointProperty -MACAddress $EndPoint.mac -Inventory
  }
}

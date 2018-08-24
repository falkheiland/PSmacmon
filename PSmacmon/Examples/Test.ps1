$Credential = Get-Credential

$PSDefaultParameterValues += @{
  '*Macmon*:Credential'        = $Credential
  '*Macmon*:HostName'          = 'MACMONSERVER'
  'Export-Excel:Now'           = $True
  'Export-Excel:WarningAction' = 'SilentlyContinue'
}

Get-MacmonEndpoint | Export-Excel
Get-MacmonEndpointGroup | Export-Excel
Get-MacmonNetworkDevice | Export-Excel -NoNumberConversion 'location', 'address'
Get-MacmonNetworkDeviceGroup | Export-Excel -NoNumberConversion 'classifierValue'
Get-MacmonNetworkDeviceClass | Export-Excel -NoNumberConversion 'classifierValue'


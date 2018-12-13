---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Remove-MacmonEndpointProperty.md
schema: 2.0.0
---

# Remove-MacmonEndpointProperty

## SYNOPSIS
Remove Endpoint Property from the macmon NAC via RESTAPI.

## SYNTAX

```
Remove-MacmonEndpointProperty [-HostName] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-MACAddress] <String> [-Comment] [-StaticIps] [-Inventory] [-AuthorizedVlans]
 [-EndpointGroupId] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove Endpoint Property from the macmon NAC via RESTAPI.
Not all properties configurable per RESTAPI are available in this function.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  MACAddress = '00-11-22-33-44-55'
  Comment    = $True
}
Remove-MacmonEndpointProperty @Params
```
```
#no output
```
Remove comment of endpoint with MACAddress '00-11-22-33-44-55'.

### Example 2
```powershell
$Params = @{
  Hostname        = 'MACMONSERVER'
  Credential      = Get-Credential
  MACAddress      = '00-11-22-33-44-55'
  Comment         = $true
  StaticIps       = $true
  Inventory       = $true
  AuthorizedVlans = $true
  EndpointGroupId = $true
}
Remove-MacmonEndpointProperty @Params
```
```
#no output
```
Remove all supported properties from endpoint with MACAddress '00-11-22-33-44-55'.

## PARAMETERS

### -HostName
IP-Address or Hostname of the macmon NAC

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TCPPort
TCP Port API (Default: 443)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 443
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiVersion
API Version to use (Default: 1.0)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1.0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credentials for the macmon NAC

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: (Get-Credential -Message 'Enter your credentials')
Accept pipeline input: False
Accept wildcard characters: False
```

### -MACAddress
MAC address of the endpoint

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Comment
Remove comments about the endpoint

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -StaticIps
Remove preset IP address(es) of the endpoint

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Inventory
Remove inventory number of the endpoint.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthorizedVlans
Remove blank space separated list of permitted VLAN IDs or VLAN names

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndpointGroupId
Remove ID of the group of the endpoint

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### none
## NOTES

## RELATED LINKS

[https://github.com/falkheiland/PSmacmon](https://github.com/falkheiland/PSmacmon)

[https://MACMONSERVER/man/index.php?controller=ApiDocuController](https://MACMONSERVER/man/index.php?controller=ApiDocuController)


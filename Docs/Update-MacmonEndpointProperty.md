---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Update-MacmonEndpointProperty.md
schema: 2.0.0
---

# Update-MacmonEndpointProperty

## SYNOPSIS
Update Endpoint Property from the macmon NAC via RESTAPI.

## SYNTAX

```
Update-MacmonEndpointProperty [-HostName] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-MACAddress] <String> [[-Comment] <String>] [[-Active] <String>]
 [[-IPAddress] <String[]>] [[-Inventory] <String>] [[-AuthorizedVlans] <String[]>] [[-EndpointGroupId] <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update Endpoint Property from the macmon NAC via RESTAPI.
Not all properties configurable per RESTAPI are available in this function.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  MACAddress = '00-11-22-33-44-55'
  Comment    = 'New Comment'
}
Update-MacmonEndpointProperty @Params
```
```
#no output
```
Update comment of endpoint with MACAddress '00-11-22-33-44-55'.

### Example 2
```powershell
$Params = @{
  Hostname        = 'MACMONSERVER'
  MACAddress      = '00-11-22-33-44-55'
  Comment         = 'New Comment'
  Active          = 'False'
  IPAddress       = '192.168.1.1', '10.10.10.11'
  Inventory       = '012345'
  AuthorizedVlans = '10', '20', '30'
  EndpointGroupId = 11
}
Update-MacmonEndpointProperty @Params
```
```
#no output
```
Update endpoint with MACAddress '00-11-22-33-44-55' (all provided properties).

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
Comments about the endpoint

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Active
String, True or False.
An inactive (deactivated) corporate device is evaluated as unauthorized.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPAddress
Preset IP address(es) of the endpoint

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: StaticIps

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Inventory
Inventory number of the endpoint.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthorizedVlans
Blank space separated list of permitted VLAN IDs or VLAN names

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndpointGroupId
ID of the Group of the endpoint

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
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



---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonCredential.md
schema: 2.0.0
---

# Get-MacmonCredential

## SYNOPSIS
Get Credentials from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonCredential -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>] [-Filter <String>] [<CommonParameters>]
```

### ID
```
Get-MacmonCredential -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-ID <Int32>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Credential from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
}
Get-MacmonCredential @Params
```
```
id          : 1
type        : SNMPv2Credential
description : Default SNMPv2c credential (r/o)
name        : SNMP-default (r/o)
properties  : @{traps=; read community=; write community=; contexts=}

id          : 2
type        : SNMPv2Credential
description : Default SNMPv2c credential (r/w)
name        : SNMP-default (r/w)
properties  : @{read community=; traps=; write community=; contexts=}
```
Get Credentials.

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Fields     = 'name,description'
}
2 | Get-MacmonCredential @Params
```
```
description                      name
-----------                      ----
Default SNMPv2c credential (r/w) SNMP-default (r/w)
```

Get name and description from Credential with ID 2.

### Example 3
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Filter     = 'type=="SSHCredential"'
}
Get-MacmonCredential @Params
```
```
id          : 4
type        : SSHCredential
description :
name        : SSH root (root)
properties  : @{password=; enablePassword=; username=}

id          : 5
type        : SSHCredential
description :
name        : SSH admin (admin)
properties  : @{password=; enablePassword=; username=}
```

Get SSH-Credentials.

## PARAMETERS

### -HostName
IP-Address or Hostname of the macmon NAC

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
Default value: (Get-Credential -Message 'Enter your credentials')
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
ID of the Cluster

```yaml
Type: Int32
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Fields
Select string (e.g. 'address,networkDeviceGroupId')

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sort
Sort string (e.g. 'active,address')

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
Limit int (e.g. 10)

```yaml
Type: Int32
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Offset
Offset int (e.g. 10)

```yaml
Type: Int32
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Filter string (e.g. '(id >=4 and id <= 10) and active == true and nac != true')

```yaml
Type: String
Parameter Sets: All
Aliases:

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

## NOTES

## RELATED LINKS

[https://github.com/falkheiland/PSmacmon](https://github.com/falkheiland/PSmacmon)

[https://MACMONSERVER/man/index.php?controller=ApiDocuController](https://MACMONSERVER/man/index.php?controller=ApiDocuController)


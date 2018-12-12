---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonNetworkDeviceClass.md
schema: 2.0.0
---

# Get-MacmonNetworkDeviceClass

## SYNOPSIS
Get Network Device Classes from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonNetworkDeviceClass -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>]
 [-Filter <String>] [<CommonParameters>]
```

### ID
```
Get-MacmonNetworkDeviceClass -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-ID <Int32>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Network Device Classes from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
}
Get-MacmonNetworkDeviceClass @Params
```
```
id                      : 1
description             : Template for all new classes
custom                  : CUSTOM_ORIGINAL
classifierType          : SysObjectIdClassifier
classifierValue         :
networkDeviceCategoryId :
networkDeviceCategory   :
methods                 : @{MacAddressesReadJob=; InterfaceManagementJob=; TopologyReadJob=; InterfacesReadJob=; Dot1xReadJob=; ArpReadJob=; VlanReadJob=;
                          InterfaceStatusReadJob=}
name                    : _ Default Template Class

id                      : 2
description             : DNS per Zoneload
custom                  : CUSTOM_NOT_IN_XML
classifierType          : ManualClassifier
classifierValue         : DNS Zoneload
networkDeviceCategoryId :
networkDeviceCategory   :
methods                 : @{DhcpReadJob=}
name                    : DNS Zoneload
```
Get all Network Device Classes (excerpt).

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Filter     = 'custom=="CUSTOM_ORIGINAL"'
  Fields     = 'name,classifierValue'
  Sort       = 'name,classifierValue'
}
(Get-MacmonNetworkDeviceClass @Params).where{$_.name -match '^HP ProCurve.*'} |
Select-Object -First 5
```
```
classifierValue                  name
---------------                  ----
1.3.6.1.4.1.11.2.3.7.11.33.1.1.1 HP ProCurve Blade Switch
1.3.6.1.4.1.11.2.3.7.11.131      HP ProCurve E2620-24-PPoE+ Switch
1.3.6.1.4.1.11.2.3.7.11.113      HP ProCurve E8206zl Switch
1.3.6.1.4.1.11.2.3.7.11.129      HP ProCurve Switch  E2620-24
1.3.6.1.4.1.11.2.3.7.11.75       HP ProCurve Switch 1700-24
```

Get classifierValue and name of the first 5 original Network Device Classes for 'HP ProCurve' devices sorted for name than classifierValue.

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
ID of the network device class

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
{{Fill Fields Description}}

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
{{Fill Sort Description}}

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
{{Fill Limit Description}}

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
{{Fill Offset Description}}

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
{{Fill Filter Description}}

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


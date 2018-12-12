---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonNetworkDevice.md
schema: 2.0.0
---

# Get-MacmonNetworkDevice

## SYNOPSIS
Get network device from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonNetworkDevice -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>]
 [-Filter <String>] [<CommonParameters>]
```

### ID
```
Get-MacmonNetworkDevice -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-ID <Int32>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get network device from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
}
Get-MacmonNetworkDevice @Params
```
```
id                    : 1
interfaces            : @{1=; 2=; 3=; 4=; 5=}
active                : True
enabledProtocols      : {snmpv3, snmpv2c, snmpv1, radius...}
location              :
description           : macmon Server
address               : localhost
ignoreHardwareChanges : True
webInterfaceUrl       :
userValues            :
credentials           : {}
vlans                 :
credentialIds         : {}
interfaceStatistic    : False
nac                   : True
networkDeviceClassId  : 339
networkDeviceClass    :
networkDeviceGroupId  : 5
networkDeviceGroup    :
dhcpEndpointGroupId   :
dhcpEndpointGroup     :
networkDeviceStatus   :

id                    : 2
interfaces            : @{22=; 23=; 24=; 2098=; 172=; 174=; 4192=; 136=; 97=; 10=; 11=; 12=; 13=; 14=; 15=; 16=; 17=; 18=; 19=; 1=; 2=; 3=; 201=; 146=; 2115=; 4=; 5=; 126=;
                        6=; 127=; 7=; 8=; 129=; 9=; 20=; 21=; 1207=}
active                : True
enabledProtocols      : {snmpv3, snmpv2c, snmpv1, radius...}
location              : location1
description           : Switch location1
address               : 192.168.3.51
ignoreHardwareChanges : False
webInterfaceUrl       : https://192.168.3.51
userValues            :
credentials           : {}
vlans                 : @{1=; 3=; 55=}
credentialIds         : {}
interfaceStatistic    : True
nac                   : True
networkDeviceClassId  : 63
networkDeviceClass    :
networkDeviceGroupId  : 14
networkDeviceGroup    :
dhcpEndpointGroupId   :
dhcpEndpointGroup     :
networkDeviceStatus   :
```
Get all network devices.

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Filter     = 'networkDeviceGroupId==14'
  Fields     = 'address,description'
  Sort       = 'description'
  Limit      = 3
}
Get-MacmonNetworkDevice @Params
```
```
description address
----------- -------
Switch1     192.168.3.1
Switch2     10.1.3.254
Switch3     192.168.3.5
```
Get address and description of first 3 network devices, sorted by description, from networkDeviceGroupId 14.

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
ID of the network device

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


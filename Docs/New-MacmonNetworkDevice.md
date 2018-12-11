---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon
schema: 2.0.0
---

# New-MacmonNetworkDevice

## SYNOPSIS
Create network device from the macmon NAC via RESTAPI.

## SYNTAX

```
New-MacmonNetworkDevice [-HostName] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Address] <String> [[-Active] <Boolean>] [[-Nac] <Boolean>]
 [[-NetworkDeviceClassId] <Int32>] [[-NetworkDeviceGroupId] <Int32>] [[-Description] <String>]
 [[-Location] <String>] [[-IgnoreHardwareChanges] <Boolean>] [[-EnabledProtocols] <String[]>]
 [[-InterfaceStatistic] <Boolean>] [[-WebInterfaceUrl] <String>] [[-CredentialIds] <Int32[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create network device from the macmon NAC via RESTAPI.
Not all properties configurable per RESTAPI are available in this function.

## EXAMPLES

### BEISPIEL 1
```
$Credential = Get-Credential -Message 'Enter your credentials'
```

New-MacmonNetworkDevice -Hostname 'MACMONSERVER' -Credential $Credential -Address '192.168.0.1'
#Ask for credential then create new network device with address '192.168.0.1' (minimum requirement)

### BEISPIEL 2
```
$Properties = @{
```

Hostname              = 'MACMONSERVER'
  address               = '192.168.3.1'
  active                = $true
  nac                   = $false
  ignoreHardwareChanges = $true
  enabledProtocols      = ('snmpv3', 'snmpv2c')
  interfaceStatistic    = $true
  networkDeviceClassId  = 84
  networkDeviceGroupId  = 14
  description           = 'New Device'
  location              = 'Cabinet 1'
  webInterfaceUrl       = 'https://NewDevice.acme.com'
  credentialIds         = 1, 2
}
New-MacmonNetworkDevice @Properties
#Create new network device with all supported (by function) properties

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

### -Address
IP address or DNS name used for the communication with the network device

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

### -Active
True, if query for the network device active.
(Default: True)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -Nac
True, if network access control active.
(Default: False)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NetworkDeviceClassId
Device class ID.
If no device class with the respective SNMP System ID exists yet, then it is automatically created.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -NetworkDeviceGroupId
Device group ID.
If no group is specified, only the SNMP basic data are queried from the network device.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Additional description of the network device.
If no description is given,
then it will be transferred from the corresponding SNMP property after the first scan of the network device.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
Location of the network device.
If no location is specified,
the value from the SNMP property sysLocation is transferred after the network device first scan.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreHardwareChanges
Activates the suppression of the generating of the device_changed event for this network device.
This makes sense, for instance, in switch clusters, where the base MAC address (SNMP-dot1dBaseBridgeAddress)
changes without the hardware having been changed.
(Default: False)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnabledProtocols
Protocols allowed for scanning.
(Default: 'snmpv3', 'snmpv2c', 'snmpv1', 'radius', 'ssh', 'telnet', 'http', 'ldap', 'dns')

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: ('snmpv3', 'snmpv2c', 'snmpv1', 'radius', 'ssh', 'telnet', 'http', 'ldap', 'dns')
Accept pipeline input: False
Accept wildcard characters: False
```

### -InterfaceStatistic
True, if interface statistics are generated.
(Default: False)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebInterfaceUrl
URL to the web interface of the network device

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CredentialIds
IDs for directly assigned credentials

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
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

### ID for the new network device
## NOTES

## RELATED LINKS

[https://github.com/falkheiland/PSmacmon](https://github.com/falkheiland/PSmacmon)

[https://<MACMONSERVER>/man/index.php?controller=ApiDocuController]()


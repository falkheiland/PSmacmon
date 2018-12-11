---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon
schema: 2.0.0
---

# New-MacmonEndpointGroup

## SYNOPSIS
Create Endpoint Group from the macmon NAC via RESTAPI.

## SYNTAX

```
New-MacmonEndpointGroup [-HostName] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-Name] <String> [[-Description] <String>] [[-MacStatisticActive] <String>]
 [[-MacValidity] <Int32>] [[-ObsoleteEndpointExpire] <Int32>] [[-AuthorizedVlansLow] <String[]>]
 [[-PermissionLow] <Int32>] [[-AuthorizedVlansMedium] <String[]>] [[-PermissionMedium] <Int32>]
 [[-AuthorizedVlansHigh] <String[]>] [[-PermissionHigh] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create Endpoint Group from the macmon NAC via RESTAPI.
Not all properties configurable per RESTAPI are available in this function.

## EXAMPLES

### BEISPIEL 1
```
$Credential = Get-Credential -Message 'Enter your credentials'
```

New-MacmonEndpointGroup -Hostname 'MACMONSERVER' -Credential $Credential -Name 'NewEndpointGroup'
#Ask for credential then create new endpointgroup with name 'NewEndpointGroup' (minimum requirement)

### BEISPIEL 2
```
$Properties = @{
```

Hostname               = 'MACMONSERVER'
  name                   = 'NewEndpointGroup'
  description            = 'new Endpoint-Group'
  macStatisticActive     = 'false'
  macValidity            = 14
  obsoleteEndpointExpire = 180
  authorizedVlansLow     = '10', '20', '30'
  permissionLow          = 2
  authorizedVlansMedium  = '20', '30'
  permissionMedium       = 3
  authorizedVlansHigh    = '30'
  permissionHigh         = 1
}
New-MacmonEndpointGroup @Properties
#Create new endpointgroup with all supported (by function) properties

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

### -Name
Unique name of the group

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

### -Description
Description of the group

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

### -MacStatisticActive
Enables the gathering of online statistics for this group.
(Default $true)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -MacValidity
Validity duration of the MAC addresses in the group in days.
(Default 0 =  no specification)

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

### -ObsoleteEndpointExpire
Number of days until no longer discovered and not manually changed MAC addresses are deenabled or deleted in the group.
A value of 0 disables the check of the obsolete_endpoint_expire for the group.
In this case, the setting configured under Settings --\> Scan engine is no longer taken into consideration for the group.
If an value of -1 is specified in the group, then the obsolete_mac_expire configured in the settings is used.
(0 = deactivated, default -1 = use global setting)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthorizedVlansLow
Authorized VLANs for authentication only based on MAC address
(e.g.
MAC address detected when scanning the switch interface or MAB - MAC Authentication Bypass) (MAC address only)

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

### -PermissionLow
Permission for authentication only based on MAC address
(e.g.
MAC address detected when scanning the switch interface or MAB - MAC Authentication Bypass) (MAC address only)
(-1 Deny; 1 Accept only (without VLAN); 2 Accept with VLAN; 3 Accept and VLAN (Default))

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthorizedVlansMedium
Authorized VLANs for authentication with identity and password via 802.1X

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PermissionMedium
Permission for authentication with identity and password via 802.1X
(-1 Deny; 1 Accept only (without VLAN); 2 Accept with VLAN; 3 Accept and VLAN (Default))

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthorizedVlansHigh
Authorized VLANs for authentication with certificate via 802.1X

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PermissionHigh
Permission for authentication with certificate via 802.1X
(-1 Deny; 1 Accept only (without VLAN); 2 Accept with VLAN; 3 Accept and VLAN (Default))

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 3
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

### ID for the new endpointgroup
## NOTES

## RELATED LINKS

[https://github.com/falkheiland/PSmacmon](https://github.com/falkheiland/PSmacmon)

[https://<MACMONSERVER>/man/index.php?controller=ApiDocuController]()


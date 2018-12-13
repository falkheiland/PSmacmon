---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Update-MacmonEndpointGroupProperty.md
schema: 2.0.0
---

# Update-MacmonEndpointGroupProperty

## SYNOPSIS
Update Endpoint Group Property from the macmon NAC via RESTAPI.

## SYNTAX

```
Update-MacmonEndpointGroupProperty [-HostName] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-ID] <Int32> [[-Name] <String>] [[-Description] <String>]
 [[-MacStatisticActive] <String>] [[-MacValidity] <Int32>] [[-ObsoleteEndpointExpire] <Int32>]
 [[-AuthorizedVlansLow] <String[]>] [[-PermissionLow] <Int32>] [[-AuthorizedVlansMedium] <String[]>]
 [[-PermissionMedium] <Int32>] [[-AuthorizedVlansHigh] <String[]>] [[-PermissionHigh] <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update Endpoint Group Property from the macmon NAC via RESTAPI.
Not all properties configurable per RESTAPI are available in this function.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  ID         = 194
  Name       = 'New Name'
}
Update-MacmonEndpointGroupProperty @Params
```
```
#no output
```
Update name of Endpoint Group with ID 194.

### Example 2
```powershell
$Params = @{
  Hostname               = 'MACMONSERVER'
  ID                     = 194
  Name                   = 'New Name'
  Description            = 'New Description'
  MacStatisticActive     = $true
  MacValidity            = 14
  ObsoleteEndpointExpire = 180
  AuthorizedVlansLow     = '10', '20', '30'
  PermissionLow          = 2
  AuthorizedVlansMedium  = '20', '30'
  PermissionMedium       = 3
  AuthorizedVlansHigh    = '30'
  PermissionHigh         = 1
}
Update-MacmonEndpointGroupProperty @Params
```
```
#no output
```
Update Endpoint Group with ID 194 (all provided properties).

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

### -ID
ID of the group

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the group

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

### -Description
Description of the group

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

### -MacStatisticActive
Enables the gathering of online statistics for this group.
(Default $true)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
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
Position: 9
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
Position: 10
Default value: 0
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
Position: 11
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
Position: 12
Default value: 0
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
Position: 13
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
Position: 14
Default value: 0
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
Position: 15
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
Position: 16
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


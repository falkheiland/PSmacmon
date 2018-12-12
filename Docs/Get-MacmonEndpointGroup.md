---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonEndpointGroup.md
schema: 2.0.0
---

# Get-MacmonEndpointGroup

## SYNOPSIS
Get Endpoint Group from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonEndpointGroup -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>]
 [-Filter <String>] [<CommonParameters>]
```

### ID
```
Get-MacmonEndpointGroup -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-ID <Int32>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Endpoint Group from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
}
Get-MacmonEndpointGroup @Params
```
```
id                        : 150
description               :
endpointGroupProperties   : {}
userValues                :
credentials               : {}
advancedSecurityProtocols : {}
authorizedVlansLow        : {6}
authorizedVlansMedium     : {}
authorizedVlansHigh       : {}
consumptionOn             : 0,0
consumptionOff            : 0,0
scanServicesActive        : False
obsoleteEndpointExpire    : 15552000000
macStatisticActive        : True
permissionLow             : 1
permissionMedium          : 3
permissionHigh            : 3
macValidity               :
credentialIds             : {}
portRequirements          : {}
name                      : Group1
properties                :

id                        : 151
description               :
endpointGroupProperties   : {}
userValues                :
credentials               : {}
advancedSecurityProtocols : {}
authorizedVlansLow        : {68}
authorizedVlansMedium     : {}
authorizedVlansHigh       : {}
consumptionOn             : 0,0
consumptionOff            : 0,0
scanServicesActive        : False
obsoleteEndpointExpire    : 15552000000
macStatisticActive        : True
permissionLow             : 1
permissionMedium          : 3
permissionHigh            : 3
macValidity               :
credentialIds             : {}
portRequirements          : {}
name                      : Group2
properties                :
```
Ask for credential then get Endpoint Group.

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Fields     = 'name,description'
  Filter     = 'id==0'
}
Get-MacmonEndpointGroup @Params
```
```
description name
----------- ----
Other       Default
```
Get name and description from Endpoint Group with ID 0.

### Example 3
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Fields     = 'name,obsoleteEndpointExpire'
  Sort       = 'obsoleteEndpointExpire,name'
}
(Get-MacmonEndpointGroup @Params).where{$_.obsoleteEndpointExpire}
```
```
obsoleteEndpointExpire name
---------------------- ----
            1209600000 Group7
            1209600000 Group8
           15552000000 Group1
           15552000000 Group3
```
Get name and obsoleteEndpointExpire from Endpoint Group with obsoleteEndpointExpire set, sorted by obsoleteEndpointExpire and name.

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
ID of the endpoint group

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


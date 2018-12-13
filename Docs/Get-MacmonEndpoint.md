---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonEndpoint.md
schema: 2.0.0
---

# Get-MacmonEndpoint

## SYNOPSIS
Get Endpoint from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonEndpoint -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>] [-Filter <String>] [<CommonParameters>]
```

### MAC
```
Get-MacmonEndpoint -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-MACAddress <String>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Endpoint from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
}
Get-MacmonEndpoint @Params
```
```
mac                  : 00-19-99-B4-2C-06
type                 : CORPORATE
comment              :
wakeupTime           :
active               : True
identityStoreId      : -1
staticIps            : {}
userValues           :
endpointGroup        :
inventory            :
created              : 2018-12-05T09:59:15.918Z
identity             : 00-19-99-B4-2C-06
lastChangeTime       : 2018-12-05T09:59:15.918Z
expireTime           :
authorizedVlans      : {}
endpointGroupId      : 120
endpointDeviceStatus :

mac                  : 00-19-99-B1-3C-15
type                 : CORPORATE
comment              :
wakeupTime           :
active               : True
identityStoreId      : -1
staticIps            : {}
userValues           :
endpointGroup        :
inventory            :
created              : 2018-12-05T09:59:15.918Z
identity             : PC012345.acme.org
lastChangeTime       : 2018-12-05T09:59:15.918Z
expireTime           :
authorizedVlans      : {}
endpointGroupId      : 102
endpointDeviceStatus :
```
Get all endpoints (excerpt).

### Example 2
```powershell
$Params = @{
  Hostname = 'MACMONSERVER'
  Fields   = 'mac,endpointDeviceStatus.lastIp'
  Sort     = '-mac'
  Limit    = 1
  Offset   = 10
  Filter   = 'endpointGroupId==150'
}
Get-MacmonEndpoint @Params
```
```
mac               endpointDeviceStatus
---               --------------------
F0-92-1C-64-C5-8F @{lastIp=192.168.6.17}
```
Get mac and lastIP address from 11th endpoint from endpointgroup with ID 150 sorted by mac descending.

### Example 3
```powershell
'00-00-FF-FF-FF-FF' | Get-MacmonEndpoint -Hostname 'MACMONSERVER'
```
```
mac                  : 00-00-FF-FF-FF-FF
type                 : CORPORATE
comment              :
wakeupTime           :
active               : False
identityStoreId      : -1
staticIps            : {}
userValues           :
endpointGroup        :
inventory            :
created              : 2018-12-05T09:59:15.917Z
identity             : 00-00-FF-FF-FF-FF
lastChangeTime       : 2018-12-05T09:59:15.917Z
expireTime           :
authorizedVlans      : {}
endpointGroupId      : 10
endpointDeviceStatus :
```
Get Endpoint with MACAddress '00-00-FF-FF-FF-FF'.

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

### -MACAddress
MAC Address of the endpoint group

```yaml
Type: String
Parameter Sets: MAC
Aliases:

Required: False
Position: Named
Default value: None
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


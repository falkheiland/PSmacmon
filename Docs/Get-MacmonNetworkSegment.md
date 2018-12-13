---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonNetworkSegment.md
schema: 2.0.0
---

# Get-MacmonNetworkSegment

## SYNOPSIS
Get network segment from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonNetworkSegment -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>]
 [-Filter <String>] [<CommonParameters>]
```

### ID
```
Get-MacmonNetworkSegment -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-ID <String>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get network segment from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Credential = Get-Credential -Message 'Enter your credentials'
Get-MacmonNetworkSegment -Hostname 'MACMONSERVER' -Credential $Credential
```
```
id               : 1.1.1.0/255.255.255.0
comment          :
broadcastAddress : 1.1.1.255
created          :
networkAddress   : 1.1.1.0
subnetMask       : 255.255.255.0

id               : 10.3.1.0/255.255.255.0
comment          :
broadcastAddress : 10.3.1.255
created          :
networkAddress   : 10.3.1.0
subnetMask       : 255.255.255.0
```
Get all network segments (excerpt).

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Filter     = 'id=="192.168.80.0/255.255.255.0"'
  Fields     = 'networkAddress,subnetMask,broadcastAddress'
}
Get-MacmonNetworkSegment @Params
```
```
broadcastAddress networkAddress subnetMask
---------------- -------------- ----------
192.168.80.255   192.168.80.0   255.255.255.0
```
Get networkAddress subnetMask and broadcastAddress of network segment with ID '192.168.80.0/255.255.255.0'.

### Example 3
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
}
"192.168.80.0/255.255.255.0" | Get-MacmonNetworkSegment @Params
```
```
id               : 192.168.80.0/255.255.255.0
comment          :
broadcastAddress : 192.168.80.255
created          :
networkAddress   : 192.168.80.0
subnetMask       : 255.255.255.0
```
Get network segment with ID '192.168.80.0/255.255.255.0'.

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
ID of the network segment ('192.168.80.0/255.255.255.0')

```yaml
Type: String
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


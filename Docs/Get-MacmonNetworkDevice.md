---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon
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

### BEISPIEL 1
```
$Credential = Get-Credential -Message 'Enter your credentials'
```

Get-MacmonNetworkDevice -Hostname 'MACMONSERVER' -Credential $Credential
#Ask for credential then get network device from macmon NAC using provided credential

### BEISPIEL 2
```
60 | Get-MacmonNetworkDevice -Hostname 'MACMONSERVER'
```

#Get network device with ID 60

### BEISPIEL 3
```
((Get-MacmonNetworkDevice -Hostname 'MACMONSERVER').where{$_.networkDeviceGroupId -eq 14}).description
```

#Get description of all network devices with networkDeviceGroupId 14

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

[https://<MACMONSERVER>/man/index.php?controller=ApiDocuController]()


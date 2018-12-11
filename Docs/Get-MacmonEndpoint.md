---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon
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

### BEISPIEL 1
```
$Credential = Get-Credential -Message 'Enter your credentials'
```

Get-MacmonEndpoint -Hostname 'MACMONSERVER' -Credential $Credential
#Ask for credential then get Endpoint from macmon NAC using provided credential

### BEISPIEL 2
```
$Params = @{
```

Hostname = 'MACMONSERVER'
  Fields   = 'mac,endpointDeviceStatus.lastIp'
  Sort     = '-mac'
  Limit    = 1
  Offset   = 10
  Filter   = 'endpointGroupId==150'
}
Get-MacmonEndpoint @Params
Get mac and lastIP address from 11th endpoint from endpointgroup with ID 150 sorted by mac descending

### BEISPIEL 3
```
'00-00-FF-FF-FF-FF' | Get-MacmonEndpoint -Hostname 'MACMONSERVER'
```

#Get Endpoint with MACAddress '00-00-FF-FF-FF-FF'

### BEISPIEL 4
```
(Get-MacmonEndpoint -Hostname 'MACMONSERVER').where{$_.endpointGroupId -eq 150}
```

#Get Endpoint with endpointGroupId 10

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


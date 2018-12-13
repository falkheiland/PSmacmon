---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonSystem.md
schema: 2.0.0
---

# Get-MacmonSystem

## SYNOPSIS
Get System Infos from the macmon NAC via RESTAPI.

## SYNTAX

### Version (Default)
```
Get-MacmonSystem -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-Version] [<CommonParameters>]
```

### Documentation
```
Get-MacmonSystem -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-Documentation] [<CommonParameters>]
```

### IPs
```
Get-MacmonSystem -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-IPs] [<CommonParameters>]
```

### Uptime
```
Get-MacmonSystem -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-Uptime] [<CommonParameters>]
```

## DESCRIPTION
Get System Infos from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Version    = $True
}
Get-MacmonSystem @Params
```
```
5.8.0-29046
```
Get the version of the system.

### Example 2
```powershell
Get-MacmonSystem -Hostname 'MACMONSERVER' -Documentation
```
```json
{
  "swagger" : "2.0",
  "info" : {
    "description" : "<!--- https://help...
    "version" : "1.0",
    "title" : "macmon engine API",
    "contact" : {
      "name" : "macmon secure GmbH",
      "url" : "https://macmon.eu",
      "email" : "support@macmon.eu"
    }
...
          "example" : "Name",
          "description" : "Name of the VLAN",
          "readOnly" : true
        }
      },
      "description" : "A VLAN of an network device"
    }
  }
}
```
Get the API docu as swagger JSON.

### Example 3
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  IPs        = $True
}
Get-MacmonSystem @Params
```
```
0:0:0:0:0:0:0:1
127.0.0.1
192.168.0.10
```
Get all local IP addresses of the system.

### Example 4
```powershell
Get-MacmonSystem -Hostname 'MACMONSERVER' -Uptime
```
```
7175562435
```
Get up time of the system in milliseconds.

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

### -Documentation
Get the API docu as swagger JSON

```yaml
Type: SwitchParameter
Parameter Sets: Documentation
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPs
Get all local IP addresses of the system

```yaml
Type: SwitchParameter
Parameter Sets: IPs
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uptime
Get up time of the system in milliseconds

```yaml
Type: SwitchParameter
Parameter Sets: Uptime
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
Get the version of the system

```yaml
Type: SwitchParameter
Parameter Sets: Version
Aliases:

Required: False
Position: Named
Default value: False
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


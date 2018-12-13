---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonSetting.md
schema: 2.0.0
---

# Get-MacmonSetting

## SYNOPSIS
Get Settings from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonSetting -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>] [-Filter <String>] [<CommonParameters>]
```

### ID
```
Get-MacmonSetting -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-ID <String>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Settings from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Credential = Get-Credential -Message 'Enter your credentials'
Get-MacmonSetting -Hostname 'MACMONSERVER' -Credential $Credential
```
```
id                                                  value
--                                                  -----
advanced_security.enabled                           1
advanced_security.learn_on_match
advanced_security.scan_delay                        2
advanced_security.scan_interval                     30
advanced_security.thread_pool_size                  50
advanced_security.unauthorized_endpoint_group
...
ui.permanent_login                                  1
ui.session_expire_time                              60
ui.userlink1
ui.userlink2
ui.userlinktitle1
ui.userlinktitle2
```
Get all Settings (excerpt).

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
}
(Get-MacmonSetting @Params).where{
  $_.id -match '^commands.wakeonlan.*'
}

```
```
id                             value
--                             -----
commands.wakeonlan_method      Directed Broadcast
commands.wakeonlan_port        9
commands.wakeonlan_repetitions 3
```
Get all settings related to WOL.

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
ID of the Settings

```yaml
Type: String
Parameter Sets: ID
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


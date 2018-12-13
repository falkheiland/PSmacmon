---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonUserReport.md
schema: 2.0.0
---

# Get-MacmonUserReport

## SYNOPSIS
Get User report from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonUserReport -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>] [-Filter <String>] [<CommonParameters>]
```

### ID
```
Get-MacmonUserReport -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>] [-Credential <PSCredential>]
 [-ID <Int32>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get User report from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Credential = Get-Credential -Message 'Enter your credentials'
Get-MacmonUserReport -Hostname 'MACMONSERVER' -Credential $Credential
```
```
id             : 2
shared         : False
type           : REPORT_WIDGET
description    :
created        : 2018-09-03T07:06:29Z
user           :
userId         : 1
parentReportId : deviceStatus
title          : deviceStatus 2018-08-14 17:51:22
updated        : 2018-10-08T13:31:53.789Z
reportAsJson   : {"identifier":"widget-deviceStatus-20180814175122","tables":{"DEVICE__T__DEVICE":{"legitimationTable":"DEVICE","virtualTableName":null,"reportObject":"DEVICE","fields":{"IP":{"legitimationField":...
link           : /reporting/index.php?controller=ReportController&group=net&report=deviceStatus&filter[DEVICE_JOB_STATUS___ERROR_COUNT]=>0&filter[DEVICE___ACTIVE]=1
reportId       : widget-deviceStatus-20180814175122

id             : 3
shared         : False
type           : REPORT_WIDGET
description    :
created        : 2018-09-03T07:06:29Z
user           :
userId         : 1
parentReportId : interfaceEvents
title          : Events with IF 2018-08-23 10:58:39
updated        : 2018-10-08T13:31:53.820Z
reportAsJson   : {"identifier":"widget-interfaceEvents-20180823105839"...
link           : /reporting/index.php?controller=ReportController&group=events&report=interfaceEvents&filter%5BEVENT_IF__T__EVENT__F__EVENT___CREATED%5D=-24+hours&sorting%5BEVENT_IF__T__EVENT__F__EVENT___CREATED%5D=desc
reportId       : widget-interfaceEvents-20180823105839
```
Get all user reports (excerpt).

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Filter     = 'type==REPORT_WIDGET'
  Fields     = 'id,title,reportId'
  Sort       = 'title'
}
Get-MacmonUserReport @Params
```
```
id title                                                    reportId
-- -----                                                    --------
 6 DHCP Endpoint Update endpoitIdentity 2018-09-17 13:27:59 widget-auditlogb50f666fda6a9c99a627ffd8e2326831-20180917132759
 3 Events with IF 2018-08-23 10:58:39                       widget-interfaceEvents-20180823105839
22 Inactive Endpoints 2018-10-08 15:31:40                   widget-authorizedMacsacb677da0c59aa103128703b36fa5168-20181008153140
 2 deviceStatus 2018-08-14 17:51:22                         widget-deviceStatus-20180814175122
 8 deviceStatus 2018-09-24 13:17:37                         widget-deviceStatus-20180924131737
10 deviceStatus 2018-09-24 13:22:35                         widget-deviceStatus-20180924132235
20 deviceStatus 2018-10-08 15:25:16                         widget-deviceStatus-20181008152516
28 deviceStatus 2018-12-12 07:55:25                         widget-deviceStatus-20181212075525
```

Get id, title and reportId from widget user reports, sorted by title

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
ID of the User report

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


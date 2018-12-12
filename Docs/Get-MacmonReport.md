---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonReport.md
schema: 2.0.0
---

# Get-MacmonReport

## SYNOPSIS
Get result of report as object or as file from the macmon NAC via RESTAPI.

## SYNTAX

```
Get-MacmonReport [-HostName] <String> [[-TCPPort] <Int32>] [[-ApiVersion] <String>]
 [[-Credential] <PSCredential>] [-ID] <String> [[-Format] <String>] [[-Path] <FileInfo>] [<CommonParameters>]
```

## DESCRIPTION
Get result of report as object or as file from the macmon NAC via RESTAPI.
If Parameter Path is provided, a file is created, without the Path the Result is provided as object.

## EXAMPLES

### Example 1
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  ID         = 'unauthorisedMacs'
}
Get-MacmonReport @Params
```
```
MAC               : 00-E0-C5-26-43-3H
Active            : 0
Manufacturer      : BCOM ELECTRONICS INC.
Last IP           : 10.1.1.120
Last DNS name     : iphone.acme.org
Operating system  :
Network device    : 192.168.3.51
ifIndex           : 9
ifName            : 9
ifAlias           :
First seen (IF)   : 2018-11-09 10:38:08
Last seen (IF)    : 2018-11-19 19:59:20
MAC VLAN name     : Computer1
Network device ID : 2

MAC               : 00-E0-C5-35-AD-2B
Active            :
Manufacturer      : BCOM ELECTRONICS INC.
Last IP           :
Last DNS name     :
Operating system  :
Network device    : 10.6.6.151
ifIndex           : 32
ifName            : 32
ifAlias           :
First seen (IF)   : 2018-10-25 09:45:53
Last seen (IF)    : 2018-10-25 09:45:53
MAC VLAN name     : Printer1
Network device ID : 14
```
Get result of the report with ReportID 'unauthorisedMacs'.

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  ID         = 'authorizedMacs'
}
(Get-MacmonReport @Params).where{
  $_."Network device ID" -eq 38
} |
  Select-Object -Property MAC, Group, "Last DNS name", ifIndex |
Sort-Object -Property ifIndex
```
```
MAC               Group    Last DNS name                ifIndex
---               -----    -------------                -------
00-1B-E8-2D-F6-77 Voice1   17.acme.org                  1
00-1B-E8-38-65-EC Voice1   20.acme.org                  10
5E-D2-13-01-61-6C GLT      ev2.acme.org                 15
5E-D2-13-01-61-69 GLT      ev1.acme.org                 15
5E-D2-13-01-62-83 GLT      ev3.acme.org                 15
5E-D2-13-01-6A-AE GLT      as1.acme.org                 16
00-26-6C-CB-1B-13 WLAN1    ap1.acme.org                 17
D8-C7-C8-C2-D5-18 WLAN1    ap2.acme.org                 18
6C-E3-7F-C5-AF-A5 WLAN1    ap3.acme.org                 19
6C-E3-7F-C5-AF-B8 WLAN1    ap4.acme.org                 20
00-0F-0D-26-33-99 SM1                                   22
00-1B-E8-30-85-4C Voice01  37.acme.org                  3
C8-CB-B8-5C-B4-32 Printer1 hpclj400.acme.org            4
00-19-99-6C-BF-BF Comp3    pc01234.acme.org             5
00-1B-E8-2E-29-BF Voice1   16.acme.org                  6
30-E1-71-3C-D0-D0 Printer1 hpljm402.acme.org            7
00-00-85-DD-80-AD Printer1 canonir3225.acme.org         8
90-1B-0F-2D-83-65 Comp3    pc033333.acme.org            9
```
Get info from devices on network device with ID 38 from report with ID 'authorizedMacs'.

### Example 3
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  ID         = 'authorizedMacsacb677da0c59aa103128703b36fa5168'
  Format     = 'pdf'
  Path       = $env:TEMP
}
Get-MacmonReport @Params
```
Get result of report with ReportID 'authorizedMacsacb677da0c59aa103128703b36fa5168' as pdf-file to 'C:\Temp\authorizedMacsacb677da0c59aa103128703b36fa5168.pdf'.

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
ID of the report (e.g.
'authorizedMacs0cbc6611f5540bd0809a388dc95a615b')

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Format
Format of the Result ('csv', ('pdf' or 'xlsx' does not work atm)), (Default: 'csv').

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Csv
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path to Folder to save File to.
If Path is provided, a file is created, without the Path the Result is provided as object.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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

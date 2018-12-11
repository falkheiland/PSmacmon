---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon
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

### BEISPIEL 1
```
$Credential = Get-Credential -Message 'Enter your credentials'
```

Get-MacmonReport -Hostname 'MACMONSERVER' -Credential $Credential -ID 'authorizedMacs0cbc6611f5540bd0809a388dc95a615b'
#Ask for credential then get result of the report with ReportID 'authorizedMacs0cbc6611f5540bd0809a388dc95a615b' from macmon NAC using provided credential

### BEISPIEL 2
```
'unauthorisedMacs' | Get-MacmonReport -Hostname 'MACMONSERVER' -Format 'csv' -Path 'C:\Temp\'
```

#Get result of report with ReportID 'unauthorisedMacs' as file to 'C:\Temp\unauthorisedMacs.csv'

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

[https://<MACMONSERVER>/man/index.php?controller=ApiDocuController]()


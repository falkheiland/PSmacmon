---
external help file: PSmacmon-help.xml
Module Name: PSmacmon
online version: https://github.com/falkheiland/PSmacmon/blob/master/Docs/Get-MacmonLicenseOption.md
schema: 2.0.0
---

# Get-MacmonLicenseOption

## SYNOPSIS
Get License Option from the macmon NAC via RESTAPI.

## SYNTAX

### All (Default)
```
Get-MacmonLicenseOption -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-Fields <String>] [-Sort <String>] [-Limit <Int32>] [-Offset <Int32>]
 [-Filter <String>] [<CommonParameters>]
```

### Name
```
Get-MacmonLicenseOption -HostName <String> [-TCPPort <Int32>] [-ApiVersion <String>]
 [-Credential <PSCredential>] [-Name <String>] [-Fields <String>] [<CommonParameters>]
```

## DESCRIPTION
Get License Option from the macmon NAC via RESTAPI.

## EXAMPLES

### Example 1
```powershell
$Credential = Get-Credential -Message 'Enter your credentials'
Get-MacmonLicenseOption -Hostname 'MACMONSERVER' -Credential $Credential
```
```
name           : 802.1X
expiration     :
licenseFile    :
limits         : {}
disabledReason :
properties     : {}

name           : ADVANCED_SECURITY
expiration     :
licenseFile    :
limits         : {}
disabledReason :
properties     : {}
```
Get all license options.

### Example 2
```powershell
$Params = @{
  Hostname   = 'MACMONSERVER'
  Credential = Get-Credential
  Fields     = 'name,limits.name.maclimit,limits.limit.maclimit,limits.current.maclimit'
  Filter     = 'name==OBSERVER'
}
$LicenseColl = Get-MacmonLicenseOption @Params
$LicenseOptionColl = foreach ($License in $LicenseColl)
{
  foreach ($LicenseLimit in $License.limits)
  {
    [pscustomobject]@{
      license      = $License.name
      limitname    = $LicenseLimit.name
      limitmax     = $LicenseLimit.limit
      limitcurrent = $LicenseLimit.current
    }
  }
}
$LicenseOptionColl
```
```
license  limitname   limitmax limitcurrent
-------  ---------   -------- ------------
OBSERVER maclimit        1500         1318
OBSERVER devicelimit                   116
OBSERVER guestlimit      2400            0
```
Create Object from license options for 'OBSERVER'-license.

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

### -Name
Name of the License Option

```yaml
Type: String
Parameter Sets: Name
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


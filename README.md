# PSmacmon

This is a module to interact with the macmon NAC API (https://www.macmon.eu/).

To connect to the API it is required to provide a credential:

```powershell
$Credential = Get-Credential -Message 'Enter your credentials'
```

If you did not provide a credential, one will be created.

My goal is to support all API-functionalities. Suggestions are welcome.

## Installation

If you have the [PowerShellGet](https://github.com/powershell/powershellget) module installed you can enter the following command:

```powershell
Install-Module -Name PSmacmon
```

Alternatively you can download a ZIP file of the latest version from our [Releases](https://github.com/falkheiland/PSmacmon/releases) page.

## Functions

### [Get-MacmonCredential](/Docs/Get-MacmonCredential.md)
Get Credentials.

### [Get-MacmonEndpoint](/Docs/Get-MacmonEndpoint.md)
Get Endpoint.

### [Get-MacmonEndpointGroup](/Docs/Get-MacmonEndpointGroup.md)
Get Endpoint Group.

### [Get-MacmonLicenseOption](/Docs/Get-MacmonLicenseOption.md)
Get License Option.

### [Get-MacmonNetworkDevice](/Docs/Get-MacmonNetworkDevice.md)
Get Network Device.

### [Get-MacmonNetworkDeviceClass](/Docs/Get-MacmonNetworkDeviceClass.md)
Get Network Device Class.

### [Get-MacmonNetworkDeviceGroup](/Docs/Get-MacmonNetworkDeviceGroup.md)
Get Network Device Group.

### [Get-MacmonNetworkSegment](/Docs/Get-MacmonNetworkSegment.md)
Get Network Segment.

### [Get-MacmonReport](/Docs/Get-MacmonReport.md)
Get result of report as object or as file.

### [Get-MacmonSetting](/Docs/Get-MacmonSetting.md)
Get Setting.

### [Get-MacmonSystem](/Docs/Get-MacmonSystem.md)
Get System Info.

### [Get-MacmonUserProperty](/Docs/Get-MacmonUserProperty.md)
Get User Property.

### [Get-MacmonUserReport](/Docs/Get-MacmonUserReport.md)
Get User Report.

### [New-MacmonEndpoint](/Docs/New-MacmonEndpoint.md)
Create Endpoint.

### [New-MacmonEndpointGroup](/Docs/New-MacmonEndpointGroup.md)
Create Endpoint Group.

### [New-MacmonNetworkDevice](/Docs/New-MacmonNetworkDevice.md)
Create Network Device.

### [Remove-MacmonEndpointProperty](/Docs/Remove-MacmonEndpointProperty.md)
Remove Endpoint Property.

### [Update-MacmonEndpointGroupProperty](/Docs/Update-MacmonEndpointGroupProperty.md)
Update Endpoint Group Property.

### [Update-MacmonEndpointProperty](/Docs/Update-MacmonEndpointProperty.md)
Update Endpoint Property.


## Private functions

### Invoke-MacmonRestMethod

Invoke-RestMethod Wrapper

### Invoke-MacmonTrustSelfSignedCertificate

Trust self-signed certificates

### Get-MacmonFunctionString

Create function string
# PSmacmon

This is a module to interact with the macmon NAC API (https://www.macmon.eu/).

To connect to the API it is required to provide a credential:

```powershell
$Credential = Get-Credential -Message 'Enter your credentials'
```

If you did not provide a credential, one will be created.

My goal is to support all API-functionalities. Suggestions are welcome.

## Functions

### [Get-MacmonCredential](Get-MacmonCredential.md)
Get Credentials.

### [Get-MacmonEndpoint](Get-MacmonEndpoint.md)
Get Endpoint.

### [Get-MacmonEndpointGroup](Get-MacmonEndpointGroup.md)
Get Endpoint Group.

### [Get-MacmonLicenseOption](Get-MacmonLicenseOption.md)
Get License Option.

### [Get-MacmonNetworkDevice](Get-MacmonNetworkDevice.md)
Get Network Device.

### [Get-MacmonNetworkDeviceClass](Get-MacmonNetworkDeviceClass.md)
Get Network Device Class.

### [Get-MacmonNetworkDeviceGroup](Get-MacmonNetworkDeviceGroup.md)
Get Network Device Group.

### [Get-MacmonNetworkSegment](Get-MacmonNetworkSegment.md)
Get Network Segment.

### [Get-MacmonReport](Get-MacmonReport.md)
Get result of report as object or as file.

### [Get-MacmonSetting](Get-MacmonSetting.md)
Get Setting.

### [Get-MacmonSystem](Get-MacmonSystem.md)
Get System Info.

### [Get-MacmonUserProperty](Get-MacmonUserProperty.md)
Get User Property.

### [Get-MacmonUserReport](Get-MacmonUserReport.md)
Get User Report.

### [New-MacmonEndpoint](New-MacmonEndpoint.md)
Create Endpoint.

### [New-MacmonEndpointGroup](New-MacmonEndpointGroup.md)
Create Endpoint Group.

### [New-MacmonNetworkDevice](New-MacmonNetworkDevice.md)
Create Network Device.

### [Remove-MacmonEndpointProperty](Remove-MacmonEndpointProperty.md)
Remove Endpoint Property.

### [Update-MacmonEndpointGroupProperty](Update-MacmonEndpointGroupProperty.md)
Update Endpoint Group Property.

### [Update-MacmonEndpointProperty](Update-MacmonEndpointProperty.md)
Update Endpoint Property.


## Private functions

### Invoke-MacmonRestMethod

Invoke-RestMethod Wrapper

### Invoke-MacmonTrustSelfSignedCertificate

Trust self-signed certificates

### Get-MacmonFunctionString

Create function string
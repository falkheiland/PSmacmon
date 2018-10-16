# PSmacmon

This is a module to interact with the macmon NAC API (https://www.macmon.eu/).

To connect to the API it is required to provide a credential:

```powershell
$Credential = Get-Credential -Message 'Enter your credentials'
```

If you did not provide a credential, one will be created.

My goal is to support all API-functionalities. Suggestions are welcome.

## Functions

### Get-MacmonCredential

Gets Credentials.

### Get-MacmonEndpoint

Gets Endpoints.

### Get-MacmonEndpointGroup

Gets Endpoint Groups.

### Get-MacmonLicenseOption

Gets License Options.

### Get-MacmonNetworkDevice

Gets Network Devices.

### Get-MacmonNetworkDeviceClass

Gets Network Device Classes.

### Get-MacmonNetworkDeviceGroup

Gets Network Device Groups.

### Get-MacmonNetworkSegment

Gets Network Segments.

### Get-MacmonReport

Gets Results of Reports.

### Get-MacmonSetting

Gets Settings.

### Get-MacmonSystem

Gets System Information.

### Get-MacmonUserProperty

Gets User Properties.

### Get-MacmonUserReport

Gets User Reports.

### New-MacmonEndpoint

Creates Endpoints.

### New-MacmonEndpointGroup

Creates Endpoint Groups.

### New-MacmonNetworkDevice

Creates Network Devices.

### Remove-MacmonEndpointProperty

Removes Endpoint Properties.

### Update-MacmonEndpointGroupProperty

Updates Endpoint Group Properties.

### Update-MacmonEndpointProperty

Updates Endpoint Properties.

## Private functions

### Invoke-MacmonRestMethod

Invoke-RestMethod Wrapper

### Invoke-MacmonTrustSelfSignedCertificate

Trust self-signed certificates
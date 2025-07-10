param location string
param privateDnsZoneName string = 'privatednszone.amir.com'
param virtualNetworkId string
param virtualNetworkname string


// Note: Bicep cannot validate properties for 'Microsoft.Network/privateDnsZones@2021-02-01'.
// This warning does not block deployment.
resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZoneName
  location: location
}

resource vnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: '${virtualNetworkname}-link'
  properties: {
    virtualNetwork: {
      id: virtualNetworkId
    }
    registrationEnabled: true
  }
}
 
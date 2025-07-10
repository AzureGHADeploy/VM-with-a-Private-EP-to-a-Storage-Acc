param privateDnsZoneName string = 'privatelink.blob.${environment().suffixes.storage}'
param virtualNetworkId string
param virtualNetworkname string


// Note: Bicep cannot validate properties for 'Microsoft.Network/privateDnsZones@2021-02-01'.
// This warning does not block deployment.
resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZoneName
  location: 'global' // Private DNS zones are global resources
}

resource vnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: '${virtualNetworkname}-link'
  parent: privateDnsZone
  location: 'global' // Private DNS zones are global resources
  properties: {
    virtualNetwork: {
      id: virtualNetworkId
    }
    registrationEnabled: false
  }
}

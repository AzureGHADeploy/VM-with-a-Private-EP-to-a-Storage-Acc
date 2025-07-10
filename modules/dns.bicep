param privateDnsZoneName string = 'privatednszone.amir.com'
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
    registrationEnabled: true
  }
}
resource dnsrecord 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  name: 'privateEP'
  parent: privateDnsZone
  properties: {
    ttl: 3600 // Time to live in seconds
    aRecords: [
      {
        ipv4Address: '10.1.1.4'
      }
    ]
  }
} 

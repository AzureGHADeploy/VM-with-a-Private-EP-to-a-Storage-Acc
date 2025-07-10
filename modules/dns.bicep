param location string
param privateDnsZoneName string = 'privatednszone.amir.com'
param virtualNetworkId string
param virtualNetworkname string


resource privateDnsZone 'Microsoft.Network/privateDnsZones@2021-02-01' = {
  name: privateDnsZoneName
  location: location
}

resource vnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2021-02-01' = {
  name: virtualNetworkname
  properties: {
    virtualNetwork: {
      id: virtualNetworkId
    }
    registrationEnabled: true
  }
}
 
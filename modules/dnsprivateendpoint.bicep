param location string
param subnetId string
param storageAccountId string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-02-01' = {
  name: 'privateEndpointName'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'storageConnection'
        properties: {
          privateLinkServiceId: storageAccountId
          groupIds: ['blob']
        }
      }
    ]
  }
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2021-02-01' = {
  name: privateDnsZoneName
  location: location
  properties: {
    customNetworkAccessPolicies: [
      {
        id: privateEndpoint.id
      }
    ]
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateDnsZoneGroups@2021-02-01' = {
  name: 'default'
  location: location
  properties: {
    privateDnsZoneIds: [
      privateDnsZone.id
    ]
  }
}

param privateDnsZoneName string = 'privatelink.blob.${environment().suffixes.storage}' // Default private DNS zone for Azure Blob Storage
param virtualNetworkId string
param virtualNetworkname string
param storageaccountName string
param storagePrivateIp string // The private IP address of the storage account's private endpoint


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
resource aRecord 'Microsoft.Network/privateDnsZones/A@2020-06-01' = {
  name: storageaccountName // The subdomain part (i.e., <name>.privatelink.blob.core.windows.net)
  parent: privateDnsZone
  properties: {
    ttl: 300
    aRecords: [
      {
        ipv4Address: storagePrivateIp
      }
    ]
  }
}

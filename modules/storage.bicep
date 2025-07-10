param location string
param subnetId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'strgaccpep2463587tfvg'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}
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
          privateLinkServiceId: storageAccount.id
          groupIds: ['blob']
        }
      }
    ]
  }
}


output storageAccountId string = storageAccount.id

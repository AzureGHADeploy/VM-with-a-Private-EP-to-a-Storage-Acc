param location string

param pepSubnetId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: 'strgaccpep2463587tfvg'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Disabled' // Disable public network access
    allowBlobPublicAccess: false // Disable public access to blobs
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  name: 'default'
  parent: storageAccount
}
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  name: 'asd'
  parent: blobService
  properties: {
    publicAccess: 'None'
  }
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-02-01' = {
  name: 'privateEndpointName'
  location: location
  properties: {
    subnet: {
      id: pepSubnetId
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
output privateEndpointId string = privateEndpoint.id
output storageaccountName string = storageAccount.name

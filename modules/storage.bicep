param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'strgaccpep-${uniqueString(resourceGroup().id)}' // Unique name for the storage account
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

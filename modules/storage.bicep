param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'strgaccpep2463587tfvg'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}

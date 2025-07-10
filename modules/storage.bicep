param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'storageaccwithPEP'
  location: location
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

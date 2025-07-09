param location string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: 'VMVNET'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'VMsubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
} 

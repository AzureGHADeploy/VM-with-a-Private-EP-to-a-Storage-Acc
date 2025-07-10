// File: main.bicep

param location string = resourceGroup().location

// Call the network module
module networkModule 'modules/network.bicep' = {
  name: 'deployNetwork'
  params: {
    location: location
  }
}

// Call the storage module
module storageModule 'modules/storage.bicep' = {
  name: 'deployStorage'
  params: {
    location: location
  }
}

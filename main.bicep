// File: main.bicep

param location string = resourceGroup().location
@secure()
param adminPassword string

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
    pepSubnetId: networkModule.outputs.pepSubnetId // Use the PEP subnet ID from the network module
  }
}
module computeModule 'modules/compute.bicep' = {
  name: 'deployCompute'
  params: {
    location: location
    subnetId: networkModule.outputs.subnetId // Use the subnet ID from the network module
    adminPassword: adminPassword
  }
}

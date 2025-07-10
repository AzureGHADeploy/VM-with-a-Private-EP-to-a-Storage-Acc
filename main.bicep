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
module dnsModule 'modules/dns.bicep' = {
  name: 'deployDns'
  params: {
    location: location
    privateDnsZoneName: 'privatednszone.amir.com'
    virtualNetworkname: networkModule.outputs.virtualNetworkname // Use the virtual network name from the network module
    virtualNetworkId: networkModule.outputs.virtualNetworkId // Use the virtual network ID from the network module
  }
}

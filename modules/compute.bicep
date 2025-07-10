param location string
param adminUsername string = 'azureuser'
param adminPassword string = 'P@ssw0rd1234!'
param subnetId string

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: 'myVMNIC'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'myVMIPConfig'
        properties: {
          subnet: {
            id: subnetId // Reference the subnet ID from the network module
          }
          privateIPAllocationMethod: 'Static'
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'myVM'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_b1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: 'myVM'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
}

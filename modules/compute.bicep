param location string
param adminUsername string = 'azureuser'
@secure()
param adminPassword string 
param subnetId string

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: 'myVMNIC'
  location: location
  properties: {
    networkSecurityGroup: {
      id: networksecurityGroup.id // Reference the network security group resource
    }
    ipConfigurations: [
      {
        name: 'myVMIPConfig'
        properties: {
          subnet: {
            id: subnetId // Reference the subnet ID from the network module
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id // Reference the public IP address resource
          }
        }
      }
    ]
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'myVMPublicIP'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource networksecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'myVMNSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowRDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
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

param location string
param environmentName string
param tags object

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'vnet-fabric-${environmentName}'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: ['10.30.0.0/16']
    }
    subnets: [
      {
        name: 'snet-private-endpoints'
        properties: {
          addressPrefix: '10.30.0.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output privateEndpointSubnetId string = vnet.properties.subnets[0].id
